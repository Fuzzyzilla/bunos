extends KinematicBody2D

export var constant_scale := 1.0

onready var GRAVITY = 1500 * constant_scale
onready var JUMP_VELOCITY = 600 * constant_scale
onready var MAX_WALK_SPEED = 400 * constant_scale
const FLOOR_FRICTION_FACTOR = 0.7
const AIR_FRICTION_FACTOR = 0.95
onready var BIG_FALL_SPEED = 600 * constant_scale

const CYOTE_TIME := 0.1
const BUFFER_TIME := 0.1

var velocity := Vector2.ZERO

var current_interactable : Node2D

var cyote_time := 0.0
var buffer_time := 0.0

var walking := false
var jumping := false
var interacting := false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if not interacting:
		if Input.is_action_pressed("ui_left"):
			velocity.x = -MAX_WALK_SPEED
			walking = true
		elif Input.is_action_pressed("ui_right"):
			velocity.x = MAX_WALK_SPEED
			walking = true
		else:
			walking = false
			
		#jumping
		if Input.is_action_just_pressed("ui_up"):
			buffer_time = BUFFER_TIME
		
		if buffer_time > 0 and cyote_time < CYOTE_TIME:
			cyote_time = 10000
			jumping = true
			velocity.y = -JUMP_VELOCITY
			$Jump.play()
			
		#jump cancel
		if Input.is_action_just_released("ui_up"):
			if velocity.y < 0 and jumping: #if moving up...
				velocity.y *= 0.7
		
		#interact
		if Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("ui_accept"):
			velocity.x = 0
			interact()
			
			
		if Input.is_action_just_pressed("ui_reset"):
			get_tree().root.get_child(0).reset_level()
	
	buffer_time -= delta
	
	var big_fall = velocity.y > BIG_FALL_SPEED
	
	velocity.y += GRAVITY * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	
	var falling := velocity.y > 0.0
	
	if falling:
		jumping = false
	
	if big_fall and not falling:
		$Hit.play()
	
	var friction_factor := 0.0
	
	if is_on_floor():
		cyote_time = 0
		friction_factor = FLOOR_FRICTION_FACTOR
		jumping = false
	else:
		cyote_time += delta
		friction_factor = AIR_FRICTION_FACTOR
		
	if not walking:
		velocity.x *= friction_factor
		
	#Animation stufs
	if not interacting:
		if jumping:
			play_or_continue("Jump" + movement_direction_suffix());
		else:
			if falling:
				play_or_continue("Fall" + movement_direction_suffix())
			elif walking and velocity.x != 0:
				play_or_continue("Walk" + movement_direction_suffix())
			else:
				play_or_continue("Idle")

func movement_direction_suffix() -> String:
	if abs(velocity.x) < 0.5:
		return ""
	elif velocity.x > 0:
		return " Right"
	else:
		return " Left"

func enter_interactable_area(area):
	current_interactable = area
	$"interact arrow/AnimationPlayer".play("Open")
	
func exit_interactable_area(area):
	if current_interactable == area:
		current_interactable = null
		$"interact arrow/AnimationPlayer".play("Close")

func interact():
	if current_interactable:
		interacting = true
		$AnimationPlayer.play("Kneel")

func interact_anim_finished():
	if current_interactable:
		current_interactable.interact(self)
	else:
		end_interact()

func end_interact():
	$AnimationPlayer.play("Unkneel")

func end_interact_anim_finished():
	interacting = false

func play_or_continue(anim : String):
	if $AnimationPlayer.current_animation != anim:
		$AnimationPlayer.play(anim)
		
func deathbox_enter():
	var world = get_tree().root.get_child(0)
	if world:
		world.reset_level()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

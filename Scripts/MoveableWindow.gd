extends StaticBody2D

export var can_move_vertical := true
export var can_move_horizontal := true

const MOVEMENT_SPEED = 150

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if not $Interactable.interacting: return
	
	var horiz = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var vert = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	horiz *= 1 if can_move_horizontal else 0
	vert *= 1 if can_move_vertical else 0
	
	if Input.is_action_just_pressed("ui_cancel") or Input.is_action_just_pressed("ui_accept"):
		$Interactable.end_interact()
	
	position += Vector2(horiz, vert) * MOVEMENT_SPEED * delta
	var player = $Interactable.player
	if player:
		player.position += Vector2(horiz, vert) * MOVEMENT_SPEED * delta

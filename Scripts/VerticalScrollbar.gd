extends Node2D

export var height := 300
export var start_pos := 100
export var going_up := true

const SPEED := 100
const MARGIN := 18 + 68

# Called when the node enters the scene tree for the first time.
func _ready():
	$Bar.position.y = start_pos
	$Dashes.rect_size.x = height

func _physics_process(delta):
	if not $Bar/Interactable.interacting: return
	if not (Input.is_action_pressed("ui_accept") or Input.is_action_pressed("ui_down")):
		$Bar/Interactable.end_interact()
	else:
		var movement = SPEED * delta * (-1.0 if going_up else 1.0)
		$Bar.position.y += movement
		var player = $Bar/Interactable.player
		if player:
			player.position.y += movement
			
		
		if $Bar.position.y < 0 or $Bar.position.y > height:
			going_up = not going_up

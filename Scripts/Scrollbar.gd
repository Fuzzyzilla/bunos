extends Node2D

export var width := 300
export var start_pos := 100
export var going_left := true

const SPEED := 100
const MARGIN := 18 + 68

# Called when the node enters the scene tree for the first time.
func _ready():
	$Button2.position.x = width
	$Bar.position.x = start_pos
	$Bar.position.x = clamp($Bar.position.x, MARGIN, width-MARGIN)
	$Dashes.rect_size.x = width

func _physics_process(delta):
	var interacting = $Button/Interactable.interacting or $Button2/Interactable.interacting
	if not interacting: return
	if not (Input.is_action_pressed("ui_accept") or Input.is_action_pressed("ui_down")):
		$Button/Interactable.end_interact()
		$Button2/Interactable.end_interact()
	else:
		$Bar.position.x += SPEED * delta * (-1.0 if going_left else 1.0)
		
		if $Bar.position.x < MARGIN or $Bar.position.x > (width-MARGIN):
			going_left = not going_left
		
		$Bar.position.x = clamp($Bar.position.x, MARGIN, width-MARGIN)

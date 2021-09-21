extends StaticBody2D

const MOVEMENT_SPEED = 300

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Interactable_interacted():
	$AnimationPlayer.play("Close")


func _on_animation_finished(_anim_name):
	queue_free()

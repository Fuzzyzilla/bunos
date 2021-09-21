extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var dragged := false
var disabled := false
var offset := Vector2.ZERO

var motion := Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	position += motion
	motion = Vector2.ZERO

func _unhandled_input(event):
	if event is InputEventMouseButton:
		var mouse = event as InputEventMouseButton
		#check if we just got clicked:
		if mouse.button_index == BUTTON_LEFT:
			if mouse.pressed:
				var top_right = global_position - $CollisionShape2D.shape.extents
				var bottom_left = global_position + $CollisionShape2D.shape.extents
				
				var rect := Rect2(top_right, bottom_left-top_right)
				if rect.has_point(mouse.global_position):
					dragged = true
					offset = mouse.global_position - global_position
			else:
				dragged = false
	elif event is InputEventMouseMotion:
		if disabled or not dragged: return
		var mouse = event as InputEventMouseMotion
		motion += mouse.relative

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_body_entered(body):
	if body.name == "Bun":
		disabled = true


func _on_body_exited(body):
	if body.name == "Bun":
		disabled = false



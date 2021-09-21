extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$StaticBody2D/CollisionShape2D.shape = $StaticBody2D/CollisionShape2D.shape.duplicate()
	var shape = $StaticBody2D/CollisionShape2D
	var size = rect_size
	shape.position = size/2
	shape.shape.extents = size/2


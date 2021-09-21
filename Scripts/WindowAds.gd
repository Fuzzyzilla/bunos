extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var children = get_children()
	var chosen_one = randi() % children.size()
	for child in children:
		child.visible = chosen_one == 0
		chosen_one -= 1
		if not child.visible:
			remove_child(child)
			child.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

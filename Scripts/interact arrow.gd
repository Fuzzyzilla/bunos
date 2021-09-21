extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if not get_parent().is_in_group("Player"):
		self_modulate.a = 0
		$"White".visible = true
		scale = Vector2(0.25, 0.25)
	else:
		$"White".visible = false

extends StaticBody2D

export var default_text := "hello"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$CollisionShape2D.shape = $CollisionShape2D.shape.duplicate()
	$Label.text = default_text
	calc_collision()
	pass # Replace with function body.

func _process(_delta):
	$"interact arrow".visible = $Interactable.interacting

func calc_collision():
	if $Label.text.length() == 0:
		$CollisionShape2D.disabled = true
		$Interactable/CollisionShape2D.disabled = true
	else:
		$CollisionShape2D.disabled = false
		var size = $Label.get_combined_minimum_size()
		$CollisionShape2D.position = size/2
		$CollisionShape2D.shape.extents = size/2
		
		$Interactable/CollisionShape2D.position.x = size.x/2
		$Interactable/CollisionShape2D.shape.extents.x = size.x/2

func _unhandled_key_input(event):
	if not $Interactable.interacting: return
	if not event.pressed: return
	
	var updated := false
	
	if event.scancode == KEY_BACKSPACE or event.scancode == KEY_DELETE:
		var length = $Label.text.length()
		if length > 0:
			$Label.text = $Label.text.left(length-1)
			updated = true
	elif event.is_action_pressed("ui_cancel") or event.scancode == KEY_ENTER:
		$Interactable.end_interact()
	else:
		if event.unicode != 0:
			var chars = $Label.get_font("").get_available_chars()
			var c = char(event.unicode)
			if chars.count(c) > 0:
				$Label.text += c
				$Label.text = $Label.text.replace("  ", " ")
				updated = true
	
	if updated:
		$Interactable/ClickSound.play()
		calc_collision()

extends NinePatchRect

var is_open := false setget set_is_open

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_is_open(new_value):
	if is_open != new_value:
		if new_value:
			open()
		else:
			close()
		is_open = new_value
		$OpenSound.play()

func close():
	$AnimationPlayer.play("Hide")
	is_open = false

func open():
	$AnimationPlayer.play("Reveal")
	is_open = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_minimize_pressed():
	set_is_open(false)
	#get_tree().root.get_child(0).minimize_window()

func _on_TextEdit_text_changed():
	$ClickSounds.play()


func _on_ToggleFullscreen_pressed():
	OS.window_fullscreen = not OS.window_fullscreen


func _on_Link_pressed():
	OS.shell_open("https://www.instagram.com/fuzzyzillacomics/")

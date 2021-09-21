extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var level_transitioning := false

export(PackedScene) onready var current_level setget change_to_level

const funnyStrings = [
	"Waiting for itch.io...",
	"Finishing the level...",
	"Installing cuteness...",
	"Drawing the art...",
	"Signing in...",
	"Updating...",
	"Considering Reboot...",
	"Deleting Databases...",
	"Making the deadline...",
	"Waiting for loading bar...",
	"Fetching assets...",
	"Getting useless packages...",
	"Syncing cookies...",
	"Eating cookies...",
	"Viewing memes...",
	"Following Fuzzyzilla...",
	"Solving the puzzle...",
	"Scrambling the puzzle..."
]

# Called when the node enters the scene tree for the first time.
func _ready():
	var level = current_level.instance()
	$Level.add_child(level)
	$TabTitle.text = level.name

func set_glitch(amount):
	$GlitchEffect.visible = true
	$GlitchEffect.amount = amount

func game_finish():
	level_transitioning = true
	$Loading/AnimationPlayer.play("End")

func show_funny_string(show : bool):
	$FunnyStrings.visible = show
	$FunnyStrings.text = funnyStrings[randi() % funnyStrings.size()]

func load_anim_complete():
	var old_level = $Level.get_children()
	for node in old_level:
		node.queue_free()
	
	var new_node = current_level.instance()
	$Level.add_child(new_node)
	$TabTitle.text = new_node.name
	level_transitioning = false

func _process(_delta):
	get_tree().paused = level_transitioning or $Credits.is_open or $Settings.is_open
	$SettingsIcon.frame = 0 if $Settings.is_open else 1
	$NotepadIcon.frame = 0 if $Credits.is_open else 1
	
	if Input.is_action_just_pressed("ui_fullscreen"):
		OS.window_fullscreen = not OS.window_fullscreen
	if Input.is_action_just_pressed("ui_cancel"):
		if $Credits.is_open:
			$Credits.is_open = false
		else:
			$Settings.is_open = not $Settings.is_open

func reset_level():
	if not $Credits.is_open and not $Settings.is_open:
		change_to_level(current_level)

func change_to_level(level : PackedScene):
	current_level = level
	var player := get_node_or_null("Loading/AnimationPlayer")
	if player:
		player.play("LoadLevel")
		level_transitioning = true

func set_pause_node(node : Node, pause : bool) -> void:
	node.set_process(!pause)
	node.set_process_input(!pause)
	node.set_process_internal(!pause)
	node.set_process_unhandled_input(!pause)
	node.set_process_unhandled_key_input(!pause)
	node.set_physics_process(!pause)
	node.set_physics_process_internal(!pause)

func minimize_window():
	if $Credits.is_open:
		$Credits.close()

func _on_Refresh_pressed():
	change_to_level(current_level)


func _on_NotepadButton_pressed():
	$Credits.is_open = !$Credits.is_open
	$Settings.is_open = false


func _on_SettingsButton_pressed():
	$Settings.is_open = !$Settings.is_open
	$Credits.is_open = false

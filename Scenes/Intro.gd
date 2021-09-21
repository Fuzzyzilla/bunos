extends Control

export(PackedScene) var world

const DEBUG_SKIP := false

func _ready():
	if DEBUG_SKIP and OS.is_debug_build():
		call_deferred("enter_game")

func enter_game():
	get_tree().change_scene_to(world)

func _on_animation_finished(_anim_name):
	call_deferred("enter_game")

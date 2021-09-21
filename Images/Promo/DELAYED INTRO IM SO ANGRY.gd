extends Node2D

func _ready():
	OS.window_fullscreen = true

func _on_Timer_timeout():
	get_tree().change_scene("res://Images/Promo/PromoScene.tscn")

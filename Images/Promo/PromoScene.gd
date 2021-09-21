extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var active := false

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	pass # Replace with function body.



func _on_Timer_timeout():
	active = not active
	$GlitchEffect.amount = rand_range(0.0,0.02) if active else 0.0
	$AudioStreamPlayer/AnimationPlayer.play("Glitch")
	$Timer.wait_time = 0.2 if active else rand_range(0.1,1.0)
	$Timer.start()


func _on_Interactable_interacted():
	$Timer.stop()
	$Tween.interpolate_property($GlitchEffect, "amount", 0.0, 0.1, 2.0, Tween.TRANS_EXPO)
	$Tween.interpolate_property($AudioStreamPlayer, "volume_db", -80.0, -20.0, 2.0, Tween.TRANS_EXPO)
	$Tween.start()


func _on_Tween_tween_all_completed():
	$Interactable.end_interact()
	$"Bun/ActionSound".volume_db = -80.0
	$GlitchEffect.amount = 0.0
	$AudioStreamPlayer.volume_db = -80.0
	$Timer.start()
	$"link in bio".visible = true

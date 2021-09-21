extends StaticBody2D

func _process(_delta):
	var players = get_tree().get_nodes_in_group("Player")
	if not players.empty():
		var player_pos = players[0].global_position
		var distance = (player_pos - global_position).length() * 0.01
		var strength = 0.01/distance
		strength = clamp(strength, 0.005, 0.03)
		
		var world = get_tree().root.get_child(0)
		if world.has_method("set_glitch"):
			world.set_glitch(strength);

func _on_interacted():
	get_tree().root.get_child(0).game_finish();

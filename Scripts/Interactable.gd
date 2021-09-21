extends Area2D

signal interacted

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var player : Node2D
var interacting := false

# Called when the node enters the scene tree for the first time.
func _ready():
	#Make unique
	$CollisionShape2D.shape = $CollisionShape2D.shape.duplicate()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func interact(who):
	player = who
	emit_signal("interacted")
	interacting = true
	
func end_interact():
	if player:
		player.end_interact()
		player = null
	interacting = false

func _on_Interactable_body_entered(body):
	if body.is_in_group("Player"):
		body.enter_interactable_area(self)


func _on_Interactable_body_exited(body):
	if body.is_in_group("Player"):
		body.exit_interactable_area(self)
	if body == player:
		end_interact()

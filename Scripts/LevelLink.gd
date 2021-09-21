extends StaticBody2D

export var text := "hello"
export(String, FILE, "*.tscn") var leads_to

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = text
	calc_collision()
	pass # Replace with function body.

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
		
		$Icon.position.x += size.x
		
		$Underline.rect_size.x = size.x


func _on_interacted():
	get_tree().root.get_child(0).current_level = load(leads_to)

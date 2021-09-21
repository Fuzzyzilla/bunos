extends ColorRect
tool

export var amount := 0.03 setget set_amount

func set_amount(new_amount):
	amount = new_amount
	material.set_shader_param("amount", amount)

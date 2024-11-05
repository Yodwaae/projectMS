@tool
extends "res://scripts/box.gd"

@export var value : int = 0 :
	# Allow for the "hot reload" of the box, to display the correct number when changed in the editor
	set(newValue):
		value = newValue
		displayValue = str(value)
		UpdateLabel()

func _ready() -> void:
	UpdateLabel()

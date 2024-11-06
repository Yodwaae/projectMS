@tool
extends "res://scripts/box.gd"

#region ===== VARAIBLES INITIALISATION ======
@export var value : int = 0 :
	# Allow for the "hot reload" of the box, to display the correct number when changed in the editor
	set(newValue):
		value = newValue
		displayValue = str(value)
		UpdateLabel()
#endregion

func _ready() -> void:
	UpdateLabel()

func _on_moved(direction : Vector2):
	print(direction)

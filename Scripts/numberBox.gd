@tool
extends "res://scripts/box.gd"

#region ===== VARAIBLES INITIALISATION ======

@export var value : float = 0 :
	# Allow for the "hot reload" of the box, to display the correct number when changed in the editor
	set(newValue):
		value = newValue
		displayValue = str(value)
		UpdateLabel()
#endregion

func _ready() -> void:
	UpdateLabel()

func _on_moved(direction : Vector2):
	
	# Activate the raycasts in all directions
	activateRaycast(allRaycasts)
	
	# Check always in the same order : left, up, right, down
	if leftBoxRaycast.is_colliding():
		var leftOpBox = leftBoxRaycast.get_collider(0).get_parent()
		print(leftOpBox)
		leftOpBox.calculationLogic(leftOpBox.horizontalRaycasts)
		
	if rightBoxRaycast.is_colliding():
		var rightOpBox = rightBoxRaycast.get_collider(0).get_parent()
		print(rightOpBox)
		rightOpBox.calculationLogic(rightOpBox.horizontalRaycasts)

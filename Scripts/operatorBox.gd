@tool
extends "res://scripts/box.gd"

#region ===== VARIABLES INITIALISATION ======

#region === OPERATOR ===

enum operationType { MULTIPLICATION, DIVISION, ADDITION, SUBSTRACTION }
var operationDisplayArray = ["X", "/", "+", "―"]

# DEBUG The set logic is only needed so that the modification in operator type appear immediatelly in editor
@export var operation : operationType :
	set(newValue):
		if operationDisplayArray:
			operation = newValue
			displayValue = operationDisplayArray[operation]
			UpdateLabel()

#endregion

#endregion

#region ===== FUNCTIONS =====

func _on_moved(direction : Vector2):
	
	print("onMoved")
	
	# Depending on the move direction, select the axis to do the check on
	if direction in [Vector2.UP, Vector2.DOWN]:
		checkDirection = horizontalRaycasts
	elif direction in [Vector2.LEFT, Vector2.RIGHT]:
		checkDirection = verticalRaycasts
	
	# Launch the calculation Logic
	calculationLogic(checkDirection)
	
#region === CALCULATION ===

#TODO Duplicated with player, maybe a better way without doing another script
# Also all this raycast logic might need to be put in the box script directly
func activateRaycast(raycasts : Array[ShapeCast2D]) -> void :
	for raycast in raycasts:
		raycast.force_shapecast_update()
	
func calculationLogic(raycasts: Array[ShapeCast2D]) -> void :
	# Activate the raycasts on the desired axis
	activateRaycast(raycasts)
	
	# Check if there's a calculation to be done
	if raycasts[0].is_colliding() and raycasts[1].is_colliding():
		var valueLeft = raycasts[0].get_collider(0).get_parent().value
		var valueRight = raycasts[1].get_collider(0).get_parent().value
		print(valueLeft)
		print(valueRight)
		doCalculate(valueLeft, valueRight)
	
func doCalculate(valueLeft : float, valueRight : float) -> void:
	# Not really pretty but seems to be the best solution to me (way more operator to come)
	# TODO/DEBUG FOR NOW IT JUST PRINT THE RESULT, THE INSTANTIATION LOGIC WILL COME LATER
	print(operation)
	match operation:
		
		#MULTIPLICATION
		0: 
			var res = valueLeft * valueRight
			print(res)
		
		#DIVISION
		1: 
			if valueRight != 0:
				var res = valueLeft / valueRight
				print(res)
			else:
				print("Petit Malin va")
		
		#ADDITION
		2: 
			var res = valueLeft + valueRight
			print(res)
			
		#SUBSTRACTION
		4: 
			var res = valueLeft - valueRight
			print(res)
	
#endregion

#endregion

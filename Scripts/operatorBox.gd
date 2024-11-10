@tool
extends Box
class_name OperatorBox

#region ===== VARIABLES INITIALISATION ======

#DEBUG
var numberBoxScene = load("res://scenes/boxes/numberBox.tscn")

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

func _ready() -> void:
	UpdateLabel()

func _on_moved(direction : Vector2):
	
	# Depending on the move direction, select the axis to do the check on
	if direction in [Vector2.UP, Vector2.DOWN]:
		checkDirection = horizontalRaycasts
	elif direction in [Vector2.LEFT, Vector2.RIGHT]:
		checkDirection = verticalRaycasts
	
	# Launch the calculation Logic
	calculationLogic(checkDirection)
	
#region === CALCULATION ===
	
func calculationLogic(raycasts: Array[ShapeCast2D]) -> void :
	# Activate the raycasts on the desired axis
	activateRaycast(raycasts)
	
	# If there's not 2 number box get out of the function
	if not raycasts[0].is_colliding() or not raycasts[1].is_colliding():
		return
	
	# Get references to the boxes
	var boxLeft = raycasts[0].get_collider(0).get_parent()
	var boxRight = raycasts[1].get_collider(0).get_parent()
	
	# Get the value of the boxes
	var valueLeft = boxLeft.value
	var valueRight = boxRight.value
	
	# Calculate the result of the operation
	var res = doCalculate(valueLeft, valueRight)
	
	# Launch the boxes deletion and creation logic
	cleanAndCreateNewBox(res, boxLeft, boxRight)
	
func doCalculate(valueLeft : float, valueRight : float) -> float:
	# Not really pretty but seems to be the best solution to me (way more operator to come)
	# TODO/DEBUG FOR NOW IT JUST PRINT THE RESULT, THE INSTANTIATION LOGIC WILL COME LATER
	var res = 0
	match operation:
		
		#MULTIPLICATION
		0: 
			res = valueLeft * valueRight
		
		#DIVISION
		1: 
			if valueRight != 0:
				res = valueLeft / valueRight
			else:
				# TODO See what is the ouput in a case of a division by zero (not working or creating a 'corrupted' box)
				# NOTE Funny thing is in godot dividing by zero gives 'inf' not an error
				print("Petit Malin va")
		
		#ADDITION
		2: 
			res = valueLeft + valueRight
			
		#SUBSTRACTION
		4: 
			res = valueLeft - valueRight
			
	return res

#endregion

#region === BOX DELETION AND CREATION ===

# TODO Voir pour créer des classes explicitement, ça facilitera peut être le typage dans certains cas
func cleanAndCreateNewBox(value : float, boxLeft : Node2D, boxRight : Node2D) -> void:
	
	# Delete source number boxes
	boxLeft.queue_free()
	boxRight.queue_free()
	
	# Create the new number Box (only debug for the moment)
	# TODO Enfait faudrait peut être une fonction publique du 'gameManager' pour la création de la box ? Et on lui file les valeurs nécessaires
	# Faut aussi un constructeur en fait, pour filer la valeur et les positions
	print(value)
	# TODO C'est vraiment a clean et refacto + foutre au bon endroit mais ça marche
	var newBox = numberBoxScene.instantiate()
	newBox.myInitialisation(position, value)
	var scene = get_tree().current_scene
	scene.add_child(newBox)
	# Delete itself
	self.queue_free()
	
#endregion

#endregion

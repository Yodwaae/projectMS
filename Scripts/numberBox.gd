@tool
extends Box
class_name NumberBox

#region ===== VARAIBLES INITIALISATION ======

@export var value : float = 0 :
	# Allow for the "hot reload" of the box, to display the correct number when changed in the editor
	set(newValue):
		value = newValue
		displayValue = str(value)
		UpdateLabel()
#endregion

#region ===== FUNCTIONS =====

func _ready() -> void:
	UpdateLabel()

func myInitialisation(position : Vector2, value : float):
	self.position = position
	self.value = value
	print("Oui j'ai été instantié mek")

func triggerOperationBoxCalculation(sourceDirectionIndex : int):
	#Initialise a local var to store direction to check for the opBox
	var direction : Array[ShapeCast2D]
	
	# Get the opBox
	var opBox = allRaycasts[sourceDirectionIndex].get_collider(0).get_parent()
	
	# Get the direction to check, index 0 and 2 of allRaycast are left and right
	if sourceDirectionIndex % 2 == 0:
		direction = opBox.horizontalRaycasts
	else:
		direction = opBox.verticalRaycasts
	
	# Launch the calculation logic on the target opBox
	opBox.calculationLogic(direction)

func _on_moved(direction : Vector2):
	
	# Activate the raycasts in all directions
	activateRaycast(allRaycasts)
	
	# Check for opBox always in the same order : left, up, right, down
	if leftBoxRaycast.is_colliding():
		triggerOperationBoxCalculation(0)
	elif upBoxRaycast.is_colliding():
		triggerOperationBoxCalculation(1)
	elif rightBoxRaycast.is_colliding():
		triggerOperationBoxCalculation(2)
	elif downBoxRaycast.is_colliding():
		triggerOperationBoxCalculation(3)
		
#endregion

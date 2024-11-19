@tool
extends Box
class_name NumberBox

#region ===== VARAIBLES INITIALISATION ======

@export var value : int = 0 :
	# Allow for the "hot reload" of the box, to display the correct number when changed in the editor
	set(newValue):
		value = newValue
		displayValue = str(value)
		UpdateLabel()
#endregion

#region ===== FUNCTIONS =====

func initialize(position : Vector2, value : int):
	
	# Send signal to levelManager
	Signals.emit_signal("newBoxCreated", value)
	
	# Set position and value
	self.position = position
	self.value = value
	
	# Wait 175 ms to be sure the newly created box wont be missed by a raycast and so if multiples calculations are chained they are not instantaneous
	await get_tree().create_timer(.175).timeout 
	
	# Launch box detection
	raycastsCheck()

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

func raycastsCheck():
	
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

func _on_moved(direction : Vector2):
	raycastsCheck()
	
#endregion

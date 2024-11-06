extends Node2D

#region ===== VARIABLES INITIALISATION =======

#region === RAYCASTS ===

#region Obstacles Raycasts
@onready var obsRaycastDown: ShapeCast2D = %obsRaycastDown
@onready var obsRaycastUp: ShapeCast2D = %obsRaycastUp
@onready var obsRaycastRight: ShapeCast2D = %obsRaycastRight
@onready var obsRaycastLeft: ShapeCast2D = %obsRaycastLeft
#endregion

#region Boxes Raycasts 
@onready var boxRaycastDown: ShapeCast2D = %boxRaycastDown
@onready var boxRaycastUp: ShapeCast2D = %boxRaycastUp
@onready var boxRaycastRight: ShapeCast2D = %boxRaycastRight
@onready var boxRaycastLeft: ShapeCast2D = %boxRaycastLeft
#endregion

#region After Boxes Raycasts
@onready var afterBoxRaycastDown: ShapeCast2D = %afterBoxRaycastDown
@onready var afterBoxRaycastUp: ShapeCast2D = %afterBoxRaycastUp
@onready var afterBoxRaycastRight: ShapeCast2D = %afterBoxRaycastRight
@onready var afterBoxRaycastLeft: ShapeCast2D = %afterBoxRaycastLeft
#endregion

#region Raycasts group by direction
@onready var downRaycasts : Array[ShapeCast2D] = [obsRaycastDown, boxRaycastDown, afterBoxRaycastDown]
@onready var upRaycasts : Array[ShapeCast2D] = [obsRaycastUp, boxRaycastUp, afterBoxRaycastUp]
@onready var rightRaycasts : Array[ShapeCast2D] = [obsRaycastRight, boxRaycastRight, afterBoxRaycastRight]
@onready var leftRaycasts : Array[ShapeCast2D] = [obsRaycastLeft, boxRaycastLeft, afterBoxRaycastLeft]
#endregion

#endregion

#region === MOVEMENTS ===

# NOTE No need to export, will be modified directly in the code depending on tile size
var moveLength : int = 64
var boxToPush : Node2D = null
var direction : Vector2 = Vector2.ZERO
var checkDirection : Array[ShapeCast2D]
#endregion

#endregion

#region ===== FONCTIONS =====

func checkBoxesAndObstacles(raycasts : Array[ShapeCast2D]) -> bool:
	
	# Trigger the raycast of the wanted direction
	activateRaycast(raycasts)
	
	# Check the raycast collisions
	var isThereObstacle = raycasts[0].is_colliding()
	var isThereBox = raycasts[1].is_colliding()
	var isThereSomethingAfterBox = raycasts[2].is_colliding()
	
	# If there is a pushable box, set boxToPush
	if isThereBox and not isThereSomethingAfterBox:
		boxToPush = raycasts[1].get_collider(0).get_parent()
	
	# Player can move if there is no obstacle, no box or a box and nothing in the cell after the box
	var canMove = not isThereObstacle and (not isThereBox or (isThereBox and not isThereSomethingAfterBox))
	return canMove
	
func _process(delta: float) -> void:
	
	# ===== MOVEMENTS ======
	
	# Getting direction
	# NOTE Using elif to avoid a new input to override the precedent
	if Input.is_action_just_pressed("moveDown"):
		direction = Vector2.DOWN
		checkDirection = downRaycasts
	elif Input.is_action_just_pressed("moveUp"):
		direction = Vector2.UP
		checkDirection = upRaycasts
	elif Input.is_action_just_pressed("moveRight"):
		direction = Vector2.RIGHT
		checkDirection = rightRaycasts
	elif Input.is_action_just_pressed("moveLeft"):	
		direction = Vector2.LEFT
		checkDirection = leftRaycasts
	
	# If a direction is inputed, do the movement logic
	if direction != Vector2.ZERO and checkBoxesAndObstacles(checkDirection):

		# Move player
		position += direction * moveLength
		
		# Move box
		if boxToPush:
			boxToPush.move(direction, moveLength)
			boxToPush = null
		
		# Consume the direction input
		direction = Vector2.ZERO
		
func activateRaycast(raycasts : Array[ShapeCast2D]) -> void :
	for raycast in raycasts:
		raycast.force_shapecast_update()
#endregion

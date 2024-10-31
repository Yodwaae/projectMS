extends Node2D

#region ===== VARIABLES INITIALISATION =======

#region === RAYCAST ===
# Obstacles Raycasts
@onready var obsRaycastDown: ShapeCast2D = %obsRaycastDown
@onready var obsRaycastUp: ShapeCast2D = %obsRaycastUp
@onready var obsRaycastRight: ShapeCast2D = %obsRaycastRight
@onready var obsRaycastLeft: ShapeCast2D = %obsRaycastLeft

# Boxes Raycasts 
@onready var boxRaycastDown: ShapeCast2D = %boxRaycastDown
@onready var boxRaycastUp: ShapeCast2D = %boxRaycastUp
@onready var boxRaycastRight: ShapeCast2D = %boxRaycastRight
@onready var boxRaycastLeft: ShapeCast2D = %boxRaycastLeft

# After Boxes Raycasts
@onready var afterBoxRaycastDown: ShapeCast2D = %afterBoxRaycastDown
@onready var afterBoxRaycastUp: ShapeCast2D = %afterBoxRaycastUp
@onready var afterBoxRaycastRight: ShapeCast2D = %afterBoxRaycastRight
@onready var afterBoxRaycastLeft: ShapeCast2D = %afterBoxRaycastLeft

# Raycasts group by direction
@onready var downRaycasts : Array[ShapeCast2D] = [obsRaycastDown, boxRaycastDown, afterBoxRaycastDown]
@onready var upRaycasts : Array[ShapeCast2D] = [obsRaycastUp, boxRaycastUp, afterBoxRaycastUp]
@onready var rightRaycasts : Array[ShapeCast2D] = [obsRaycastRight, boxRaycastRight, afterBoxRaycastRight]
@onready var leftRaycasts : Array[ShapeCast2D] = [obsRaycastLeft, boxRaycastLeft, afterBoxRaycastLeft]

#endregion

#region === MOVEMENTS ===

# NOTE No need to export, will be modified directly in the code depending on tile size
var moveLength : int = 64
var boxToPush : Node2D = null
var direction : Vector2 = Vector2.ZERO

#endregion
#endregion

#region ===== FONCTIONS =====

func canMove(raycasts : Array[ShapeCast2D]) -> bool:
	
	# Check the raycast collisions
	var isThereObstacle = raycasts[0].is_colliding()
	var isThereBox = raycasts[1].is_colliding()
	var isThereSomethingAfterBox = raycasts[2].is_colliding()
	
	# If there is a pushable box, get a reference to it
	if isThereBox and not isThereSomethingAfterBox:
		boxToPush = raycasts[1].get_collider(0).get_parent()
	
	# Player can move if there is no obstacle, no box or a box and nothing in the cell after the box
	var canMove = not isThereObstacle and (not isThereBox or (isThereBox and not isThereSomethingAfterBox))
	return canMove
	
func _physics_process(delta: float) -> void:
	
	# Reset
	boxToPush = null
	
	# ===== MOVEMENTS ======
	# NOTE Using elif to avoid moving diagonaly almost instantly when two inputs are pressed simultaneously, 
	# which can cause problems with the collision detection
	if Input.is_action_just_pressed("moveDown") and canMove(downRaycasts):
		if boxToPush:
			boxToPush.moveDown(moveLength)
			
		direction = Vector2.DOWN
		
	elif Input.is_action_just_pressed("moveUp") and canMove(upRaycasts):
		if boxToPush:
			boxToPush.moveUp(moveLength)
			
		direction = Vector2.UP
		
	elif Input.is_action_just_pressed("moveRight") and canMove(rightRaycasts):
		if boxToPush:
			boxToPush.moveRight(moveLength)
			
		direction = Vector2.RIGHT
		
	elif Input.is_action_just_pressed("moveLeft") and canMove(leftRaycasts):
		if boxToPush:
			boxToPush.moveLeft(moveLength)
			
		direction = Vector2.LEFT
	
	# If a direction is inputed, do the movement logic
	if direction != Vector2.ZERO:
		
		# Move
		position += direction * moveLength
		
		# Consume the direction input
		direction = Vector2.ZERO
		

#endregion

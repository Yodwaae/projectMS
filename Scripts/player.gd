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

# No need to export, will be modified depending on tile size
var moveLength : int = 64

#endregion
#endregion


#region ===== FONCTIONS =====

func canMove(raycasts : Array[ShapeCast2D]) -> bool:
	
	# Check the raycast collisions
	var isThereObstacle = raycasts[0].is_colliding()
	var isThereBox = raycasts[1].is_colliding()
	var isThereSomethingAfterBox = raycasts[2].is_colliding()
	
	# Get the reference to the box
	if isThereBox:
		var box = raycasts[1].get_collider(0)
		# DEBUG PRINT
		print(box.get_parent())
	
	# Player can move if there is no obstacle, no box or a box and nothing in the cell after the box
	var canMove = not isThereObstacle and (not isThereBox or (isThereBox and not isThereSomethingAfterBox))
	return canMove

func canMoveDown() -> bool:
	
	# Check the raycast collisions
	var isThereObstacle = obsRaycastDown.is_colliding()
	var isThereBox = boxRaycastDown.is_colliding()
	var isThereSomethingAfterBox = afterBoxRaycastDown.is_colliding()
	
	# Get the reference to the box
	if isThereBox:
		var box = boxRaycastDown.get_collider(0)
		print(box.get_parent())
	
	# Player can move if there is no obstacle, no box or a box and nothing in the cell after the box
	var canMove = not isThereObstacle and (not isThereBox or (isThereBox and not isThereSomethingAfterBox))
	return canMove

func canMoveUp() -> bool:
	
	# Check the raycast collisions
	var isThereObstacle = obsRaycastUp.is_colliding()
	var isThereBox = boxRaycastUp.is_colliding()
	var isThereSomethingAfterBox = afterBoxRaycastUp.is_colliding()
	
	# Get the reference to the box
	if isThereBox:
		var box = boxRaycastUp.get_collider(0)
		print(box.get_parent())
	
	# Player can move if there is no obstacle, no box or a box and nothing in the cell after the box
	var canMove = not isThereObstacle and (not isThereBox or (isThereBox and not isThereSomethingAfterBox))
	return canMove

func canMoveRight() -> bool:
	
	# Check the raycast collisions
	var isThereObstacle = obsRaycastRight.is_colliding()
	var isThereBox = boxRaycastRight.is_colliding()
	var isThereSomethingAfterBox = afterBoxRaycastRight.is_colliding()
	
	# Get the reference to the box
	if isThereBox:
		var box = boxRaycastRight.get_collider(0)
		print(box.get_parent())
	
	# Player can move if there is no obstacle, no box or a box and nothing in the cell after the box
	var canMove = not isThereObstacle and (not isThereBox or (isThereBox and not isThereSomethingAfterBox))
	return canMove
	
func canMoveLeft() -> bool:
	
	# Check the raycast collisions
	var isThereObstacle = obsRaycastLeft.is_colliding()
	var isThereBox = boxRaycastLeft.is_colliding()
	var isThereSomethingAfterBox = afterBoxRaycastLeft.is_colliding()
	
	# Get the reference to the box
	if isThereBox:
		var box = boxRaycastLeft.get_collider(0)
		print(box.get_parent())
	
	# Player can move if there is no obstacle, no box or a box and nothing in the cell after the box
	var canMove = not isThereObstacle and (not isThereBox or (isThereBox and not isThereSomethingAfterBox))
	return canMove

func _physics_process(delta: float) -> void:
	
	# ===== MOVEMENTS ======
	# NOTE Using elif to avoid moving diagonaly almost instantly when two inputs are pressed simultaneously, 
	# which can cause problems with the collision detection
	if Input.is_action_just_pressed("moveDown") and canMove(downRaycasts):
		move_local_y(moveLength)
	elif Input.is_action_just_pressed("moveUp") and canMove(upRaycasts):
		move_local_y(-moveLength)
	elif Input.is_action_just_pressed("moveRight") and canMove(rightRaycasts):
		move_local_x(moveLength)
	elif Input.is_action_just_pressed("moveLeft") and canMove(leftRaycasts):
		move_local_x(-moveLength)

#endregion

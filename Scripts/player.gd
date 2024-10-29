extends Node2D

#region ===== VARIABLES INITIALISATION =======

# === RAYCAST ===

# Obstacles Raycasts
@onready var obsRaycastDown: RayCast2D = %obsRaycastDown
@onready var obsRaycastUp: RayCast2D = %osbRaycastUp
@onready var obsRaycastRight: RayCast2D = %obsRaycastRight
@onready var obsRaycastLeft: RayCast2D = %obsRaycastLeft

# Boxes Raycasts 
@onready var boxRaycastDown: RayCast2D = %boxRaycastDown
@onready var boxRaycastUp: RayCast2D = %boxRaycastUp
@onready var boxRaycastRight: RayCast2D = %boxRaycastRight
@onready var boxRaycastLeft: RayCast2D = %boxRaycastLeft

# After Boxes Raycasts
@onready var afterBoxRaycastDown: ShapeCast2D = %afterBoxRaycastDown
@onready var afterBoxRaycastUp: ShapeCast2D = %afterBoxRaycastUp
@onready var afterBoxRaycastRight: ShapeCast2D = %afterBoxRaycastRight
@onready var afterBoxRaycastLeft: ShapeCast2D = %afterBoxRaycastLeft


# === MOVEMENTS ===
# No need to export, will be modified depending on tile size
var moveLength : int = 64
var canMoveDown : bool = false
var canMoveUp : bool = false
var canMoveLeft : bool = false
var canMoveRight : bool = false

#endregion


#region ===== FONCTIONS =====

func moveDown(distance):
	move_local_y(distance)
	
func moveUp(distance):
	move_local_y(-distance)
	
func moveRight(distance):
	move_local_x(distance)
	
func moveLeft(distance):
	move_local_x(-distance)

func _physics_process(delta: float) -> void:
	
	canMoveDown = not obsRaycastDown.is_colliding() and (not boxRaycastDown.is_colliding() or (boxRaycastDown.is_colliding() and not afterBoxRaycastDown.is_colliding()))
	canMoveUp = not obsRaycastUp.is_colliding() and (not boxRaycastUp.is_colliding() or (boxRaycastUp.is_colliding() and not afterBoxRaycastUp.is_colliding()))
	canMoveRight = not obsRaycastRight.is_colliding() and (not boxRaycastRight.is_colliding() or (boxRaycastRight.is_colliding() and not afterBoxRaycastRight.is_colliding()))
	canMoveLeft = not obsRaycastLeft.is_colliding() and (not boxRaycastLeft.is_colliding() or (boxRaycastLeft.is_colliding() and not afterBoxRaycastLeft.is_colliding()))
	
	# ===== MOVEMENTS ======
	# NOTE Using elif to avoid moving diagonaly almost instantly when two inputs are pressed simultaneously, 
	# which can cause problems with the collision detection
	if Input.is_action_just_pressed("moveDown") and canMoveDown:
		moveDown(moveLength)
	elif Input.is_action_just_pressed("moveUp") and canMoveUp:
		moveUp(moveLength)
	elif Input.is_action_just_pressed("moveRight") and canMoveRight:
		moveRight(moveLength)
	elif Input.is_action_just_pressed("moveLeft") and canMoveLeft:
		moveLeft(moveLength)
		
	if Input.is_action_just_pressed("debug"):
		print(canMoveLeft)

#endregion

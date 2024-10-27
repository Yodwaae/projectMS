extends Node2D

#region ===== VARIABLES INITIALISATION =======

# === RAYCAST ===
@onready var raycastLeft: RayCast2D = %raycastLeft
@onready var raycastRight: RayCast2D = %raycastRight
@onready var raycastDown: RayCast2D = %raycastDown
@onready var raycastUp: RayCast2D = %raycastUp

# === MOVEMENTS ===
# No need to export, will be modified depending on tile size
var distance : int = 64
#endregion

func _physics_process(delta: float) -> void:
	
	# ===== MOVEMENTS ======
	
	# NOTE Using elif to avoid moving diagonaly almost instantly when two inputs are pressed simultaneously, 
	# which can cause problems with the collision detection
	if Input.is_action_just_pressed("moveDown") and not raycastDown.is_colliding() :
		move_local_y(distance)
	elif Input.is_action_just_pressed("moveUp") and not raycastUp.is_colliding():
		move_local_y(-distance)
	elif Input.is_action_just_pressed("moveRight") and not raycastRight.is_colliding():
		move_local_x(distance)
	elif Input.is_action_just_pressed("moveLeft") and not raycastLeft.is_colliding():
		move_local_x(-distance)

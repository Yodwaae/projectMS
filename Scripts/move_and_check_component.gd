extends Node2D

#region ===== VARIABLES INITIALISATION =======

@onready var moveAndCheck: Node2D = $".."

# === RAYCAST ===
@onready var raycastLeft: RayCast2D = %raycastLeft
@onready var raycastRight: RayCast2D = %raycastRight
@onready var raycastDown: RayCast2D = %raycastDown
@onready var raycastUp: RayCast2D = %raycastUp

# === MOVEMENTS ===
# No need to export, will be modified depending on tile size
var distance : int = 64
#endregion

func moveDown() -> bool:
	if not raycastDown.is_colliding():
		moveAndCheck.move_local_y(distance)
		return true
	else:
		return false

func moveUp() -> bool:
	if not raycastUp.is_colliding():
		moveAndCheck.move_local_y(-distance)
		return true
	else:
		return false

func moveRight() -> bool:
	if not raycastRight.is_colliding():
		moveAndCheck.move_local_x(distance)
		return true
	else:
		return false

func moveLeft() -> bool:
	if not raycastLeft.is_colliding():
		moveAndCheck.move_local_x(-distance)
		return true
	else:
		return false

@tool
extends Node2D

#region ===== VARIABLES INITIALISATION ======

#region === SIGNALS ===
signal moved(direction : Vector2)
#endregion

#region === DISPLAY ===
@onready var labelDisplay: Label = $valueDisplay
var displayValue : String
#endregion

#region === RAYCASTS ===
@onready var leftBoxRaycast: ShapeCast2D = %leftBoxRaycast
@onready var rightBoxRaycast: ShapeCast2D = %rightBoxRaycast
@onready var upBoxRaycast: ShapeCast2D = %upBoxRaycast
@onready var downBoxRaycast: ShapeCast2D = %downBoxRaycast

# Order is important, for operation like (left - right), (up / down) + some functions depends on it, so it must not be modified
@onready var verticalRaycasts : Array[ShapeCast2D] = [upBoxRaycast, downBoxRaycast]
@onready var horizontalRaycasts : Array[ShapeCast2D] = [leftBoxRaycast, rightBoxRaycast]
@onready var allRaycasts : Array[ShapeCast2D] = [leftBoxRaycast, upBoxRaycast, rightBoxRaycast, downBoxRaycast]

var checkDirection : Array[ShapeCast2D]
#endregion

#endregion

#region FUNCTIONS

# Force the update of all the raycast in the array passed as arg
func activateRaycast(raycasts : Array[ShapeCast2D]) -> void :
	for raycast in raycasts:
		raycast.force_shapecast_update()

# Update the displayed value of the box
func UpdateLabel() -> void:
	if labelDisplay:
		labelDisplay.text = displayValue

func move(direction, length):
	## Public function allowing the player script to move a box
	## direction : Vector2, direction in wich to move the box
	## length : int, length of the move in pixel
	
	position += direction * length
	
	# Wait a ms before emiting the signal, to be sure that the moved box won't be missed by other raycast it might trigger
	await get_tree().create_timer(.01).timeout 
	
	moved.emit(direction)
	
#endregion

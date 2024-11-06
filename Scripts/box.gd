@tool
extends Node2D

#region ===== VARAIBLES INITIALISATION ======
signal moved(direction : Vector2)

#region === DISPLAY ===
@onready var labelDisplay: Label = $valueDisplay
var displayValue : String
#endregion

#region === RAYCASTS ===
@onready var leftNbBoxRaycast: ShapeCast2D = %leftNbBoxRaycast
@onready var rightNbBoxRaycast: ShapeCast2D = %rightNbBoxRaycast
@onready var upNbBoxRaycast: ShapeCast2D = %upNbBoxRaycast
@onready var downNbBoxRaycast: ShapeCast2D = %downNbBoxRaycast

# Order is important, fror operation like (left - right), (up / down)
@onready var verticalRaycasts : Array[ShapeCast2D] = [upNbBoxRaycast, downNbBoxRaycast]
@onready var horizontalRaycasts : Array[ShapeCast2D] = [leftNbBoxRaycast, rightNbBoxRaycast]

var checkDirection : Array[ShapeCast2D]
#endregion
#endregion

#region FUNCTIONS

# Update the displayed value of the box
func UpdateLabel() -> void:
	if labelDisplay:
		labelDisplay.text = displayValue

func move(direction, length):
	## Public function allowing the player script to move a box
	## direction : Vector2, direction in wich to move the box
	## length : int, length of the move in pixel
	
	position += direction * length
	
	moved.emit(direction)
	
#endregion

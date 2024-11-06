@tool
extends Node2D

#region ===== VARAIBLES INITIALISATION ======
signal moved(direction : Vector2)

#region === DISPLAY ===
@onready var labelDisplay: Label = $valueDisplay
var displayValue : String
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

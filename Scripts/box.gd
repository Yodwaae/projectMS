@tool
extends Node2D

@onready var labelDisplay: Label = $valueDisplay
var displayValue : String

# Update the displayed value of the box
func UpdateLabel() -> void:
	if labelDisplay:
		labelDisplay.text = displayValue

func move(direction, length):
	## Public function allowing the player script to move a box
	## direction : Vector2, direction in wich to move the box
	## length : int, length of the move in pixel
	
	position += direction * length

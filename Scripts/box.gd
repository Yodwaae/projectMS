@tool
extends Node2D

@onready var valueDisplay: Label = $valueDisplay

# Update the displayed value of the box
func UpdateLabel(valueToDisplay) -> void:
	if valueDisplay:
		valueDisplay.text = str(valueToDisplay)

func move(direction, length):
	## Public function allowing the player script to move a box
	## direction : Vector2, direction in wich to move the box
	## length : int, length of the move in pixel
	
	position += direction * length

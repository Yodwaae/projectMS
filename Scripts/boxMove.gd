extends Node2D

@onready var box: Node2D = $".."

func move(direction, length):
	## Public function allowing the player script to move a box
	## direction : Vector2, direction in wich to move the box
	## length : int, length of the move in pixel
	
	box.position += direction * length

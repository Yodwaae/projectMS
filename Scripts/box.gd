extends Node2D

func moveDown(distance):
	move_local_y(distance)

func moveUp(distance):
	move_local_y(-distance)

func moveRight(distance):
	move_local_x(distance)

func moveLeft(distance):
	move_local_x(-distance)

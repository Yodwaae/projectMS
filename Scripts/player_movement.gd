extends Node2D

@onready var moveAndCheck: Node2D = %moveAndCheckComponent

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("moveDown"):
		moveAndCheck.moveDown()
	elif Input.is_action_just_pressed("moveUp"):
		moveAndCheck.moveUp()
	elif Input.is_action_just_pressed("moveRight"):
		moveAndCheck.moveRight()
	elif Input.is_action_just_pressed("moveLeft"):
		moveAndCheck.moveLeft()

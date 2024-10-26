extends Node2D

# No need to export, will be modified depending on tile size
var distance : int = 64

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	# Movements Inputs
	if Input.is_action_just_pressed("moveDown"):
		move_local_y(distance)
	if Input.is_action_just_pressed("moveUp"):
		move_local_y(-distance)
	if Input.is_action_just_pressed("moveRight"):
		move_local_x(distance)
	if Input.is_action_just_pressed("moveLeft"):
		move_local_x(-distance)

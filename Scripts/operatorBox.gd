@tool
extends "res://scripts/box.gd"

#TODO Variables comments to improve and clean

#region ===== VARAIBLES INITIALISATION ======

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

enum operationType { MULTIPLICATION, DIVISION, ADDITION, SUBSTRACTION }
var operationDisplayArray = ["X", "/", "+", "―"]

@export var operation : operationType :
	set(newValue):
		if operationDisplayArray:
			operation = newValue
			displayValue = operationDisplayArray[operation]
			UpdateLabel()

#endregion

func _ready() -> void:
	UpdateLabel()

#TODO Duplicated with player, maybe a better way without doing another script
# Also all this raycast logic might need to be put in the box script directly
func activateRaycast(raycasts : Array[ShapeCast2D]) -> void :
	for raycast in raycasts:
		raycast.force_shapecast_update()

func _on_moved(direction : Vector2):
	var debug1 : String = " "
	var debug2 : String = " "
	
	if direction in [Vector2.UP, Vector2.DOWN]:
		checkDirection = horizontalRaycasts
	elif direction in [Vector2.LEFT, Vector2.RIGHT]:
		checkDirection = verticalRaycasts
		
	activateRaycast(checkDirection)
	print(checkDirection)
	
	#DEBUG Quick ugly debug print (the calculation logic will be in a separated function)
	if checkDirection[0].is_colliding():
		debug1 = checkDirection[0].get_collider(0).get_parent().displayValue
	
	if checkDirection[1].is_colliding():
		debug2 = checkDirection[1].get_collider(0).get_parent().displayValue
		
	print( debug1 + displayValue + debug2)

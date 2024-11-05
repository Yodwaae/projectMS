@tool
extends "res://scripts/box.gd"

enum operationType { MULTIPLICATION, DIVISION, ADDITION, SUBSTRACTION }
var operationDisplayArray = ["X", "/", "+", "―"]

@export var operation : operationType :
	set(newValue):
		if operationDisplayArray:
			operation = newValue
			displayValue = operationDisplayArray[operation]
			UpdateLabel()

func _ready() -> void:
	UpdateLabel()

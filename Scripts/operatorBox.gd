@tool
extends "res://scripts/box.gd"

enum operationType { MULTIPLICATION, DIVISION, ADDITION, SUBSTRACTION }
var operationDisplayArray = ["X", "/", "+", "−"]

@export var operation : operationType :
	set(newValue):
		if operationDisplayArray:
			operation = newValue
			UpdateLabel(operationDisplayArray[newValue])

func _ready() -> void:
	UpdateLabel(operationDisplayArray[operation])

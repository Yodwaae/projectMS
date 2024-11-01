@tool
extends Node2D


@onready var valueDisplay: Label = $valueDisplay
@export var value : int = 0 :
	# Allow for the "hot reload" of the box, to display the correct number when changed in the editor
	set(newValue):
		value = newValue
		UpdateLabel()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	UpdateLabel()

# Update the displayed value of the box
func UpdateLabel() -> void:
	if valueDisplay:
		valueDisplay.text = str(value)

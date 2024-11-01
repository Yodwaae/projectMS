extends Node2D

@onready var valueDisplay: Label = $valueDisplay
@export var value : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	UpdateLabel()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Update the label text whenever the `value` changes
func UpdateLabel() -> void:
	if valueDisplay:
		valueDisplay.text = str(value)

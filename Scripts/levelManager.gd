extends Node

#region ===== VARIABLES INITIALISATION ======

var numberBoxScene = load("res://scenes/boxes/numberBox.tscn")
@export var levelGoals : Array[float]

#endregion

#region ===== FUNCTIONS ======

func _ready() -> void:
	Signals.connect("newBoxCreated", _on_new_box_created)

# TODO Faut vraiment que je trouve un fix pour tous les timeout + call deferred
func instantiateNumberBox(position : Vector2, value : float):
	
	# Create new box, initialize it and add it to  the scene
	var newBox = numberBoxScene.instantiate()
	newBox.call_deferred("initialize", position, value)
	add_child(newBox)
	
func _on_new_box_created(value: float) -> void:
	# DEBUG Print for now
	print("You created the box : " + str(value))
	
#endregion

extends Node

#region ===== VARIABLES INITIALISATION ======

var numberBoxScene = load("res://scenes/boxes/numberBox.tscn")

@onready var goalsDisplay: Label = %GoalsDisplay
@export var goals : Array[int]
var goalsReached : Array[int]

#endregion

#region ===== FUNCTIONS ======

func _ready() -> void:
	
	# Connecting signals
	Signals.connect("newBoxCreated", _on_new_box_created)
	
	# Initializing
	goalsReached = []
	
	var goalsString = " - ".join(goals)
	goalsDisplay.text = goalsString

# TODO Faut vraiment que je trouve un fix pour tous les timeout + call deferred
func instantiateNumberBox(position : Vector2, value : int):
	
	# Create new box, initialize it and add it to  the scene
	var newBox = numberBoxScene.instantiate()
	newBox.call_deferred("initialize", position, value)
	add_child(newBox)
	
func _on_new_box_created(value: float) -> void:
	
	if value in goals:
		goalsReached.append(value)
		goals.erase(value)
	
	if goals.is_empty():
		print("Level Finished")
		
#endregion

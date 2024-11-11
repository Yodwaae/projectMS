extends Node

#region ===== VARIABLES INITIALISATION ======

var numberBoxScene = load("res://scenes/boxes/numberBox.tscn")

#endregion

#region ===== FUNCTIONS ======

# TODO Faut vraiment que je trouve un fix pour tous les timeout + call deferred
func instantiateNumberBox(position : Vector2, value : float):
	
	# Create new box, initialize it and add it to  the scene
	var newBox = numberBoxScene.instantiate()
	newBox.call_deferred("initialize", position, value)
	add_child(newBox)
	
#endregion

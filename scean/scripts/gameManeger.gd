extends Node

@onready var scoreLabel = $score

func _process(delta):
	scoreLabel.text = "score " + str(Values.score)

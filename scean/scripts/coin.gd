extends Area2D

func _on_body_entered(theOtherThing):
	Values.score += 1
	queue_free()



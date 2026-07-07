extends Area2D

func _on_body_entered(body):
	if body.name == "Spirit":
		$"../UI/Panel".show()
		get_tree().paused = true

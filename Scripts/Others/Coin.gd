extends Area2D

func _on_body_entered(body):
	if body.name == "Spirit":
		$Sound.play()
		Game.addCoins(1)
		Game.addPoints(100)

func _on_sound_finished():
	queue_free()

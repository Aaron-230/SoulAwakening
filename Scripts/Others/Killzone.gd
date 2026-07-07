extends Area2D

func _on_body_entered(body):
	$Timer.start()

func _on_timer_timeout():
	get_tree().reload_current_scene()

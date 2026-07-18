extends CanvasLayer

@export_file(".tscn") var nextScene: String

func _on_start_pressed():
	get_tree().change_scene_to_file(nextScene)

func _on_exit_pressed():
	get_tree().quit()

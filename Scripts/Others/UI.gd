extends CanvasLayer

@export_file(".tscn") var nextScene: String
@export var LevelName: String

func _ready():
	$Panel.hide()
	$"Pause Menu".hide()
	$Panel/Container/Label.text = "Congrats! You have finished \nLevel: " + LevelName

func _input(event: InputEvent):
	if event.is_action_pressed("Pause"):
		$"Pause Menu".show()
		get_tree().paused = true

func _on_next_pressed():
	get_tree().paused = false
	Game.ResetHealth()
	get_tree().change_scene_to_file(nextScene)

func _on_exit_pressed():
	get_tree().quit()

func _on_resume_pressed():
	$"Pause Menu".hide()
	get_tree().paused = false

func _on_restart_pressed() -> void:
	$"Pause Menu".hide()
	get_tree().paused = false
	get_tree().reload_current_scene()

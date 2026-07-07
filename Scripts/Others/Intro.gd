extends CanvasLayer

@export var Text: String

func _ready():
	$Panel/Label.text = Text
	$Animation.play("Intro")

func _on_animation_animation_finished(anim_name: StringName):
	$".".hide()

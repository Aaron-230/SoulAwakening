extends CharacterBody2D

var Speed = 100
var DamageAmount = 20

var Body: Node2D = null

@onready var Sprite: AnimatedSprite2D = $Sprite

func _physics_process(delta):
	if not is_on_floor():
		velocity.y = get_gravity() * delta
	
	if Body != null:
		var Target = (Body.global_position - global_position).normalized()
		velocity.x = Target.x * Speed
		
		if Target.x > 0:
			Sprite.flip_h = false
		elif Target.x < 0:
			Sprite.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, delta)
	
	move_and_slide()
	

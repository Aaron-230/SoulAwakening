extends CharacterBody2D

const Walk = 200.0
const Run = 400.0
const JumpVelocity = -400.0
const Damage = 30

@onready var Sprite: AnimatedSprite2D = $Sprite

func _physics_process(delta: float):
	var Speed = Walk
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if Input.is_action_pressed("Run") and is_on_floor():
		Speed = Run

	if Input.is_action_just_pressed("Jump") and is_on_floor():
		$Sounds/Jump.play()
		velocity.y = JumpVelocity
	
	var direction := Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * Speed
		Sprite.flip_h = false if direction == 1 else true
	else:
		velocity.x = move_toward(velocity.x, 0, Speed)
	
	Animate(direction, Speed)
	move_and_slide()

func Animate(direction, speed):
	if is_on_floor():
		if direction == 0:
			if Input.is_action_pressed("Attack"):
				Sprite.play("Fight")
			else:
				Sprite.play("Idle")
		else:
			if speed == Run:
				Sprite.play("Run")
			else:
				Sprite.play("Walk")
	else:
		if velocity.y < 0:
			Sprite.play("Jump")

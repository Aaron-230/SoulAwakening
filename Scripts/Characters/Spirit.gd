extends CharacterBody2D

const Walk = 200.0
const Run = 400.0
const JumpVelocity = -400.0
const Damage = 50
var canAttack = false
var Attack = false
var Enemy: Node2D = null

var AttackDuration: float = 0.2
var AttackTimer: float = 0.0

@onready var Sprite: AnimatedSprite2D = $Sprite
@onready var Area: CollisionShape2D = $Attack/Area

func _physics_process(delta: float):
	var Speed = Walk
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if AttackTimer > 0.0:
		AttackTimer -= delta
	
	if Input.is_action_just_pressed("Attack") and is_on_floor() and AttackTimer <= 0.0:
		canAttack = true
		AttackTimer = AttackDuration
	else:
		canAttack = false
	
	if Input.is_action_pressed("Run") and is_on_floor():
		Speed = Run

	if Input.is_action_just_pressed("Jump") and is_on_floor():
		$Sounds/Jump.play()
		velocity.y = JumpVelocity
	
	var direction := Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * Speed
		Sprite.flip_h = false if direction == 1 else true
		Area.position.x = abs(Area.position.x) if direction == 1 else -abs(Area.position.x)
	else:
		velocity.x = move_toward(velocity.x, 0, Speed)
	
	Animate(direction, Speed, canAttack)
	move_and_slide()

func Animate(direction, speed, attack):
	if is_on_floor():
		if attack:
			Sprite.play("Fight")
			if Enemy != null:
				Enemy.takeDamage(Damage)
		else:
			if direction == 0:
				Sprite.play("Idle")
			else:
				if speed == Run:
					Sprite.play("Run")
				else:
					Sprite.play("Walk")
	else:
		if velocity.y < 0 or not is_on_floor():
			Sprite.play("Jump")

func _on_attack_body_entered(body: Node2D):
	if body.is_in_group("Enemy"):
		Enemy = body

func _on_attack_body_exited(body: Node2D):
	if body.is_in_group("Enemy"):
		Enemy= null

extends CharacterBody2D

@export var Speed: float = 200.0
@export var JumpVelocity: float = 100.0
@export var HP: int = 500
@export var Damage: int = 100
@export var PointsAwarded: int = 100000
@export var CoolTime: float = 1.5

@onready var Sprite: AnimatedSprite2D = $Sprite

@onready var FallDetectionRight: RayCast2D = $RayCasts/FallDetectionRight
@onready var FallDetectionLeft: RayCast2D = $RayCasts/FallDetectionLeft
@onready var WallDetectionRight: RayCast2D = $RayCasts/WallDetectionRight
@onready var WallDetectionLeft: RayCast2D = $RayCasts/WallDetectionLeft

var AttackTimer: float = 0.0
var Attack = false
var currentHP = HP
var Target: Node2D = null

func _physics_process(delta: float):
	Sprite.play("Idle")
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if AttackTimer > 0.0:
		AttackTimer -= delta
	
	if Target != null:
		Sprite.play("Walk")
		var Direction = (Target.global_position - global_position).normalized()
		
		if Attack and AttackTimer <= 0.0:
			performAttack()
		
		if Direction:
			if WallDetectionLeft.is_colliding() or WallDetectionRight.is_colliding():
				velocity.y = JumpVelocity
			
			if not FallDetectionLeft.is_colliding() or not WallDetectionRight.is_colliding():
				velocity = Vector2.ZERO
			
			velocity.x = Direction.x * Speed
			Sprite.flip_h = false if Direction.x > 0 else true
		else:
			velocity.x = move_toward(velocity.x, 0, Speed)

	move_and_slide()

func performAttack():
	velocity = Vector2.ZERO
	Sprite.play("Attack")
	Game.takeDamage(Damage)
	AttackTimer = CoolTime

func takeDamage(amount):
	Sprite.play("Hit")
	currentHP -= amount
	
	if currentHP <= 0:
		Sprite.play("Death")
		Game.addPoints(PointsAwarded)
		queue_free()
		$"../../UI/Panel".show()
		get_tree().paused = true

func _on_detection_body_entered(body: Node2D):
	if body.name == "Spirit":
		Target = body

func _on_detection_body_exited(body: Node2D):
	if body.name == "Spirit":
		Target = null

func _on_hitbox_body_entered(body: Node2D):
	if body.name == "Spirit":
		AttackTimer = CoolTime
		Attack = true

func _on_hitbox_body_exited(body: Node2D):
	if body.name == "Spirit":
		Attack = false

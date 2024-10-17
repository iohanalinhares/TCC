extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var animation := $anim as AnimatedSprite2D

func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Vector2.ZERO
	var direction_x := Input.get_axis("ui_left", "ui_right")
	var direction_y := Input.get_axis("ui_up", "ui_down")
	
	velocity.x = direction_x * SPEED
	velocity.y = direction_y * SPEED
	
	if direction_x != 0:
		animation.play("run")
		animation.scale.x = abs(animation.scale.x) * sign(direction_x)
	elif direction_y != 0:
		animation.play("run")
		animation.scale.x = abs(animation.scale.y) * sign(direction_y)
	elif direction_x == 0 and direction_y == 0:
		animation.play("idle")

	move_and_slide()

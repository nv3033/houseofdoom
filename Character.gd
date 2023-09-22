extends CharacterBody2D


const SPEED = 30.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func move(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

func face():
	if Input.is_action_pressed("ui_left"):
		$AnimatedSprite2D.scale.x = -1
	elif Input.is_action_pressed("ui_right"):
		$AnimatedSprite2D.scale.x = 1

func animate():
	if velocity.x == 0 and velocity.y == 0 or is_on_wall():
		$AnimatedSprite2D.play("idle")
	else:
		$AnimatedSprite2D.play("walk")

func _physics_process(delta):

	move(delta)
	face()
	animate()

	move_and_slide()

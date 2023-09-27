extends CharacterBody2D

const SPEED = 20.0
const JUMP_VELOCITY = -40.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
const DialogueSettings = preload("res://addons/dialogue_manager/components/settings.gd")
@onready var Inventory = get_tree().get_nodes_in_group("Inventory")[0]

#get_tree().get_root().get_node("black_screne").play("scene_start")

func start_dialogue(dialogue_path):
	print(dialogue_path)
	#var resource = load("res://dialogue_1st_scene.dialogue")
	var resource = load(dialogue_path)
	var title = "start"
	
	DialogueManager.show_example_dialogue_balloon(resource, title)
	#var dialogue_line = await resource.get_next_dialogue_line("this_is_a_node_title")

func move(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY
	var direction
	if dialogue_autoload.has_started == false and Inventory.opened == false:
		direction = Input.get_axis("ui_left", "ui_right")
		#if direction:
		velocity.x = direction * SPEED
		#else:
		#	velocity.x = move_toward(velocity.x, 0, SPEED)
	else:
		velocity.x = 0

func face():
	if Input.is_action_pressed("ui_left"):
		$AnimatedSprite2D.scale.x = -1
	elif Input.is_action_pressed("ui_right"):
		$AnimatedSprite2D.scale.x = 1

func animate():
	if velocity.x == 0 and velocity.y == 0 or is_on_wall():
		if $AnimatedSprite2D.scale.x == -1:
			$AnimatedSprite2D.play("idle_left")
		else:
			$AnimatedSprite2D.play("idle_right")
	else:
		if $AnimatedSprite2D.scale.x == -1:
			$AnimatedSprite2D.play("walk_left")
		else:
			$AnimatedSprite2D.play("walk_right")

func _physics_process(delta):

	move(delta)
	face()
	animate()

	move_and_slide()
	
	

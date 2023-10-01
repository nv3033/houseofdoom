extends CharacterBody2D

const SPEED = 20.0
const JUMP_VELOCITY = -40.0
var current_step_sound = true

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
const DialogueSettings = preload("res://addons/dialogue_manager/components/settings.gd")
@onready var Inventory = get_tree().get_nodes_in_group("Inventory")[0]
@onready var audio_player = $AudioStreamPlayer2D

#get_tree().get_root().get_node("black_screne").play("scene_start")

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ESCAPE and dialogue_autoload.has_started == false:
			save_pos()
			get_tree().change_scene_to_file("res://main_menu.tscn")

func save_pos():
	var SaveFile = FileAccess.open("user://savegame_pos.save", FileAccess.WRITE)
	SaveFile.store_line(JSON.stringify(transform.origin))

func save_scn():
	var SaveFile = FileAccess.open("user://savegame_scn.save", FileAccess.WRITE)
	SaveFile.store_line(JSON.stringify(get_tree().current_scene.scene_file_path))
	print(get_tree().current_scene.scene_file_path)

func _ready():
	save_scn()
	if FileAccess.file_exists("user://savegame_pos.save"):
		var SaveFile = FileAccess.open("user://savegame_pos.save", FileAccess.READ)
		var json = JSON.new()
		var parse_result = json.parse(SaveFile.get_line())
		var cords = json.get_data()
		cords = cords.erase(cords.find("("),1)
		cords = cords.erase(cords.find(")"),1)
		cords = cords.erase(cords.find(","),1)
		print(cords)
		transform.origin = Vector2(float(cords.left(cords.find(" "))), float(cords.right(cords.find(" "))))
		#print(transform.origin)

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



#connections

func _on_animated_sprite_2d_frame_changed():
	if current_step_sound and ($AnimatedSprite2D.get_animation() == "walk_left" or $AnimatedSprite2D.get_animation() == "walk_right"):
		#print("playing")
		audio_player.play()
	if $AnimatedSprite2D.get_animation() == "idle_left" or $AnimatedSprite2D.get_animation() == "idle_right":
		audio_player.stop()
	current_step_sound = !current_step_sound

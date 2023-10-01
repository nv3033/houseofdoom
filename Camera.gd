extends Camera2D
var player
var right_max_position = 0
var left_max_position = 0
func _ready():
	player = get_tree().get_nodes_in_group("player")[0]
	if get_tree().current_scene.scene_file_path == "res://1st_scene.tscn":
		right_max_position = 1000.0
		left_max_position = 48.0
	elif get_tree().current_scene.scene_file_path == "res://chvrch/chvrch.tscn":
		right_max_position = 560.0
		left_max_position = 48.0
	elif get_tree().current_scene.scene_file_path == "res://desert/desert.tscn":
		right_max_position = 1000.0
		left_max_position = -1000.0

func _physics_process(delta):
	if player.position.x + 30 <= right_max_position and player.position.x + 30 >= left_max_position:
		self.position.x = player.position.x + 30

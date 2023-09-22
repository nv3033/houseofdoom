extends Camera2D
var player
var right_max_position = 10000.0
var left_max_position = 30.0
func _ready():
	player = get_tree().get_nodes_in_group("player")[0]
func _physics_process(delta):
	
	if player.position.x + 30 <= right_max_position and player.position.x + 30 >= left_max_position:
		self.position.x = player.position.x + 30
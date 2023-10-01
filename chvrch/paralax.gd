extends Sprite2D

var camera
var q = 1.3

func _ready():
	camera = get_tree().get_root().get_node("chvrch/Camera2D")


func _process(delta):
	transform.origin = Vector2(camera.transform.get_origin()[0]-camera.transform.get_origin()[0]*q, transform.get_origin()[1])

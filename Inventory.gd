extends Sprite2D

@onready var opened = false
var items = []
var trasforms = [Vector2(-24, -24), Vector2(2, 0), 
Vector2(2, 0), Vector2(2, 0), 
Vector2(2, 0), Vector2(2, 0), 
Vector2(2, 0), Vector2(2, 0)]

func _input(event):
	if event is InputEventKey and event.pressed:
		print(items)
		if event.keycode == KEY_ALT and dialogue_autoload.has_started == false:
			opened = !opened

func draw_item(sprite_path, sprite_id):
	var new_sprite = Sprite2D.new()
	new_sprite.texture = load(sprite_path)
	new_sprite.transform.origin = trasforms[sprite_id]
	add_child(new_sprite)

func _process(delta):
	self.visible = opened

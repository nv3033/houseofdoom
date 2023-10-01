extends Sprite2D

var opened = false
@onready var pointer = $Sprite2D
var pointer_pos = 0
var items = []
var transforms = [Vector2(-24, -24), Vector2(-9, -24), 
Vector2(-24, -9), Vector2(-9, -9), 
Vector2(-24, 9), Vector2(-9, 9), 
Vector2(-24, 23), Vector2(-9, 23)]

func _ready():
	if FileAccess.file_exists("user://savegame_inv.save"):
		var SaveFile = FileAccess.open("user://savegame_inv.save", FileAccess.READ)
		while SaveFile.get_position() < SaveFile.get_length():
			var json = JSON.new()
			var parse_result = json.parse(SaveFile.get_line())
			var data = json.get_data()
			items = data
	print(items)
	move_pointer()
	for i in items:
		draw_item(i[3])


func _input(event):
	if event is InputEventKey and event.pressed:
		#print(items)
		if event.keycode == KEY_ALT and dialogue_autoload.has_started == false:
			opened = !opened
		if event.keycode == KEY_RIGHT and opened:
			pointer_pos += 1
			move_pointer()
		if event.keycode == KEY_LEFT and opened:
			pointer_pos -= 1
			move_pointer()
		if event.keycode == KEY_SPACE and opened:
			var resource = load(items[pointer_pos][2])
			var title = "start"
			DialogueManager.show_example_dialogue_balloon(resource, title)
			opened = !opened

func move_pointer():
	if pointer_pos == -1:
		pointer_pos = 7
	if pointer_pos == 8:
		pointer_pos = 0
	pointer.transform.origin = transforms[pointer_pos]
	if items != [] and pointer_pos < items.size():
		$text.text = items[pointer_pos][1]

func draw_item(sprite_path):
	var sprite_id
	for i in items:
		if i[3] == sprite_path:
			sprite_id = items.find(i)
	var new_sprite = Sprite2D.new()
	new_sprite.texture = load(sprite_path)
	new_sprite.transform.origin = transforms[sprite_id]
	add_child(new_sprite)

func _process(delta):
	self.visible = opened

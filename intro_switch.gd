extends AnimationPlayer

func _ready():
	var SaveFile = FileAccess.open("user://savegame_pos.save", FileAccess.WRITE)
	SaveFile.store_line(JSON.stringify(Vector2(0, 18)))

	SaveFile = FileAccess.open("user://savegame_scn.save", FileAccess.WRITE)
	SaveFile.store_line(JSON.stringify("res://1st_scene.tscn"))
	print(get_tree().current_scene.scene_file_path)

func _on_animation_finished(name):
	get_tree().change_scene_to_file("res://1st_scene.tscn")

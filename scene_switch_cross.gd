extends AnimationPlayer

func _ready():
	var SaveFile = FileAccess.open("user://savegame_pos.save", FileAccess.WRITE)
	SaveFile.store_line(JSON.stringify(Vector2(622, 18)))
func _on_animation_finished(name):
	get_tree().change_scene_to_file("res://chvrch/chvrch.tscn")

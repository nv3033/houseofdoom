extends Control

var SaveFile

func _on_new_game_pressed():
	SaveFile = FileAccess.open("user://savegame_inv.save", FileAccess.WRITE)
	get_tree().change_scene_to_file("res://intro.tscn")
	pass

func _on_continue_pressed():
	if FileAccess.file_exists("user://savegame_scn.save"):
		var SaveFile = FileAccess.open("user://savegame_scn.save", FileAccess.READ)
		var json = JSON.new()
		var parse_result = json.parse(SaveFile.get_line())
		var data = json.get_data()
		get_tree().change_scene_to_file(data)
	pass

func _on_quit_pressed():
	get_tree().quit()
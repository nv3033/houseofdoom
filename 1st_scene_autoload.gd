extends Node
var has_started = false

func check_black_bible():
	return false

func kill_the_priest():
	pass

func check_state():
	pass
	#print(has_started)

func give_item(name):
	var new_item = []
	var player = get_tree().get_nodes_in_group("player")[0]
	new_item.append(name)
	new_item.append(name)
	new_item.append("res://dialogue_" +name+".dialogue")
	new_item.append("res://" +name+".png")
	player.Inventory.items.append(new_item)
	var SaveFile = FileAccess.open("user://savegame_inv.save", FileAccess.WRITE)
	SaveFile.store_line(JSON.stringify(player.Inventory.items))
	player.Inventory.draw_item("res://" +name+".png")

func check_item(name):
	var Inventory = get_tree().get_nodes_in_group("Inventory")[0]
	var has_item = false
	for i in Inventory.items:
		if i[0] == name:
			has_item = true
	if has_item:
		#print(true)
		return true
	else:
		return false

func change_scene_back():
	var SaveFile = FileAccess.open("user://savegame_pos.save", FileAccess.WRITE)
	SaveFile.store_line(JSON.stringify(Vector2(0, 18)))
	SaveFile = FileAccess.open("user://savegame_scn.save", FileAccess.WRITE)
	SaveFile.store_line(JSON.stringify("res://1st_scene.tscn"))
	print(get_tree().current_scene.scene_file_path)
	get_tree().change_scene_to_file("res://1st_scene.tscn")

func change_scene_to_flower():
	get_tree().change_scene_to_file("res://flower.tscn")

func change_scene(name, pos):
	var SaveFile = FileAccess.open("user://savegame_pos.save", FileAccess.WRITE)
	SaveFile.store_line(JSON.stringify(pos))
	SaveFile = FileAccess.open("user://savegame_scn.save", FileAccess.WRITE)
	SaveFile.store_line(JSON.stringify("res://"+name+"/"+name+".tscn"))
	print(get_tree().current_scene.scene_file_path)
	get_tree().change_scene_to_file("res://"+name+"/"+name+".tscn")

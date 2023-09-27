extends Node
var has_started = false
func check_state():
	pass
	#print(has_started)
func change_scene():
	get_tree().change_scene_to_file("res://flower.tscn")

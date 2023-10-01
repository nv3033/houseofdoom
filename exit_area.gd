extends Area2D

func _on_body_entered(body):	
	if body in get_tree().get_nodes_in_group("player"):
		print("player entered exit screne")
		get_tree().get_root().get_node("/root/Node2D/Camera2D/Sprite2D/black_screne").play_backwards("scene_start")
		get_tree().change_scene_to_file("res://main_menu.tscn")

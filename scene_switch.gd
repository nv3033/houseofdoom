extends AnimationPlayer


func _on_animation_finished(name):
	#print("animation_finished")
	get_tree().change_scene_to_file("res://1st_scene.tscn")
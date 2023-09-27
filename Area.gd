extends Area2D

var contains_body = false
var player

func _on_body_entered(body):
	if body in get_tree().get_nodes_in_group("player"):
		contains_body = true
		player = body

func _on_body_exited(body):
	if body in get_tree().get_nodes_in_group("player"):
		contains_body = false

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_SPACE and contains_body:
			player.start_dialogue("res://dialogue_" +get_parent().name.to_lower()+".dialogue")
			var new_item = []
			new_item.append(get_parent().name.to_lower())
			new_item.append(get_parent().name.to_lower())
			new_item.append("res://dialogue_" +get_parent().name.to_lower()+".dialogue")
			new_item.append("res://" +get_parent().name.to_lower()+".png")
			var new_id = 0
			for i in player.Inventory.items:
				if i[4] == new_id:
					new_id += 1
				else:
					break
			new_item.append(new_id)
			player.Inventory.items.append(new_item)
			player.Inventory.draw_item("res://bible.png", new_id)
			get_parent().queue_free()

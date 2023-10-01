extends Area2D

var contains_body = false
@onready var player = get_tree().get_nodes_in_group("player")[0]
var objects = ["bible", "sword", "torch"]

func _process(delta):
	for i in player.Inventory.items:
		if i[0] == get_parent().name.to_lower():
			get_parent().queue_free()


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
			if get_parent().name.to_lower() in objects:
				var new_item = []
				new_item.append(get_parent().name.to_lower())
				new_item.append(get_parent().name.to_lower())
				new_item.append("res://dialogue_" +get_parent().name.to_lower()+".dialogue")
				new_item.append("res://" +get_parent().name.to_lower()+".png")
				player.Inventory.items.append(new_item)
				var SaveFile = FileAccess.open("user://savegame_inv.save", FileAccess.WRITE)
				SaveFile.store_line(JSON.stringify(player.Inventory.items))
				player.Inventory.draw_item("res://" +get_parent().name.to_lower()+".png")
			get_parent().queue_free()

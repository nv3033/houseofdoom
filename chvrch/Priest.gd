extends Node2D



func _ready():
	var Inventory = get_tree().get_nodes_in_group("Inventory")[0]
	for i in Inventory.items:
		if i[0] == "black_bible":
			print("the priest is dead")
			get_child(0).queue_free()
			get_child(1).queue_free()
			get_child(2).visible = true

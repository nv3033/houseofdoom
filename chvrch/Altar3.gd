extends Sprite2D



func _ready():
	texture = load("D:/GitHub/houseofdoom/chvrch/altar.png")
	var Inventory = get_tree().get_nodes_in_group("Inventory")[0]
	for i in Inventory.items:
		if i[0] == "black_bible":
			texture = load("D:/GitHub/houseofdoom/chvrch/altar_dead.png")

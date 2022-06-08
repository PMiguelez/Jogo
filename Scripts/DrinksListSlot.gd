extends VBoxContainer

func _ready():
	var banana = get_node("banana")
	banana.text = "abacaxi"
	banana.rect_position = Vector2(0,0)
	add_child(banana)

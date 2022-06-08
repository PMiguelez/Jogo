extends KinematicBody

func _input(event):
	if event.is_action_pressed("open_drinks"):
		get_tree().change_scene("res://Scenes/Drinks.tscn")

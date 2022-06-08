extends Control

var open_dg = false setget set_menu_open

func _unhandled_input(event):
	if event.is_action_pressed("open_dg"):
		self.open_dg = !open_dg

func set_menu_open(value):
	open_dg = value
	get_tree().paused = open_dg
	visible = open_dg

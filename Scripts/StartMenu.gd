extends Node2D

func _ready():
	pass 

func _on_Start_button_pressed():
		get_tree().change_scene("res://Scenes/Main.tscn")
		
func _on_Quit_button_pressed():
		get_tree().quit()

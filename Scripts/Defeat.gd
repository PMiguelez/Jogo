extends Spatial

func _ready():
	$defeat_music.play()

func _input(event):
	if Input.is_key_pressed(KEY_R):
		get_tree().change_scene("res://Scenes/Main.tscn")


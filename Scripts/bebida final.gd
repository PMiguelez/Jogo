extends StaticBody

var bebida = {}
var bebidas = {(1):Color.red}

func update_bebida():
	var material = $MeshInstance.get_surface_material(0)
	material.albedo_color = bebidas[tuple(bebida)]
	$MeshInstance.set_surface_material(0, material)

func _on_bebida_1_input_event(camera, event, position, normal, shape_idx, index):
	if (event is InputEventMouseButton and event.pressed):
		bebida.add(index)


func _on_bebida_2_input_event(camera, event, position, normal, shape_idx, index):
	if (event is InputEventMouseButton and event.pressed):
		bebida.add(index)


func _on_bebida_3_input_event(camera, event, position, normal, shape_idx, index):
	if (event is InputEventMouseButton and event.pressed):
		bebida.add(index)

extends StaticBody

func _ready():
	update_bebida(0)

func update_bebida(index):		
	var add = bebidas[index]
	for i in range(3):
		bebida[i] = (bebida[i] * density + add[i]) / (density + 1)
		
	density += 1
		
	if index == 0:
		density = 0
		bebida = [bebidas[0][0], bebidas[0][1], bebidas[0][2]]
		print(bebida)
		
	var material = $MeshInstance.get_surface_material(0)
	material.albedo_color = Color(bebida[0], bebida[1], bebida[2], 1)
	$MeshInstance.set_surface_material(0, material)
	
func _on_Resetar_input_event(camera, event, position, normal, shape_idx):
	if (event is InputEventMouseButton and event.pressed):
		update_bebida(0)

func on_input_event(event, index):
	if (event is InputEventMouseButton and event.pressed):
		update_bebida(index)

func _on_bebida_1_input_event(camera, event, position, normal, shape_idx, index):
	on_input_event(event, index)
func _on_bebida_2_input_event(camera, event, position, normal, shape_idx, index):
	on_input_event(event, index)
func _on_bebida_3_input_event(camera, event, position, normal, shape_idx, index):
	on_input_event(event, index)
func _on_bebida_4_input_event(camera, event, position, normal, shape_idx, index):
	on_input_event(event, index)
func _on_bebida_5_input_event(camera, event, position, normal, shape_idx, index):
	on_input_event(event, index)
func _on_bebida_6_input_event(camera, event, position, normal, shape_idx, index):
	on_input_event(event, index)
func _on_bebida_7_input_event(camera, event, position, normal, shape_idx, index):
	on_input_event(event, index)
func _on_bebida_8_input_event(camera, event, position, normal, shape_idx, index):
	on_input_event(event, index)
func _on_bebida_9_input_event(camera, event, position, normal, shape_idx, index):
	on_input_event(event, index)
	
var density = 0
var bebida = [0.0, 0.0, 0.0]
var bebidas = {0:[0.5, 0.5, 0.5], 
				1:[1.0,0.0,0.0], 2:[0.0,1.0,0.0], 3:[0.0,0.0,1.0], 
				4:[1.0,0.0,1.0], 5:[0.0,1.0,1.0], 6:[1.0,1.0,0.0],
				7:[1.0,1.0,1.0], 8:[0.2,0.2,0.2], 9:[0.6,0.2,1.0]}

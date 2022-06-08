extends Node

var bebidas = {0:[0.5, 0.5, 0.5], 
				1:[1.0,0.0,0.0], 2:[0.0,1.0,0.0], 3:[0.0,0.0,1.0], 
				4:[1.0,0.0,1.0], 5:[0.0,1.0,1.0], 6:[1.0,1.0,0.0],
				7:[1.0,1.0,1.0], 8:[0.2,0.2,0.2], 9:[0.6,0.2,1.0]}

func _ready():
	var i = 1
	for child in self.get_children():
		#var material = child.get_node("MeshInstance").get_surface_material(0)
		var material = SpatialMaterial.new()
		material.albedo_color = Color(bebidas[i][0], bebidas[i][1], bebidas[i][2], 1)
		child.get_node("MeshInstance").set_material_override(material)
		
		print(i)
		print(child)
		print(material.albedo_color)
		print(child.get_node("MeshInstance").get_surface_material(0).albedo_color)
		
		i += 1

	i = 1
	for child in self.get_children():
		print(child.get_node("MeshInstance").get_surface_material(0).albedo_color)
		i += 1

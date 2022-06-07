extends StaticBody

func _ready():
	var material = $MeshInstance.get_surface_material(0)
	material.albedo_color = get_parent().get_node("bebida 1/MeshInstance").get_surface_material(0).albedo_color
	$MeshInstance.set_surface_material(0,material)

	#get_node("MeshInstance").material_override.albedo_color = Color(0,0,0,1)

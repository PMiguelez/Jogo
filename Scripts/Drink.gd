extends StaticBody

var drink = [0, 0, 0, 0, 0, 0, 0, 0, 0]
var ingredientCount = 0
var drink_color = [0.0, 0.0, 0.0]
var ingredients = {0:[0.5, 0.5, 0.5], 
				1:[1.0,0.0,0.0], 2:[0.0,1.0,0.0], 3:[0.0,0.0,1.0], 
				4:[1.0,0.0,1.0], 5:[0.0,1.0,1.0], 6:[1.0,1.0,0.0],
				7:[1.0,1.0,1.0], 8:[0.2,0.2,0.2], 9:[0.6,0.2,1.0]}

func _ready():
	update_drink(0)

func update_drink(index):
	# Changes the color - Mixes the colors of all ingredients already chosen, equally
	var add = ingredients[index]
	for i in range(3):
		drink_color[i] = (drink_color[i] * ingredientCount + add[i]) / (ingredientCount + 1)
		
	ingredientCount += 1
		
	# Resets drink
	if index == 0:
		ingredientCount = 0
		drink_color = [ingredients[0][0], ingredients[0][1], ingredients[0][2]]
		drink = [0, 0, 0, 0, 0, 0, 0, 0, 0]
	else:
		drink[index-1]+=1
		
	# Updates objects color
	var material = $Liquid.get_surface_material(0)
	material.albedo_color = Color(drink_color[0], drink_color[1], drink_color[2], 1)
	$Liquid.set_surface_material(0, material)
	
# Reset button clicked -> resets drink
func resetDrink():
	update_drink(0)

func _on_ResetButton_input_event(camera, event, position, normal, shape_idx):
	if (event is InputEventMouseButton and event.pressed):
		resetDrink()

func _on_OrderButton_input_event(camera, event, position, normal, shape_idx):
	if (event is InputEventMouseButton and event.pressed):
		if get_node("/root/Bar/DrinksGuide").sendDrink(drink):
			resetDrink()

# Ingredient clicked -> adds its color to drink
func on_input_event(event, index):
	if (event is InputEventMouseButton and event.pressed):
		update_drink(index)

func _on_Ingredient1_input_event(camera, event, position, normal, shape_idx):
	on_input_event(event, 1)
func _on_Ingredient2_input_event(camera, event, position, normal, shape_idx):
	on_input_event(event, 2)
func _on_Ingredient3_input_event(camera, event, position, normal, shape_idx):
	on_input_event(event, 3)
func _on_Ingredient4_input_event(camera, event, position, normal, shape_idx):
	on_input_event(event, 4)
func _on_Ingredient5_input_event(camera, event, position, normal, shape_idx):
	on_input_event(event, 5)
func _on_Ingredient6_input_event(camera, event, position, normal, shape_idx):
	on_input_event(event, 6)
func _on_Ingredient7_input_event(camera, event, position, normal, shape_idx):
	on_input_event(event, 7)
func _on_Ingredient8_input_event(camera, event, position, normal, shape_idx):
	on_input_event(event, 8)
func _on_Ingredient9_input_event(camera, event, position, normal, shape_idx):
	on_input_event(event, 9)

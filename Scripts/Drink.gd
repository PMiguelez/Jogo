extends StaticBody

var drink = [0, 0, 0, 0, 0, 0, 0, 0, 0]
var ingredientCount = 0
var drink_color = [0.0, 0.0, 0.0]
var ingredients = {0:[0.5, 0.5, 0.5], 
				1:[1.0,0.0,0.0], 2:[0.0,1.0,0.0], 3:[0.0,0.0,1.0], 
				4:[1.0,0.0,1.0], 5:[0.0,1.0,1.0], 6:[1.0,1.0,0.0],
				7:[1.0,1.0,1.0], 8:[0.2,0.2,0.2], 9:[0.6,0.2,1.0]}

var counter1 = 0
var counter2 = 0
var counter3 = 0
var counter4 = 0
var counter5 = 0
var counter6 = 0
var counter7 = 0
var counter8 = 0
var counter9 = 0

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
	else:
		drink[index-1]+=1
		
	# Updates objects color
	var material = $Liquid.get_surface_material(0)
	material.albedo_color = Color(drink_color[0], drink_color[1], drink_color[2], 1)
	$Liquid.set_surface_material(0, material)
	
# Reset button clicked -> resets drink
func _on_ResetButton_input_event(camera, event, position, normal, shape_idx):
	if (event is InputEventMouseButton and event.pressed):
		update_drink(0)
		counter1 = 0
		counter2 = 0
		counter3 = 0
		counter4 = 0
		counter5 = 0
		counter6 = 0
		counter7 = 0
		counter8 = 0
		counter9 = 0
		get_node("/root/Drinks/Ingredients/I1Counter").text = ""
		get_node("/root/Drinks/Ingredients/I2Counter").text = ""
		get_node("/root/Drinks/Ingredients/I3Counter").text = ""
		get_node("/root/Drinks/Ingredients/I4Counter").text = ""
		get_node("/root/Drinks/Ingredients/I5Counter").text = ""
		get_node("/root/Drinks/Ingredients/I6Counter").text = ""
		get_node("/root/Drinks/Ingredients/I7Counter").text = ""
		get_node("/root/Drinks/Ingredients/I8Counter").text = ""
		get_node("/root/Drinks/Ingredients/I9Counter").text = ""

# Ingredient clicked -> adds its color to drink
func on_input_event(event, index):
	if (event is InputEventMouseButton and event.pressed):
		update_drink(index)

func _on_Ingredient1_input_event(camera, event, position, normal, shape_idx, index):
	on_input_event(event, index)
	if (event is InputEventMouseButton and event.pressed):
		counter1 += 1
		get_node("/root/Drinks/Ingredients/I1Counter").text = str(counter1)
func _on_Ingredient2_input_event(camera, event, position, normal, shape_idx, index):
	on_input_event(event, index)
	if (event is InputEventMouseButton and event.pressed):
		counter2 += 1
		get_node("/root/Drinks/Ingredients/I2Counter").text = str(counter2)
func _on_Ingredient3_input_event(camera, event, position, normal, shape_idx, index):
	on_input_event(event, index)
	if (event is InputEventMouseButton and event.pressed):
		counter3 += 1
		get_node("/root/Drinks/Ingredients/I3Counter").text = str(counter3)
func _on_Ingredient4_input_event(camera, event, position, normal, shape_idx, index):
	on_input_event(event, index)
	if (event is InputEventMouseButton and event.pressed):
		counter4 += 1
		get_node("/root/Drinks/Ingredients/I4Counter").text = str(counter4)
func _on_Ingredient5_input_event(camera, event, position, normal, shape_idx, index):
	on_input_event(event, index)
	if (event is InputEventMouseButton and event.pressed):
		counter5 += 1
		get_node("/root/Drinks/Ingredients/I5Counter").text = str(counter5)
func _on_Ingredient6_input_event(camera, event, position, normal, shape_idx, index):
	on_input_event(event, index)
	if (event is InputEventMouseButton and event.pressed):
		counter6 += 1
		get_node("/root/Drinks/Ingredients/I6Counter").text = str(counter6)
func _on_Ingredient7_input_event(camera, event, position, normal, shape_idx, index):
	on_input_event(event, index)
	if (event is InputEventMouseButton and event.pressed):
		counter7 += 1
		get_node("/root/Drinks/Ingredients/I7Counter").text = str(counter7)
func _on_Ingredient8_input_event(camera, event, position, normal, shape_idx, index):
	on_input_event(event, index)
	if (event is InputEventMouseButton and event.pressed):
		counter8 += 1
		get_node("/root/Drinks/Ingredients/I8Counter").text = str(counter8)
func _on_Ingredient9_input_event(camera, event, position, normal, shape_idx, index):
	on_input_event(event, index)
	if (event is InputEventMouseButton and event.pressed):
		counter9 += 1
		get_node("/root/Drinks/Ingredients/I9Counter").text = str(counter9)

func _on_CompleteButton_input_event(camera, event, position, normal, shape_idx):
	if (event is InputEventMouseButton and event.pressed):
		#if get_tree().get_root().get_node("Bar/DrinksGuide").drink_ingredient == drink:
			#print("ok")
		get_tree().change_scene("res://Scenes/Main.tscn")

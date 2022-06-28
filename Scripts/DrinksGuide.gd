extends Control

var subs_m = ['Padre', 'Boi', 'Destilado', 'Velho', 'Amor', 'Cavalo', 'Martelo', 'Dia', 'Capim', 'Vampiro', 'Lobisomen', 'Pedreiro', 'Camarada', 'Chefe', 'Antigo', 'Onibus', 'Corvo', 'Defunto', 'Ferro', 'Bronze', 'Cobre', 'Acido', 'Jardim', 'Bagre', 'Balde', 'Prego', 'Parafuso', 'Matagal', 'Jumento', 'Alemao', 'Leite', 'Alienigena']
var subs_f = ['Batida', 'Praia', 'Cadela', 'Colmeia', 'Floresta', 'Ilha', 'Noite', 'Nuvem', 'Flor', 'Agua', 'Terra', 'Fenix', 'Chuva', 'Tanajura', 'Caixa', 'Crianca', 'Orquidea', 'Tempestade']

var adj_m = ['Envenenado', 'Infernal', 'Austro-hungaro', 'Na praia', 'Maluco', 'Flamejante', 'Congelante', 'Congelado', 'Reluzente', 'Equilibrado', 'Desbocado', 'Florido', 'Marinho', 'Debochado', 'Agressivo', 'Bruto', 'Duvidoso', 'Charmoso', 'Fabuloso', 'Estourado', 'Euforico', 'Heroico', 'Explosivo', 'Jubiloso', 'Magnetico', 'Malicioso', 'Luxuoso', 'Gigante', 'Notavel', 'Puro', 'Radiante', 'Sapeca', 'Sedutor', 'Suculento', 'Tendencioso', 'Tirano', 'Verdadeiro', 'Weberiano', 'Wesleyano', 'Xenofobico', 'Serelepe', 'Zangado', 'Zen']
var adj_f = ['Envenenada', 'Infernal', 'Austro-hungara', 'Na praia', 'Maluca', 'Flamejante', 'Congelante', 'Congelada', 'Reluzente', 'Equilibrada', 'Desbocada', 'Florida', 'Marinha', 'Debochada', 'Agressiva', 'Bruta', 'Duvidosa', 'Charmosa', 'Fabulosa', 'Estourada', 'Euforica', 'Heroica', 'Explosiva', 'Jubilosa', 'Magnetica', 'Maliciosa', 'Luxuosa', 'Gigante', 'Notavel', 'Pura', 'Radiante', 'Sapeca', 'Sedutora', 'Suculenta', 'Tendenciosa', 'Tirana', 'Verdadeira', 'Weberiana', 'Wesleyana', 'Xenofobica', 'Serelepe', 'Zangada', 'Zen']

var drink_name = "padre austro-húngaro"
var drink_ingredients = [2,1,0,0,0,0,5,0,0]
var image_index = 0

var ingredients_names = ["Babúna", "Mitisko", "Calimel", "Xucrute", "Mentol", "Krita", "Jebão", "Tobias", "Banana"]

var random_gen = RandomNumberGenerator.new()
var load_ = false

var asking = -1
var client = -1
var order = []

var money = 0

func _process(delta):
	if load_ and get_node("/root/Bar/Display/Fade").get_current_animation() != "Fade":
		get_tree().change_scene("res://Scenes/Win.tscn")

func serialize():
	var strIngredients = ""
	for i in range(len(drink_ingredients)):
		if drink_ingredients[i] > 0:
			strIngredients += "x" + str(drink_ingredients[i]) + " " + ingredients_names[i] + "\n"
		
	$IngredientsBox/Ingredients.text = strIngredients
	$DrinksName.text = drink_name
	$DrinksImage.set_texture(load("res://Images/DrinksImages/"+str(image_index)+".png"))
	
func makeDrink():
	drink_ingredients = [0,0,0,0,0,0,0,0,0]
	
	# choosing drink ingredients
	var random_num = random_gen.randi_range(1,45)
	var diversity = 0
	while random_num > 0:
		random_num -= (9-diversity)
		diversity += 1
	
	var chosen = [0,1,2,3,4,5,6,7,8]
	for x in range((9-diversity)):
		chosen.remove(random_gen.randi_range(0, len(chosen)-1))
	
	var total = 1
	var expected = 1
	for i in chosen:
		drink_ingredients[i] = random_gen.randi_range(1, max(1, int(5 * total/expected)))
		total += drink_ingredients[i]
		expected += 5
		
	# choosing drink name
	random_num = random_gen.randi_range(0, len(subs_m) + len(subs_f) - 1)
	if random_num < len(subs_m):
		drink_name = subs_m[random_num] + " " + adj_m[random_gen.randi_range(0, len(adj_m)-1)]
	else:
		drink_name = subs_f[random_num - len(subs_m)] + " " + adj_f[random_gen.randi_range(0, len(adj_f)-1)]
	
	# choosing drink image
	image_index = random_gen.randi_range(1, 13)
	
func sendDrink(drink_made):
	if order == [] or client == -1:
		return false
		
	if order == drink_made:
		get_node("/root/Bar/correct_drink").play()
		money += random_gen.randi_range(4, 12)
		get_node("/root/Bar/Display/Money").text = "Dinheiro: "+str(money)
		get_node("/root/Bar/NPCs").giveDrink(client)
		if money >= 80:
			get_node("/root/Bar/Display/Fade").play("Fade")
			load_ = true
		return true
		
	get_node("/root/Bar/wrong_drink").play()
	money -= random_gen.randi_range(2, 6)
	get_node("/root/Bar/Display/Money").text = "Dinheiro: "+str(money)
	if money <= -15:
		get_tree().change_scene("res://Scenes/Defeat.tscn")
	return true
	
func _ready():
	random_gen.randomize()

func getDrink(index):
	makeDrink()
	serialize()
	var open_dg = true
	get_tree().paused = open_dg
	visible = open_dg
	
	asking = index

func _on_GoToDrinks_pressed():
	var open_dg = false
	get_tree().paused = open_dg
	visible = open_dg
	
	client = asking
	order = drink_ingredients
	
func _on_Close_pressed():
	var open_dg = false
	get_tree().paused = open_dg
	visible = open_dg

extends Control

var subs_m = ['Padre', 'Boi', 'Destilado', 'Velho', 'Amor', 'Cavalo', 'Martelo', 'Dia', 'Capim', 'Vampiro', 'Lobisomen', 'Pedreiro', 'Camarada', 'Chefe', 'Antigo', 'Onibus', 'Corvo', 'Defunto', 'Ferro', 'Bronze', 'Cobre', 'Acido', 'Jardim', 'Bagre', 'Balde', 'Prego', 'Parafuso', 'Matagal', 'Jumento', 'Alemao', 'Leite', 'Alienigena']
var subs_f = ['Batida', 'Praia', 'Cadela', 'Colmeia', 'Floresta', 'Ilha', 'Noite', 'Nuvem', 'Flor', 'Agua', 'Terra', 'Fenix', 'Chuva', 'Tanajura', 'Caixa', 'Crianca', 'Orquidea', 'Tempestade']

var adj_m = ['Envenenado', 'Infernal', 'Austro-hungaro', 'Na praia', 'Maluco', 'Flamejante', 'Congelante', 'Congelado', 'Reluzente', 'Equilibrado', 'Desbocado', 'Florido', 'Marinho', 'Debochado', 'Agressivo', 'Bruto', 'Duvidoso', 'Charmoso', 'Fabuloso', 'Estourado', 'Euforico', 'Heroico', 'Explosivo', 'Jubiloso', 'Magnetico', 'Malicioso', 'Luxuoso', 'Gigante', 'Notavel', 'Puro', 'Radiante', 'Sapeca', 'Sedutor', 'Suculento', 'Tendencioso', 'Tirano', 'Verdadeiro', 'Weberiano', 'Wesleyano', 'Xenofobico', 'Serelepe', 'Zangado', 'Zen']
var adj_f = ['Envenenada', 'Infernal', 'Austro-hungara', 'Na praia', 'Maluca', 'Flamejante', 'Congelante', 'Congelada', 'Reluzente', 'Equilibrada', 'Desbocada', 'Florida', 'Marinha', 'Debochada', 'Agressiva', 'Bruta', 'Duvidosa', 'Charmosa', 'Fabulosa', 'Estourada', 'Euforica', 'Heroica', 'Explosiva', 'Jubilosa', 'Magnetica', 'Maliciosa', 'Luxuosa', 'Gigante', 'Notavel', 'Pura', 'Radiante', 'Sapeca', 'Sedutora', 'Suculenta', 'Tendenciosa', 'Tirana', 'Verdadeira', 'Weberiana', 'Wesleyana', 'Xenofobica', 'Serelepe', 'Zangada', 'Zen']

var price = 0
var drink_name = "padre austro-húngaro"
var drink_ingredients = [2,1,0,0,0,0,5,0,0]
var image_index = 0

var drinks = [[],[],[],[],[],[],[],[],[],[]]

var ingredients_names = ["Babúna", "Mitisko", "Calimel", "Xucrute", "Mentol", "Krita", "Jebão", "Tobias", "Banana"]

var random_gen = RandomNumberGenerator.new()
var load_ = 0

var asking = -1
var client = -1
var order = []

var money = 20
var ing_cost = 1.00

var time = 0

func _ready():
	random_gen.randomize()

func _process(delta):
	if load_ != 0 and get_node("/root/Bar/Display/Fade").get_current_animation() != "Fade":
		if load_ == 1:
			get_tree().change_scene("res://Scenes/Win.tscn")
		else:
			get_tree().change_scene("res://Scenes/Defeat.tscn")
			
	time += delta
	if time > 2 + (ing_cost-1)*3:
		time -= (2 + (ing_cost-1)*3)
		ing_cost += 0.01
		get_node("/root/Bar/Display/Cost").text = str(ing_cost) + "$ / ing"
	
func serialize():
	var strIngredients = ""
	for i in range(len(drink_ingredients)):
		if drink_ingredients[i] > 0:
			strIngredients += "x" + str(drink_ingredients[i]) + " " + ingredients_names[i] + "\n"
		
	$IngredientsBox/Ingredients.text = strIngredients
	$DrinksName.text = drink_name + " " + str(price) + "$"
	$DrinksImage.set_texture(load("res://Images/DrinksImages/"+str(image_index)+".png"))
	
func makeDrink(i):
	if drinks[i] != []:
		drink_ingredients = drinks[i][0]
		drink_name = drinks[i][1]
		image_index = drinks[i][2]
		price = drinks[i][3]
		return
		
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
	
	# choosing price
	price = stepify(random_gen.randi_range(total, int(round(total*1.7))) * pow(diversity, 0.15 + random_gen.randf()*0.15), 0.25)
	
	drinks[i] = [drink_ingredients, drink_name, image_index, price]
	
func sendDrink(drink_made):
	if order == [] or client == -1:
		return false
		
	if order == drink_made:
		drinks[client] = []
		get_node("/root/Bar/correct_drink").play()
		money += price
		get_node("/root/Bar/Display/Money").text = "Dinheiro: " + str(money) + "$"
		get_node("/root/Bar/NPCs").giveDrink(client)
		if money >= 100:
			get_node("/root/Bar/Display/Fade").play("Fade")
			load_ = 1
		return true
		
	get_node("/root/Bar/wrong_drink").play()
	get_node("/root/Bar/Display/Money").text = "Dinheiro: "+str(money)
	return true

func getDrink(index):
	makeDrink(index)
	serialize()
	
	get_node("/root/Bar/Player/Camera").enabled = false
	visible = true
	
	asking = index
	
func pay():
	money -= stepify(ing_cost, 0.05)
	get_node("/root/Bar/Display/Money").text = "Dinheiro: " + str(money) + "$"
	
	if money <= 0:
		get_node("/root/Bar/Display/Fade").play("Fade")
		load_ = 2

func _on_GoToDrinks_pressed():
	get_node("/root/Bar/Player/Camera").enabled = true
	visible = false
	
	client = asking
	order = drink_ingredients
	
func _on_Close_pressed():
	get_node("/root/Bar/Player/Camera").enabled = true
	visible = false

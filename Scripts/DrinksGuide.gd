extends Control

var open_dg = false setget set_menu_open

func _unhandled_input(event):
	if event.is_action_pressed("open_dg"):
		self.open_dg = !open_dg

func set_menu_open(value):
	makeDrink()
	serialize()
	open_dg = value
	get_tree().paused = open_dg
	visible = open_dg

var subs_m = ["padre", "boi", "destilado", "velho", "amor", "cavalo", "martelo", "dia", "capim", "vampiro", "lobisomen", "pedreiro", "camarada", "chefe", "antigo", "onibus", "corvo", "defunto", "ferro", "bronze", "cobre", "acido", "jardim", "bagre", "balde", "prego", "parafuso", "matagal", "jumento", "alemao", "leite", "alienigena"]
var subs_f = ['batida', 'praia', 'cadela', 'colmeia', 'floresta', 'ilha', 'noite', 'nuvem', 'flor', 'agua', 'terra', 'fenix', 'chuva', 'tanajura', 'caixa', 'crianca', 'orquidea', 'tempestade']

var adj_m = ["envenenado", "infernal", "austro-hungaro", "na praia", "maluco", "flamejante", "congelante", "congelado", "reluzente", "equilibrado", "desbocado", "florido", "marinho", "debochado", "agressivo", "bruto", "duvidoso", "charmoso", "fabuloso", "estourado", "euforico", "heroico", "explosivo", "jubiloso", "magnetico", "malicioso", "luxuoso", "gigante", "notavel", "puro", "radiante", "sapeca", "sedutor", "suculento", "tendencioso", "tirano", "verdadeiro", "weberiano", "wesleyano", "xenofobico", "serelepe", "zangado", "zen"]
var adj_f = ["envenenada", "infernal", "austro-hungara", "na praia", "maluca", "flamejante", "congelante", "congelada", "reluzente", "equilibrada", "desbocada", "florida", "marinha", "debochada", "agressiva", "bruta", "duvidosa", "charmosa", "fabulosa", "estourada", "euforica", "heroica", "explosiva", "jubilosa", "magnetica", "maliciosa", "luxuosa", "gigante", "notavel", "pura", "radiante", "sapeca", "sedutora", "suculenta", "tendenciosa", "tirana", "verdadeira", "weberiana", "wesleyana", "xenofobica", "serelepe", "zangada", "zen"]

var drink_name = "padre austro-húngaro"
var drink_ingredients = [2,1,0,0,0,0,5,0,0]
var image_index = 0

var ingredients_names = ["Babúna", "Mitisco", "Calilme", "Xucrute", "Mentol", "Krita", "Jebão", "Tobias", "Banana"]

var random_gen = RandomNumberGenerator.new()

func serialize():
	var strIngredients = ""
	for i in range(len(drink_ingredients)):
		if drink_ingredients[i] > 0:
			strIngredients += "x" + str(drink_ingredients[i]) + " " + ingredients_names[i] + "\n"
		
	$IngredientsBox/Ingredients.text = strIngredients
	$DrinksName.text = drink_name
	$DrinksImage.set_texture(load("res://DrinksImages/"+str(image_index)+".jpg"))
	
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
	image_index = random_gen.randi_range(1, 2)
	
func _ready():
	random_gen.randomize()

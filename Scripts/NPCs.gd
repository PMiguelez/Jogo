extends Node

var point = [Vector3(-36.5, 7, -19), Vector3(-36.5, 7, -19), Vector3(-36.5, 7, -19), Vector3(-36.5, 7, -19), Vector3(-36.5, 7, -19), Vector3(-36.5, 7, -19), Vector3(-36.5, 7, -19), Vector3(-36.5, 7, -19), Vector3(-36.5, 7, -19), Vector3(-36.5, 7, -19)]
var speed = 10
var index = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
var active = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
var path
var seats = [0, 0, 0, 0, 0]
var ready = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
var seated = 0
var preseated = 0
var random_gen = RandomNumberGenerator.new()

#func _ready():
	#point = get_node("/root/Bar/Entry").get_children()[index].transform.origin

func _process(delta):
	for i in range(len(active)):
		if active[i]:
			if active[i] == 1:
				path = "/root/Bar/Entry"
				
				if index[i] > 1 and seats[index[i]-2] == 0:
					seats[index[i]-2] = 1
					active[i] = 2
					
			elif active[i] == 2:
				if ready[i]:
					path = "/root/Bar/Path"+str(i+1)
				
				else:
					continue
			elif active[i] == 3:
				index[i] = 0
				continue
			elif active[i] == 5:
				ready[i] = 0
				index[i] = 0
				active[i] = 0
			else:
				path = "/root/Bar/ExitPath"
				point[i] = get_node(path).get_children()[index[i]].transform.origin
			
			var direction = point[i] - get_node("NPC"+str(i+1)).transform.origin
			if point[i].distance_to(get_node("NPC"+str(i+1)).transform.origin) > 0.1:
				direction = direction.normalized() * speed
				
			elif point[i].distance_to(get_node("NPC"+str(i+1)).transform.origin) < 0.01:
				index[i] += 1
				if index[i] == get_node(path).get_child_count():
					if active[i] == 2:
						if seated == 8:
							seated = 7
							while true:
								var j = random_gen.randi_range(0,9)
								if active[j] == 3:
									index[j] = 0
									active[j] = 4
									break
						seated += 1
					active[i] = (active[i]+1)
					continue
			point[i] = get_node(path).get_children()[index[i]].transform.origin
			get_node("NPC"+str(i+1)).move_and_slide(direction)

func _on_StaticBody_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		var count = 0
		var count2 = 0
		var count3 = 0
		for j in seats:
			if j == 0:
				count3 += 1
		for j in range(len(active)):
			if active[j] == 1 or (active[j] == 2 and ready[j] == 0):
				count += 1
			if active[j] == 0:
				count2 += 1
		if count + seated < 10 and count < 5 and count2 > 0 and count3 > 0:
			while true:
				var i = random_gen.randi_range(0,9)
				if active[i] == 0:
					active[i] = 1
					break

func _on_NPC1_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.pressed and active[0] == 2:
		ready[0] = 1
		seats[index[0]-2] = 0
		index[0] = 0

func _on_NPC2_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.pressed and active[1] == 2:
		ready[1] = 1
		seats[index[1]-2] = 0
		index[1] = 0

func _on_NPC3_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.pressed and active[2] == 2:
		ready[2] = 1
		seats[index[2]-2] = 0
		index[2] = 0

func _on_NPC4_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.pressed and active[3] == 2:
		ready[3] = 1
		seats[index[3]-2] = 0
		index[3] = 0

func _on_NPC5_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.pressed and active[4] == 2:
		ready[4] = 1
		seats[index[4]-2] = 0
		index[4] = 0

func _on_NPC6_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.pressed and active[5] == 2:
		ready[5] = 1
		seats[index[5]-2] = 0
		index[5] = 0
		
func _on_NPC7_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.pressed and active[6] == 2:
		ready[6] = 1
		seats[index[6]-2] = 0
		index[6] = 0

func _on_NPC8_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.pressed and active[7] == 2:
		ready[7] = 1
		seats[index[7]-2] = 0
		index[7] = 0

func _on_NPC9_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.pressed and active[8] == 2:
		ready[8] = 1
		seats[index[8]-2] = 0
		index[8] = 0

func _on_NPC10_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.pressed and active[9] == 2:
		ready[9] = 1
		seats[index[9]-2] = 0
		index[9] = 0

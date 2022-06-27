extends Node

var point = [Vector3(-36.5, 7, -19), Vector3(-36.5, 7, -19), Vector3(-36.5, 7, -19), Vector3(-36.5, 7, -19), Vector3(-36.5, 7, -19), Vector3(-36.5, 7, -19), Vector3(-36.5, 7, -19), Vector3(-36.5, 7, -19), Vector3(-36.5, 7, -19), Vector3(-36.5, 7, -19)]
var speed = 12
var index = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
var active = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
var path
var seats = [0, 0, 0, 0, 0]
var ready = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
var seated = 0
var preseated = 0
var mov_accuracy = 0.15
var random_gen = RandomNumberGenerator.new()
var anim
var add = []

func _ready():
	random_gen.randomize()
	call_NPC()

func _process(delta):
	if len(add) > 0:
		if active[add[-1]] == 0:
			active[add[-1]] = 1
		elif active[add[-1]] == 2:
			add.pop_back()
	for i in range(len(active)):
		anim = get_node("NPC"+str(i+1)+"/AnimationPlayer")
		if active[i]:
			if active[i] == 1:
				if anim.get_current_animation() != "Walking":
					anim.play("Walking")
				path = "/root/Bar/Paths/Entry"
				
				if index[i] > 1 and seats[index[i]-2] == 0:
					seats[index[i]-2] = 1
					active[i] = 2
					if anim.get_current_animation() != "Talking":
						anim.play("Talking")
					
			elif active[i] == 2:
				if ready[i]:
					if anim.get_current_animation() != "Walking":
						anim.play("Walking")
					path = "/root/Bar/Paths/Path"+str(i+1)
				else:
					get_node("NPC"+str(i+1)).rotation_degrees.y = 180
					continue
				
			elif active[i] == 3:
				index[i] = 0
				continue
			elif active[i] == 5:
				ready[i] = 0
				index[i] = 0
				active[i] = 0
				point[i] = Vector3(-36.5, 7, -19)
				get_node("NPC"+str(i+1)).global_transform.origin = Vector3(-55, 7.2, -19)
				speed = 15
				mov_accuracy = 0.5
			else:
				speed = 12
				mov_accuracy = 0.15
				path = "/root/Bar/Paths/ExitPath"
				point[i] = get_node(path).get_children()[index[i]].transform.origin
			
			var direction = point[i] - get_node("NPC"+str(i+1)).transform.origin
			if point[i].distance_to(get_node("NPC"+str(i+1)).transform.origin) > mov_accuracy:
				direction = direction.normalized() * speed
			
			elif point[i].distance_to(get_node("NPC"+str(i+1)).transform.origin) < mov_accuracy:
				index[i] += 1
				#print(index)
				if index[i] == get_node(path).get_child_count():
					if active[i] == 1:
						active[i] = 0
					if active[i] == 2:
						if seated == 6:
							seated -= 1
							while true:
								var j = random_gen.randi_range(0,9)
								if active[j] == 3:
									index[j] = 0
									active[j] = 4
									break
						seated += 1
					active[i] = (active[i]+1)
					if active[i] == 3 :
						anim.play("Sitting")
					continue
			if index[i] < len(get_node(path).get_children()):
				point[i] = get_node(path).get_children()[index[i]].transform.origin
				get_node("NPC"+str(i+1)).move_and_slide(direction)
				get_node("NPC"+str(i+1)).look_at(point[i], get_node("NPC"+str(i+1)).transform.basis.y)
				get_node("NPC"+str(i+1)).rotation_degrees.x = 0
				get_node("NPC"+str(i+1)).rotation_degrees.z = 0
			
func call_NPC():
	var count3 = 0
	for j in seats:
		if j == 0:
			count3 += 1
	var calls = random_gen.randi_range(1, count3-len(add))
	for x in range(calls):
		var count = 0
		var count2 = 0
		for j in range(len(active)):
			if active[j] == 1 or (active[j] == 2 and ready[j] == 0):
				count += 1
			if active[j] == 0:
				count2 += 1
		if count + seated + len(add) < 10 and count < 5 and count2 > 0 and count3 > 0:
			while true:
				var i = random_gen.randi_range(0,9)
				if active[i] == 0:
					var is_in = false
					for y in add:
						if y == i:
							is_in = true
					if not is_in:
						add.append(i)
					break
					
func giveDrink(i):
	if index[i] == 7:
		index[i] = 6
	ready[i] = 1
	seats[index[i]-2] = 0
	index[i] = 0
	call_NPC()
					
func on_NPC_input(event, i):
	if event is InputEventMouseButton and event.pressed and active[i] == 2:
		get_node("/root/Bar/DrinksGuide").getDrink(i)

func _on_NPC1_input_event(camera, event, position, normal, shape_idx):
	on_NPC_input(event, 0)
func _on_NPC2_input_event(camera, event, position, normal, shape_idx):
	on_NPC_input(event, 1)
func _on_NPC3_input_event(camera, event, position, normal, shape_idx):
	on_NPC_input(event, 2)
func _on_NPC4_input_event(camera, event, position, normal, shape_idx):
	on_NPC_input(event, 3)
func _on_NPC5_input_event(camera, event, position, normal, shape_idx):
	on_NPC_input(event, 4)
func _on_NPC6_input_event(camera, event, position, normal, shape_idx):
	on_NPC_input(event, 5)	
func _on_NPC7_input_event(camera, event, position, normal, shape_idx):
	on_NPC_input(event, 6)
func _on_NPC8_input_event(camera, event, position, normal, shape_idx):
	on_NPC_input(event, 7)
func _on_NPC9_input_event(camera, event, position, normal, shape_idx):
	on_NPC_input(event, 8)
func _on_NPC10_input_event(camera, event, position, normal, shape_idx):
	on_NPC_input(event, 9)

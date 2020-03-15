extends Node2D

const moonPositions = [420, 520]

var bigOpts = []
var smallOpts = []
var moonPl

func _ready():
	bigOpts.append(preload("res://scenes/Bld1.tscn"))
	bigOpts.append(preload("res://scenes/Bld3.tscn"))
	bigOpts.append(preload("res://scenes/Bld4.tscn"))
	
	smallOpts.append(preload("res://scenes/Bld2.tscn"))
	smallOpts.append(preload("res://scenes/Bld5.tscn"))
	moonPl = preload("res://scenes/Moon.tscn")
	
	generate()

func generate():
	for child in get_children():
		remove_child(child)
		child.queue_free()
	
	bigOpts.shuffle()
	smallOpts.shuffle()
	
	var bldBig = bigOpts[0].instance()
	add_child(bldBig)
	bldBig.position.x = 220
	
	var bldSm = smallOpts[0].instance()
	add_child(bldSm)
	bldSm.position.x = 610

	var moon = moonPl.instance()
	add_child(moon)
	moon.position.x = moonPositions[rand_range(0, moonPositions.size())]
	moon.position.y = 135

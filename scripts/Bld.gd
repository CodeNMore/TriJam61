extends Area2D

export(int) var yPos = 0

var inArea = []

func _ready():
	position.y = yPos
	
func _process(delta):
	# Need to check in case bird no longer in cursor
	for bird in inArea:
		if !bird.inNegativeSpace and !bird.dead:
			bird.die();

func _on_bld_area_entered(area):
	if area is Bird:
		inArea.append(area)

func _on_bld_area_exited(area):
	if area is Bird:
		inArea.remove(inArea.find(area))

extends Area2D

onready var bg = $CursorBg

var firing = false
var fireTimer = 0.0

var birdsInArea = []

func _ready():
	bg.modulate = Color.white

func _process(delta):
	position = get_viewport().get_mouse_position()
	if firing:
		fireTimer += delta
		if fireTimer >= Globals.FIRE_TIME:
			firing = false
			bg.modulate = Color.white
	elif !firing and Input.is_action_just_pressed("fire"):
		firing = true
		fireTimer = 0.0
		bg.modulate = Color.red
		$"/root/".find_node("Sounds", true, false).find_node("Hit").play()
		for bird in birdsInArea:
			bird.kill()

func _on_Cursor_area_entered(area):
	if area is Bird:
		area.inNegativeSpace = true
		birdsInArea.append(area)

func _on_Cursor_area_exited(area):
	if area is Bird:
		area.inNegativeSpace = false
		birdsInArea.remove(birdsInArea.find(area))

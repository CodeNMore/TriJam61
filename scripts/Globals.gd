extends Node

const DEATH_TIME = 3.0
const FIRE_TIME = 0.05
const Y_THRESH = 2.0
const TARG_Y_MIN = 100.0
const TARG_Y_MAX = 480.0 - TARG_Y_MIN

var score = 0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	randomize()

func myLerp(from, to, step):
	if from < to:
		from += step
		if from > to:
			from = to
	elif from > to:
		from -= step
		if from < to:
			from = to
	return from

func reset():
	$"/root/".find_node("Game", true, false).lose()

func addScore(amt):
	score += amt
	$"/root/".find_node("Game", true, false).setScoreLbl(score)

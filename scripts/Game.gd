extends Node2D

onready var instr = $Instructions
onready var scoreLbl = $ScoreContainer/Score
onready var bldSet = $BldSet
onready var birdGen = $Birds
onready var soundDie = $Sounds/Die
onready var soundSuc = $Sounds/Success

var startPresses = 0

func _ready():
	bldSet.generate()
	bldSet.visible = false

func _process(delta):
	if startPresses < 3 and Input.is_action_just_pressed("fire"):
		startPresses += 1
		if startPresses >= 3:
			bldSet.generate()
			birdGen.start()
			instr.visible = false
			bldSet.visible = true
			Globals.score = 0
			setScoreLbl(Globals.score)

func lose():
	instr.visible = true
	birdGen.stop()
	bldSet.visible = false
	startPresses = 0
	soundDie.play()

func setScoreLbl(score):
	scoreLbl.text = "SCORE\n" + str(score)

func birdFinished(bird):
	if bird is Bird:
		bird.finish()
		soundSuc.play()

extends Node2D

class_name Bird

var inNegativeSpace = false
var dead = false
var deathTimer = 0.0

var speed = 50.0
var vSpeed = 25.0

func _ready():
	modulate = Color(rand_range(0.4, 0.8), rand_range(0.4, 0.8), rand_range(0.4, 0.8))

func setup(spd, vspd):
	speed = spd
	vSpeed = vspd
	position.x = -22.0
	position.y = rand_range(Globals.TARG_Y_MIN, Globals.TARG_Y_MAX)

func _physics_process(delta):
	if dead:
		deathTimer += delta
		if deathTimer > Globals.DEATH_TIME:
			get_parent().remove_child(self)
			queue_free()
	else:
		position.x += speed * delta
		position.y += vSpeed * delta #Globals.myLerp(position.y, targetY, vSpeed * delta)
		#if -Globals.Y_THRESH < position.y - targetY and Globals.Y_THRESH > position.y - targetY:
		#	genTarget()

# This bird reached its goal
func finish():
	if dead:
		return
	Globals.addScore(100)
	get_parent().remove_child(self)
	queue_free()

func playRemove():
	if dead:
		return
	dead = true
	$AnimatedSprite.visible = false
	$CPUParticles2D.emitting = true

# When the player kills it
func kill():
	if dead:
		return
	playRemove()
	Globals.addScore(-100)

# When it dies hitting something
func die():
	if dead:
		return
	playRemove()
	Globals.reset()

extends Node2D

const MIN_SPAWN_TIME = 3.0
const MAX_SPAWN_TIME = 4.0

const V_SPEED = 25.0

const MIN_H_SPEED = 80.0
const MAX_H_SPEED = 140.0

onready var birdPre = preload("res://scenes/Bird.tscn")
var running = false

var nextSpawnTime
var nextSpawnTimer
var nextHSpeed

func _physics_process(delta):
	if running:
		nextSpawnTimer += delta
		if nextSpawnTimer > nextSpawnTime:
			nextSpawnTimer = 0.0
			nextSpawnTime = rand_range(MIN_SPAWN_TIME, MAX_SPAWN_TIME)
			spawnBird()
			
func spawnBird():
	var bird = birdPre.instance()
	add_child(bird)
	bird.setup(nextHSpeed, rand_range(-V_SPEED, V_SPEED))
	nextHSpeed += 5.0
	if nextHSpeed > MAX_H_SPEED:
		nextHSpeed = MAX_H_SPEED

func start():
	for child in get_children():
		remove_child(child)
		child.queue_free()
		
	nextSpawnTime = 2.0
	nextSpawnTimer = 0.0
	nextHSpeed = MIN_H_SPEED
	running = true
	
func stop():
	running = false
	for child in get_children():
		child.playRemove()

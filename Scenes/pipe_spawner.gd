extends Node

class_name pipeSpawner

signal flappyDude_crashed
signal point_scored

var pipePair_scene = preload("res://Scenes/pipePair.tscn")

@export var pipe_speed = -150

@onready var spawn_timer = $spawnTimer

func _ready():
	spawn_timer.start()

func start_spawning_pipes():
	spawn_timer.timeout.connect(spawn_pipe)

func spawn_pipe():
	var pipe = pipePair_scene.instantiate() as pipePair
	add_child(pipe)
	
	var viewport_rect = get_viewport().get_camera_2d().get_viewport_rect()
	pipe.position.x = viewport_rect.end.x
	
	var half_height = viewport_rect.size.y / 2
	pipe.position.y = randf_range(viewport_rect.size.y * 0.15 - half_height, viewport_rect.size.y * 0.65 - half_height)
	
	pipe.flappyDude_entered.connect(on_flappyDude_entered)
	pipe.point_scored.connect(on_point_scored)
	pipe.set_speed(pipe_speed)
	
func on_flappyDude_entered():
	flappyDude_crashed.emit()
	stop()
	
func stop():
	spawn_timer.stop()
	for pipe in get_children().filter(func (child): return child is pipePair):
		(pipe as pipePair).speed = 0
	
func on_point_scored():
	point_scored.emit()
	

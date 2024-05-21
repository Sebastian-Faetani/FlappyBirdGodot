extends Node

@onready var flappy_dude = $"../flappyDude" as flappyDude
@onready var pipe_spawner = $"../pipeSpawner" as pipeSpawner
@onready var ground = $"../Ground" as Ground
@onready var fade = $"../Fade" as Fade
@onready var ui = $"../UI" as UI

var points = 0

func _ready():
	flappy_dude.game_started.connect(on_game_started)
	ground.flappyDude_crashed.connect(end_game)
	pipe_spawner.flappyDude_crashed.connect(end_game)
	pipe_spawner.point_scored.connect(on_point_scored)

func on_game_started():
	pipe_spawner.start_spawning_pipes()

func end_game():
	if fade != null:
		fade.play()
	ground.stop()
	flappy_dude.kill()
	pipe_spawner.stop()
	ui.on_game_over()

func on_point_scored():
	points += 1
	ui.update_points(points)

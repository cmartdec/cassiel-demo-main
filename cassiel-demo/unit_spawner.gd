extends Node2D

export (PackedScene) var enemy_scene:PackedScene
onready var spawn_timer = $SpawnTimer
var should_spawn = true

func _physics_process(delta):
	enemy_spawn()

func enemy_spawn():
	if should_spawn:
		var enemy = enemy_scene.instance()
		enemy.global_position = generate_random_position()
		get_tree().get_root().add_child(enemy)
		should_spawn = false
		spawn_timer.start()

func generate_random_position():
	var x = rand_range(37, 670)
	var y = rand_range(27, 510)
	
	return Vector2(x,y)

func _on_SpawnTimer_timeout():
	should_spawn = true

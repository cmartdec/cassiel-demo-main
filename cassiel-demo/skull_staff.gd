extends Node2D

const skull_staff_sfx = preload("res://items/skull_staff/skull_staff_sfx.wav")
const skull_staff_sfx2 = preload("res://items/skull_staff/skull_staff_sfx2.wav")

export(PackedScene) var projectile_scene:PackedScene
onready var attack_cooldown_timer = $AttackCooldownTimer
var should_shoot = true

func _physics_process(delta):
	shoot()
	
	
func shoot():
	if should_shoot:
		SoundManager2D.play(skull_staff_sfx2, global_position, -4.0)
		var projectile = projectile_scene.instance()
		projectile.global_position = global_position
		projectile.target = generate_random_destination()
		get_tree().get_root().add_child(projectile)
		should_shoot = false
		attack_cooldown_timer.start()
		
		
		
func generate_random_destination():
	var x = rand_range(37, 670)
	var y = rand_range(27, 510)
	return Vector2(x,y)		
		
func _on_AttackCooldownTimer_timeout():
	should_shoot = true

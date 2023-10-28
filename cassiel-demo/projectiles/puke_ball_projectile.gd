extends Node2D

var target = Vector2.ZERO
var angle = Vector2.ZERO
export var speed = 130.0

var puke_ball_projectile_destroy_effect = preload("res://projectiles/puke_projectile_destroy_effect.tscn")

func _ready():
	angle = global_position.direction_to(target)

func _physics_process(delta):
	global_position += angle * speed * delta
	speed += 1.2

func _on_Hitbox_area_entered(area):
	if !area.is_in_group("player"):
		var puke_ball_projectile_destroy_effect_instance = puke_ball_projectile_destroy_effect.instance()
		puke_ball_projectile_destroy_effect_instance.position = global_position
		get_tree().get_root().add_child(puke_ball_projectile_destroy_effect_instance)
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

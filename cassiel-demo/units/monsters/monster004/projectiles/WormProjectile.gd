extends Node2D

var target = Vector2.ZERO
var angle = Vector2.ZERO
var speed = 150

var worm_projectile_destroy_effect = preload("res://units/monsters/monster004/projectiles/WormProjectileDestroyEffect.tscn")

func _ready():
	angle = global_position.direction_to(target)
	rotation = angle.angle()
	
func _physics_process(delta):
	global_position += angle * speed * delta


func _on_Hitbox_area_entered(area):
	if !area.is_in_group("enemy"):
		var worm_projectile_destroy_effect_instance = worm_projectile_destroy_effect.instance()
		worm_projectile_destroy_effect_instance.position = global_position
		get_tree().get_root().add_child(worm_projectile_destroy_effect_instance)
		queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

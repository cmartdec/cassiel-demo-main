extends Node2D

export(PackedScene) var projectile_destroy_effect_scene:PackedScene

var target = Vector2.ZERO
var angle = Vector2.ZERO

var speed = 180


func _ready():
	angle = global_position.direction_to(target)
	rotation = angle.angle()
	
func _physics_process(delta):
	global_position += angle * speed * delta
	speed += 0.5

func _on_Hitbox_area_entered(area):
	queue_free()
	var projectile_destroy_effect = projectile_destroy_effect_scene.instance()
	projectile_destroy_effect.global_position = global_position
	get_tree().get_root().add_child(projectile_destroy_effect)

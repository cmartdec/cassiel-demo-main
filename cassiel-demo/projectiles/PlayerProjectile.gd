extends Node2D

var projectile_destroy_effect = preload("res://projectiles/projectile_destroy_effect.tscn")
onready var hitbox = $Hitbox

var target = Vector2.ZERO
var angle = Vector2.ZERO
var speed = 150 * PlayerStats.effects["stat_shoot_speed"]

func _ready():
	angle = global_position.direction_to(target)
	rotation = angle.angle()
	if RunData.item_with_crit_chances:
		var random_number = randf()
		if random_number < 0.2:
			hitbox.damage += hitbox.damage * 0.5
#	var rand_crit_chance = rand_range(1,5)
#	print(int(rand_crit_chance))
#	if int(rand_crit_chance) == 1:
#		print("crit hit")
#	else:
#		print("no hit")
#	hitbox.damage += hitbox.damage*RunData.damage
#	print(hitbox.damage)
	#damage implemented??

func _physics_process(delta):
	global_position += angle * speed * delta


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Hitbox_area_entered(area):
	if !area.is_in_group("player"):
		var projectile_destroy_effect_instance = projectile_destroy_effect.instance()
		projectile_destroy_effect_instance.position = global_position
		get_tree().get_root().add_child(projectile_destroy_effect_instance)
		queue_free()

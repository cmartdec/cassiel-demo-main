extends Node2D

var target = Vector2.ZERO
var angle = Vector2.ZERO

export var speed = 0


export var should_rotate = false

onready var animation_player = $AnimationPlayer

func _ready():
	speed *= PlayerStats.effects["stat_shoot_speed"]
	if should_rotate:
		animation_player.play("rotation")
		
	angle = global_position.direction_to(target)

func _physics_process(delta):
	global_position += angle * speed * delta


func _on_Hitbox_area_entered(area):
	if !area.is_in_group("player"):
		queue_free()

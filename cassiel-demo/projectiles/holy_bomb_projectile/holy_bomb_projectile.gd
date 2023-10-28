extends RigidBody2D

onready var animation_player = $AnimationPlayer
onready var _hitbox_collision_shape = $Hitbox/CollisionShape2D
onready var timer = $TimeToExplosion

func _ready():
	animation_player.play("running")

func explosion():
	animation_player.play("destroy")
	_hitbox_collision_shape.set_deferred("disabled", false)

func destroy_projectile():
	queue_free()

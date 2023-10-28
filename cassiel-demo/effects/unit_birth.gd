extends Node2D

signal birth_timeout(unit, pos)

var time_before_spawn = 60.0
var unit_to_spawn = null
var birth_pos = null
onready var sprite = $Sprite

func _ready():
	birth_pos = global_position
	sprite.modulate = Color(0.235294, 0, 0)

func set_unit(scene: PackedScene):
	unit_to_spawn = scene

func _physics_process(delta):
	time_before_spawn -= Utils.physics_one(delta)

	if time_before_spawn <= 0:
		queue_free()
		emit_signal("birth_timeout", unit_to_spawn, birth_pos)
		

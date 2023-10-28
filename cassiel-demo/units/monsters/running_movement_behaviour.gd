extends Node2D

var player = null
var vec_to_player = null
export var moveSpeed = 30.0
onready var kinematic_body = get_parent()
onready var animator = $AnimationPlayer

func _ready():
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player = players[0]

func _physics_process(delta):
	if !RunData.wave_ended:
		get_movement()
	else:
		animator.stop()

func get_movement():
	vec_to_player = global_position.direction_to(player.global_position)
	kinematic_body.move_and_slide(vec_to_player.normalized() * moveSpeed)
	if vec_to_player.x > 0.1:
		animator.play("running_right")
	else:
		animator.play("running_left")

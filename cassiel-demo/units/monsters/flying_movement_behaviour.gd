extends Node2D

var player = null
export var moveSpeed = 55.0
onready var kinematic_body = get_parent()
onready var animator = $AnimationPlayer


func _ready():
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player = players[0]

func _physics_process(delta):
	get_movement()
	
func get_movement():
	if !RunData.wave_ended:
		var vec_to_player = global_position.direction_to(player.global_position)
		kinematic_body.move_and_slide(vec_to_player.normalized() * moveSpeed)
		animator.play("flying")



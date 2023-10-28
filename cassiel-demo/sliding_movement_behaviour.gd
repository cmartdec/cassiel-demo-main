extends Node2D

enum STATES {NOT_ATTACKING, ATTACKING}
var cur_state = STATES.NOT_ATTACKING

var worm_projectile_scene = preload("res://units/monsters/monster004/projectiles/WormProjectile.tscn")
var should_shoot = true

var player = null
var vec_to_player = null
var vec_to_player_without_normalized = null
export var moveSpeed = 30.0
onready var kinematic_body = get_parent()
onready var animator = $AnimationPlayer
onready var sprite_node = kinematic_body.get_node("Sprite")
onready var attack_cooldown_timer = kinematic_body.get_node("AttackCooldown")



func _ready():
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player = players[0]
	

func _physics_process(delta):
	if !RunData.wave_ended:
		vec_to_player = global_position.direction_to(player.global_position)
		vec_to_player_without_normalized = player.global_position - global_position
		kinematic_body.move_and_slide(vec_to_player * moveSpeed)
		if vec_to_player_without_normalized.x < 150 and vec_to_player_without_normalized.x > -150 and vec_to_player_without_normalized.y > -120 and vec_to_player_without_normalized.y < 120:
			cur_state = STATES.ATTACKING
		else:
			cur_state = STATES.NOT_ATTACKING
			
		match cur_state:
			STATES.NOT_ATTACKING:
				notAttackingState(vec_to_player.x)
			STATES.ATTACKING:
				attackingState(vec_to_player.x)

func attackingState(direction):		
	if should_shoot:
		var worm_projectile = worm_projectile_scene.instance()
		worm_projectile.global_position = global_position
		worm_projectile.target = player.global_position
		get_tree().get_root().add_child(worm_projectile)
		should_shoot = false
		attack_cooldown_timer.start()
		
	animator.play("attacking")
	if direction > 0.1:
		sprite_node.flip_h = false
	else:
		sprite_node.flip_h = true
		
func notAttackingState(direction):
	animator.play("sliding")
	if direction > 0.1:
		sprite_node.flip_h = false
	else:
		sprite_node.flip_h = true


func _on_AttackCooldown_timeout():
	should_shoot = true

extends KinematicBody2D

const HIT_SFX = preload("res://units/monsters/hitHurt.wav")


export (PackedScene) var floating_text

export var health = 10
var player = null
var vec_to_player: Vector2 = Vector2.ZERO
var gold_to_spawn = []
export var moveSpeed = 30.0
export (PackedScene) var gold_scene:PackedScene
export (PackedScene) var gold_coin_scene:PackedScene
onready var spriteRenderer = $Sprite
onready var spriteMaterial = $Sprite.material
onready var hitTimer = $HitTimer
export var KNOCKBACK_FORCE = 250
onready var animation_player = $MovementBehaviour/AnimationPlayer


func _ready():
	gold_to_spawn = [gold_scene, gold_coin_scene]
	var players = get_tree().get_nodes_in_group("player")
	
	if players.size() > 0:
		player = players[0]

func _on_hit(damage):
	spriteMaterial.set_shader_param("active", true)
	display_floating_text(damage);
	hitTimer.start()
	SoundManager.play(HIT_SFX)

func display_floating_text(damage):
	var floating_text_instance: = floating_text.instance() as FloatingText
	floating_text_instance.rect_position = global_position 
	get_tree().get_root().add_child(floating_text_instance)
	floating_text_instance.display(str(damage), 0.5, Color.white)

func _on_Hurtbox_hurt(damage):
	health -= damage * PlayerStats.effects["stat_damage"]
	print(damage * PlayerStats.effects["stat_damage"])
	_on_hit(damage * PlayerStats.effects["stat_damage"])
	var knockback_direction = (global_position - player.global_position).normalized()
	move_and_slide(knockback_direction * KNOCKBACK_FORCE)

func spawn_gold():
	var gold_node = get_tree().get_root().get_node("MainChapel/Gold")
	var random_number = randf()
	if random_number > 0.7:
		for i in range(2):
			var gold_instance = gold_scene.instance()
			gold_instance.global_position = global_position
			gold_node.add_child(gold_instance)
	else:
		var gold_instance = gold_scene.instance()
		gold_instance.global_position = global_position
		gold_node.add_child(gold_instance)
#	get_tree().get_root().add_child(gold_instance)

func _on_die():
	spawn_gold()
	queue_free()

func _on_HitTimer_timeout():
	spriteMaterial.set_shader_param("active", false)
	if health <= 0:
		_on_die()
	

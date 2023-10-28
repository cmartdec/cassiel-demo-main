extends KinematicBody2D

const gold_collect_sfx = preload("res://pickups/gold/collect.wav")
const game_over_sfx = preload("res://ui/menus/end_run/player_died.wav")
const hit_sfx = preload("res://units/player/hit_sfx.wav")
var _camera_shake_duration = 0.1

onready var attackCooldown = $AttackCooldown
onready var weapon_service = $WeaponService
onready var animation_player = $MovementBehaviour/AnimationPlayer
onready var _collision = $CollisionShape2D
onready var _collision_hurtbox = $Hurtbox/CollisionShape2D
onready var spriteMaterial = $Sprite.material
onready var damage_vignette = $UI/DamageVignette
onready var hitTimer = $HitTimer
onready var game_over_timer = $GameOverTimer
onready var healthBar = $UI/MaginContainer/PlayerInfo/HealthBar
onready var health_label = $UI/MaginContainer/PlayerInfo/HealthBar/Label
onready var updateTween = $UI/MaginContainer/PlayerInfo/UpdateTween
onready var gold_label = $UI/MaginContainer/PlayerInfo/UIGold/GoldLabel
onready var wave_ended_panel = $UI/WaveEndedPanel
onready var run_lost_label = $UI/RunLostLabel
onready var _camera = $Camera2D

export var max_health = 0.0
export var gold = 0
export var step_sounds = []

var damage_vignette_multiplier = 0.8


	
func _ready():
	print("hello from players")
#	health = max_health
	add_weapons_to_player()			
	wave_ended_panel.visible = false
	run_lost_label.visible = false
	RunData.player_health = PlayerStats.effects["stat_health"]
#	PlayerStats.effects["stat_health"] = base_health
#	PlayerStats.effects["stat_health"] = max_health
	health_label.text = str(PlayerStats.effects["stat_health"] as int) + "/" + str(PlayerStats.effects["stat_health"] as int)
	healthBar.max_value = PlayerStats.effects["stat_health"]
	healthBar.value = PlayerStats.effects["stat_health"]
	damage_vignette.material.set_shader_param("multiplier", damage_vignette_multiplier)
	
#
#func _process(delta):
#	if Input.is_action_pressed("attack_down"):
#		get_tree().paused = true
#	if Input.is_action_pressed("attack_up"):
#		get_tree().paused = false
	
	
func _process(delta):
		if _camera_shake_duration <= 0:
			_camera.offset = Vector2.ZERO
			_camera_shake_duration = 0.0
			return
		_camera_shake_duration -= delta
		_camera.offset = Vector2(randf(), randf()) * 3
	
func add_items_to_inventory():
	pass
	
func add_weapons_to_player():
	#i is a PackedScene, i should be a instance of i
	if RunData.weapons.size() > 0:
		for i in RunData.weapons:
					weapon_service.add_child(i.instance())
	else:
		return
	
func on_hit():
	SoundManager.play(hit_sfx)
	damage_vignette_multiplier -= 0.3
	spriteMaterial.set_shader_param("active", true)
	damage_vignette.material.set_shader_param("multiplier", damage_vignette_multiplier)
	hitTimer.start()
	camera_shake(0.1)
	
func camera_shake(duration):
	if duration > _camera_shake_duration:
		_camera_shake_duration = duration

func _on_Hurtbox_hurt(damage):
	RunData.player_health -= damage * PlayerStats.effects["stat_armor"]
	if RunData.player_health <= 0:
		die()
	updateTween.interpolate_property(healthBar, "value", healthBar.value, RunData.player_health, 0.4, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	health_label.text = str(RunData.player_health as int) + "/" + str(PlayerStats.effects["stat_health"] as int)
	updateTween.start()
	on_hit()

func die():
	print("player died")
	SoundManager.play(game_over_sfx)
	wave_ended_panel.visible = true
	run_lost_label.visible = true
	RunData.current_wave = 1
	game_over_timer.start()
	animation_player.play("death")
#	_collision.set_deferred("disabled", true)
	_collision_hurtbox.set_deferred("disabled", true)
#	_collision_hurtbox.set_deferred("disabled", true)
	RunData.wave_ended = true
	PlayerStats.clean_up()
#	RunData.clean_up_stats()
	
func _on_ItemAttractArea_area_entered(area):
	if area.is_in_group("gold"):
		area.attracted_by = self

func _on_ItemPickupArea_area_entered(area):
	if area.is_in_group("healing"):
		RunData.player_health += 10
	else:
		area.queue_free()
		var pitch_scale_sfx = rand_range(0.8, 1.2)
		SoundManager2D.play(gold_collect_sfx, global_position, -12.0, pitch_scale_sfx)
		RunData.gold += 1
		gold_label.text = str(RunData.gold)

func _on_HitTimer_timeout():
	spriteMaterial.set_shader_param("active", false)

func _on_GameOverTimer_timeout():
	get_tree().change_scene(MenuData.end_run_scene)

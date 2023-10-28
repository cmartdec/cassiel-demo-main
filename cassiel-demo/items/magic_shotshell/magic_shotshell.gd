extends Node2D

const SHOOT_SFX = preload("res://items/magic_shotshell/MMO_Game_Magic_Designed_Fire_Cast_05.mp3")

export (PackedScene) var spell_scene:PackedScene
var targets = []
onready var attack_cooldown_timer = $AttackCooldownTimer
var should_shoot = true


func _physics_process(delta):
	if !RunData.player_in_shop:
		shoot()

func shoot():
	if should_shoot:
		SoundManager2D.play(SHOOT_SFX, global_position)
		var random_idx = rand_range(0, targets.size())
		var angle = Vector2.ZERO
		if !targets.empty():
			angle = global_position.direction_to(targets[random_idx].global_position)
		var spell = spell_scene.instance()
		spell.global_position = global_position
		spell.rotation = angle.angle()
		spell.start_animation()
		get_tree().get_root().add_child(spell)
		should_shoot = false
		attack_cooldown_timer.start()


func _on_Range_area_entered(area):
	print(area)
	targets.append(area)

func _on_Range_area_exited(area):
	targets.erase(area)


func _on_AttackCooldownTimer_timeout():
	should_shoot = true

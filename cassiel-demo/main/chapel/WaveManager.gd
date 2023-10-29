extends Node2D

onready var timer = $Timer
onready var spawn_timer = $SpawnTimer
onready var wave_completed_label = $CanvasLayer/WaveCompletedLabel
onready var panel_wave_ended = $CanvasLayer/WaveEndedPanel
onready var enemies = get_parent().get_node("Enemies")
onready var births_container = get_parent().get_node("Births")
onready var wave_timer_label = $CanvasLayer/WaveTimerLabel
onready var current_wave_label = $CanvasLayer/CurrentWaveLabel
onready var wait_timer_shop = $WaitTimerShop
export var remaining_seconds = 0
export var current_wave = RunData.current_wave


export var waves = []

var unit_birth_scene = preload("res://effects/UnitBirth.tscn")
const wave_completed_sfx = preload("res://ui/menus/run/Complete.wav")

var red_color = Color(1.0, 0.0, 0.0)
var white_color = Color(1.0, 1.0, 1.0)

var should_spawn = true

export (PackedScene) var enemy_scene:PackedScene
export (PackedScene) var player_scene:PackedScene

export var m_array = [[], []]

var _player

#m_array[RunData.current_wave]

func _ready():
	set_wave_data(RunData.current_wave)
#	print(m_array[RunData.current_wave-1][rand_range(0,m_array[RunData.current_wave-1].size())])
	_player = spawn_player(player_scene, Vector2(670/2, 510/2), true)
#	if RunData.current_wave > 4:
#		if RunData.current_wave > 6:
#			RunData.duration_wave = 50
#			RunData.delay_spawn_time = 0.20
#		else:
#			RunData.duration_wave = 45
#			RunData.delay_spawn_time = 0.35
	RunData.wave_ended = false
	wave_timer_label.modulate = white_color
	panel_wave_ended.visible = false
	wave_completed_label.visible = false
	wave_timer_label.text = str(remaining_seconds)
	current_wave_label.text = "WAVE " + str(current_wave)
	timer.start()

func set_wave_data(current_wave):
	remaining_seconds = waves[current_wave-1].duration_wave
	spawn_timer.wait_time = waves[current_wave-1].enemy_spawn_time

func _physics_process(delta):
	if !RunData.wave_ended:
		spawn_enemy()
		
func spawn_player(scene:PackedScene, pos:Vector2, is_player:bool = false):
	var player = scene.instance()
	
	player.global_position = pos
	get_parent().call_deferred("add_child", player)
	
func spawn_enemy():
	
	#REWORK TO BE DONE
	if should_spawn:
#		var random_number = rand_range(0, RunData.current_wave)
#		var random_integer = int(random_number)
		var unit_pos = generate_random_position()
		var unit_birth = unit_birth_scene.instance()
		unit_birth.set_unit(m_array[RunData.current_wave-1][rand_range(0,m_array[RunData.current_wave-1].size())])
		unit_birth.global_position = unit_pos
		unit_birth.connect("birth_timeout", self, "on_unit_birth_timeout")
		births_container.add_child(unit_birth)
		should_spawn = false
		spawn_timer.start()


func on_unit_birth_timeout(unit, pos):
	if !RunData.wave_ended:
		var enemy = unit.instance()
		enemy.global_position = pos
		enemies.add_child(enemy)
	
func generate_random_position():
	var x = rand_range(37, 670)
	var y = rand_range(27, 510)
	return Vector2(x,y)


func _on_wave_ended():
	print("wave ended")
	SoundManager.play(wave_completed_sfx)
	wait_timer_shop.start()
	panel_wave_ended.visible = true
	wave_timer_label.visible = false
	current_wave_label.visible = false
	wave_completed_label.visible = true
	RunData.wave_ended = true
	RunData.player_in_shop = true
	for e in enemies.get_children():
		e.queue_free()
	

func _on_Timer_timeout():
	if !RunData.wave_ended:
		if remaining_seconds > 0:
			remaining_seconds -= 1
			if remaining_seconds < 6:
#				wave_timer_label.modulate = red_color
				wave_timer_label.modulate = Utils.get_red_color()
			wave_timer_label.text = str(remaining_seconds)
			timer.start()
		else:
			_on_wave_ended()

func _on_SpawnTimer_timeout():
	should_spawn = true


func _on_WaitTimerShop_timeout():
	get_tree().change_scene("res://main/shop/Shop.tscn")


	

extends Node2D

onready var animation_player = $AnimationPlayer
onready var kinematic_body = get_parent()
export var step_sounds = []

var _rng: = RandomNumberGenerator.new()

func _physics_process(delta):
	if !RunData.wave_ended:
		get_movement(delta)

func get_movement(delta):
	var velocity = Vector2.ZERO
#
	if(Input.is_action_pressed("ui_right")):
		velocity.x += 1
		animation_player.play("moving_side_flipped")
	if(Input.is_action_pressed("ui_left")):
		velocity.x -= 1
		animation_player.play("moving_side")
	if(Input.is_action_pressed("ui_up")):
		velocity.y -= 1	
	if(Input.is_action_pressed("ui_down")):
		velocity.y += 1	
	velocity = velocity.normalized()

	if velocity == Vector2.ZERO:
		animation_player.stop()
#	else:
#		play_step_sound()
	
		
	kinematic_body.move_and_slide(velocity * PlayerStats.effects["stat_speed"])
		
#func play_step_sound():
#	SoundManager.play(get_random_element(step_sounds))	
#
#func get_random_element(array):
#	return array[get_random_int(0, array.size() - 1)]
#
#func get_random_int(from, to):
#	return _rng.randi_range(from, to)


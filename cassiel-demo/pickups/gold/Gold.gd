class_name Gold 
extends Area2D


var attracted_by: Node2D
var moveSpeed = 200
var push_back_speed = 30
var current_pos  = Vector2.ZERO
var target_pos = Vector2.ZERO
var target_pos_x = 0
var target_pos_y = 0
var add_am_array = [-2,2,3,-3,4,-4]
var can_pickup = false

#bool to take it up
func _ready():
	var add_am_idx = rand_range(0, add_am_array.size())
	target_pos_x = global_position.x + add_am_array[add_am_idx]
	target_pos_y = global_position.y + add_am_array[add_am_idx]
	target_pos = Vector2(target_pos_x, target_pos_y)

func _physics_process(delta):	
	global_position = global_position.move_toward(target_pos, push_back_speed * delta)
	can_pickup = true
	
	
	if attracted_by != null and can_pickup:
		global_position = global_position.move_toward(attracted_by.global_position, moveSpeed * delta)
		moveSpeed += 5


extends Node2D

var angle = 0.0
var rotationSpeed = 2.0
var radius = 40.0
onready var _sprite = $Sprite
onready var _collision = $Hitbox/CollisionShape2D
onready var timer = $Timer
var is_active = false

func _ready():
	pass

func _physics_process(delta):
	movement(delta)
		
func movement(delta):
	angle += delta * rotationSpeed
	var x = radius * cos(angle)
	var y = radius * sin(angle)
	position = Vector2(x, y)

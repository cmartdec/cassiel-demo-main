extends Node2D

func _ready():
	$AnimatedSprite.frame = 0

func start_animation():
	$AnimatedSprite.play("default")

func _on_AnimatedSprite_animation_finished():
	queue_free()
	print("destroyed")

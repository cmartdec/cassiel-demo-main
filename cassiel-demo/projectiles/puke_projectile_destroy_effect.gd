extends AnimatedSprite


func _on_puke_projectile_destroy_effect_animation_finished():
	queue_free()

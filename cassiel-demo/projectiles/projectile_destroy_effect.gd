extends AnimatedSprite

func _on_projectile_destroy_effect_animation_finished():
	queue_free()

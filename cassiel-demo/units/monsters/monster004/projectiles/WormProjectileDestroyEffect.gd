extends AnimatedSprite

func _on_worm_projectile_destroy_effect_animation_finished():
	queue_free()

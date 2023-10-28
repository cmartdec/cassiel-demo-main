class_name Hurtbox
extends Area2D

onready var disableTimer = $DisableTimer
onready var collisionShape = $CollisionShape2D

signal hurt(damage)


func _on_Hurtbox_area_entered(area):
	if area.is_in_group("attack"):
		collisionShape.set_deferred("disabled", true)
		disableTimer.start()
		emit_signal("hurt", area.damage)

func _on_DisableTimer_timeout():
	collisionShape.set_deferred("disabled", false)


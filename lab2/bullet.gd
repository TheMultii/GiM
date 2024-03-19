extends RigidBody3D

@export var lifetime_timer: Timer

func _ready() -> void:
	lifetime_timer.one_shot = true
	lifetime_timer.wait_time = 2.0
	add_child(lifetime_timer)
	lifetime_timer.start()

func _on_timer_timeout() -> void:
	queue_free()

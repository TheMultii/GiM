extends Node3D

var cube := preload("res://Scenes/pickup_cube.tscn")
var ball := preload("res://Scenes/pickup_ball.tscn")

@export var pickups: Node3D
@export var groundSize: float = 30 / 2.0

func _ready() -> void:
	var rng := RandomNumberGenerator.new()
	
	for x in range(1, 7):
		var rnd1 := rng.randf_range(-groundSize, groundSize)
		var rnd2 := rng.randf_range(-groundSize, groundSize)
		
		var clone := cube.instantiate()
		clone.position = Vector3(rnd1, 0.63, rnd2)
		pickups.add_child(clone)
	
	for x in range(1, 4):
		var rnd1 := rng.randf_range(-groundSize, groundSize)
		var rnd2 := rng.randf_range(-groundSize, groundSize)
		
		var clone := ball.instantiate()
		clone.position = Vector3(rnd1, 0.63, rnd2)
		pickups.add_child(clone)

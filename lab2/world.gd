extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var size_y = 10
	var spacing = 1.1
	
	var cube_scene = preload("res://cube_layer.tscn")
	var b = cube_scene.instantiate()
	var cubes = []
	
	for y in range(size_y):
		var layer: Array[RigidBody3D] = []
		var num_cubes = size_y - y
		var offset = Vector3(- (num_cubes - 1) * spacing / 2, y * spacing, 0)
		for x in range(-num_cubes + 1, num_cubes): # Adjust x range for full pyramid
			for z in range(-num_cubes + 1, num_cubes): # Adjust z range for full pyramid
				var cube = b.duplicate()
				var mesh = cube.find_child("MeshInstance3D").mesh
				mesh.material = StandardMaterial3D.new()
				mesh.material.albedo_color = Color(randf(), randf(), randf())
				
				cube.position = Vector3(x * spacing, 0, z * spacing) + offset
				add_child(cube)
				layer.append(cube)
				
		cubes.append(layer)
				
	# Join the cubes with joints
	for y in range(size_y - 1):
		var current_layer = cubes[y]
		var next_layer = cubes[y + 1]

		for cube in current_layer:
			var cube_position = cube.position

			# Search for the corresponding cube in the next layer based on position
			for below_cube in next_layer:
				var below_cube_position = below_cube.position

				# Check if the position difference is within a small threshold
				if cube_position.distance_to(below_cube_position) < 1:
					var joint = Generic6DOFJoint3D.new()
					joint.set_node_a(cube.get_path())
					joint.set_node_b(below_cube.get_path())
					
					# Increase the range of motion for each degree of freedom
					joint.angular_limit_y_high = deg_to_rad(45) # 45 degrees
					joint.angular_limit_y_low = deg_to_rad(-45) # -45 degrees
					joint.angular_limit_x_high = deg_to_rad(45) # 45 degrees
					joint.angular_limit_x_low = deg_to_rad(-45) # -45 degrees
					joint.angular_limit_z_high = deg_to_rad(45) # 45 degrees
					joint.angular_limit_z_low = deg_to_rad(-45) # -45 degrees
					add_child(joint)
					break  # Stop searching for this cube in the next layer

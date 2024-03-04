extends RigidBody3D

var movement_force = 40
var cameraOffset = Vector3(0, 5.166, 6.519)
var points = 0

func _ready():
	$Area3D.connect("body_entered", _on_body_entered)
	UpdatePointLabel()

func _physics_process(delta):
	$Camera3D.position = lerp($Camera3D.position, position + cameraOffset, 0.1)
	
	if Input.is_action_pressed("Forward"):
		angular_velocity.x -= movement_force * delta
	elif Input.is_action_pressed("Back"):
		angular_velocity.x += movement_force * delta
	if Input.is_action_pressed("Left"):
		angular_velocity.z += movement_force * delta
	elif Input.is_action_pressed("Right"):
		angular_velocity.z -= movement_force * delta

func _on_body_entered(_body) -> void:
	if _body.is_in_group("PickupCube"):
		points += 1
	elif _body.is_in_group("PickupBall"):
		points += 2
	
	UpdatePointLabel()
	CheckWinCondition()
	_body.queue_free()

func UpdatePointLabel():
	$Camera3D/PointDisplay.text = "Punkty: {0}".format({0: points})

func CheckWinCondition():
	if points >= 10:
		$Camera3D/WinText.text = "Wygrana!"

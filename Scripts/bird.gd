extends RigidBody2D

var dead = false
var paused = true

func _ready() -> void:
	$AnimatedSprite2D.play()

func _process(delta: float) -> void:
	if not dead and not paused:
		if Input.is_action_just_pressed("jump"):
			linear_velocity = Vector2.UP * 500
		if linear_velocity.y > 0:
			$AnimatedSprite2D.animation = "yellow_fall"
			rotation = deg_to_rad(10.0)
		else:
			$AnimatedSprite2D.animation = "yellow_jump"
	elif dead:
		gravity_scale = 1.5
		rotation = deg_to_rad(35.0)
	elif paused:
		position = Vector2(440, 770)

func game_over():
	linear_velocity = Vector2.UP * 250
	dead = true
	print("hi")

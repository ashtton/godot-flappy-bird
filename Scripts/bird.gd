extends RigidBody2D

signal hit_something

var dead = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not dead:
		if Input.is_action_just_pressed("jump"):
			linear_velocity = Vector2.UP * 500
		if linear_velocity.y > 0:
			$AnimatedSprite2D.animation = "yellow_fall"
			rotation = deg_to_rad(10.0)
		else:
			$AnimatedSprite2D.animation = "yellow_jump"
	else:
		gravity_scale = 1.5
		rotation = deg_to_rad(35.0)

func game_over():
	linear_velocity = Vector2.UP * 250
	dead = true
	print("hi")

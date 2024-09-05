extends Node2D

@export var pipe_scene: PackedScene

var pipes = []
var score = 0

var started = false
var over = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		if over:
			restart()
		elif not started:
			start_game()
		

func _on_ceiling_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	end_game()

func _on_ground_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	end_game()

func spawn_pipe():
	var pipe = pipe_scene.instantiate()
	pipe.position = Vector2(409, 11)
	
	add_child(pipe)
	pipe.hit_pipe.connect(end_game)
	pipe.pipe_cleared.connect(pipe_cleared)
	pipes.append(pipe)

func end_game():
	if not over:
		print("Game over")
		$Bird.game_over()
		$PipeTimer.stop()
		$UI/GameOver.show()

		for i in pipes:
			i.stop = true
			
		over = true

func setup_game():
	started = false
	$Bird.position = Vector2(170, 600)
	$Bird.freeze = true
	$Bird.show()
	$UI/GameOver.hide()
	$UI/Score.show()
	$UI/Score.text = "0"
	
func start_game():
	spawn_pipe()
	score = 0
	started = true
	$Bird.freeze = false
	$PipeTimer.start()

func restart():
	over = false
	for i in pipes:
		remove_child(i)
	setup_game()
	$Bird.dead = false

func pipe_cleared():
	score += 1
	$UI/Score.text = str(score)

func _on_pipe_timer_timeout() -> void:
	spawn_pipe()
	

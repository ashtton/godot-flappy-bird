extends Node2D

@export var pipe_scene: PackedScene
@export var bird_scene: PackedScene

var bird = null

var pipes = []
var score = 0

var started = false
var over = false

func _ready() -> void:
	setup_game()

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
	if bird:
		remove_child(bird)
	
	started = false
	$UI/GameOver.hide()
	$UI/Score.show()
	$UI/MainScreen.show()
	$UI/Score.hide()
	$UI/Score.text = "0"
	bird = bird_scene.instantiate()
	add_child(bird)
	bird.freeze = true
	bird.paused = true
	bird.position = Vector2(440, 770)
	
func start_game():
	spawn_pipe()
	score = 0
	started = true
	$Bird.freeze = false
	$PipeTimer.start()
	$UI/MainScreen.hide()
	$UI/Score.show()
	$Bird.paused = false

func restart():
	over = false
	for i in pipes:
		remove_child(i)
	$Bird.dead = false
	$Bird.paused = true
	setup_game()

func pipe_cleared():
	score += 1
	$UI/Score.text = str(score)

func _on_pipe_timer_timeout() -> void:
	spawn_pipe()
	

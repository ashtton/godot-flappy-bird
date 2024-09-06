extends Node2D

signal hit_pipe
signal pipe_cleared

var stop = false

func _ready() -> void:
	add_randomization()

func _process(delta: float) -> void:
	if not stop:
		position.x -= 3;

func add_randomization() -> void:
	var random: int = randi_range(-450, 350)
	position.y += random

func _on_bottom_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	hit_pipe.emit()

func _on_top_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	hit_pipe.emit()

func _on_cleared_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	pipe_cleared.emit()

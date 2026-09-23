class_name BaseField
extends Node2D

@export var spawn_positon : Vector2 = Vector2.ZERO
@export var bonus_points  : int = 40
@export var timer_enabled : bool = false
@export var field_timer   : Node
@export var spawn_timer   : Node
@export var missile_scene : PackedScene

func _ready():
	if timer_enabled:
		print("start timer")
		field_timer.start()
		print("start timer")
	spawn_timer.start()

func _process(delta: float) -> void:
	if timer_enabled:
		Globals.field_time_left = field_timer.time_left
	


func _on_SpawnTimer_timeout() -> void:
	var missile = missile_scene.instantiate()
	var x_edge = 1 if randi() % 2 else -1
	var y_edge = -1 if randi() % 2 else 1
	var edge_pos : Vector2 = DisplayServer.screen_get_size()
	edge_pos.x *= x_edge
	edge_pos.y *= y_edge
	missile.global_position = get_viewport().get_camera_2d().global_position + edge_pos
	missile.axis = (Globals.player_position - missile.global_position).normalized()
	add_child(missile)
	print("Booyakasha! gp = ", missile.global_position, ", edge = ", edge_pos)
	spawn_timer.start()

extends Node2D

signal enemy_spawned(enemy_instance)
signal path_enemy_spawned(path_enemy_instance)

const ENEMY = preload("res://scenes/enemy.tscn")
const PATH_ENEMY = preload("res://scenes/path_enemy.tscn")
@onready var enemy_container = $EnemyContainer
@onready var spawn_positions = $SpawnPositions


func _on_timer_timeout():
	spawn_enemy()

func spawn_enemy():
	var spawn_position_array = spawn_positions.get_children()
	var random_spawn_position = spawn_position_array.pick_random()
	var enemy_instance = ENEMY.instantiate()
	enemy_instance.global_position = random_spawn_position.global_position
	enemy_container.add_child(enemy_instance)
	emit_signal("enemy_spawned", enemy_instance)

func spawn_path_enemy():
	var path_enemy_instance = PATH_ENEMY.instantiate()
	emit_signal("path_enemy_spawned", path_enemy_instance)
	
func _on_path_enemy_timer_timeout():
	spawn_path_enemy()

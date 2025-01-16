extends Node2D

var lives := 3
var score := 0
@onready var ui = $UI

var game_over_scene = preload("res://scenes/game_over_screen.tscn")
@onready var player = $player
@onready var hud = $UI/HUD
@onready var death_zone = $DeathZone
@onready var enemy_hit_sound = $EnemyHitSound
@onready var player_hit_sound = $PlayerHitSound

func _ready():
	hud.set_score_label(score)
	hud.set_lives(lives)

func _on_death_zone_area_entered(area):
	area.queue_free()


func _on_player_took_damage():
	lives -= 1
	hud.set_lives(lives)
	if lives == 0:
		player.die()
		var gas = game_over_scene.instantiate()
		gas.set_score(score)
		ui.add_child(gas)
		player_hit_sound.play()

func _on_enemy_spawner_enemy_spawned(enemy_instance):
	enemy_instance.connect("died", _on_enemy_died)
	add_child(enemy_instance)

func _on_enemy_died():
	score += 100
	hud.set_score_label(score)
	enemy_hit_sound.play()


func _on_enemy_spawner_path_enemy_spawned(path_enemy_instance):
	add_child(path_enemy_instance)
	path_enemy_instance.enemy.connect("died", _on_enemy_died)

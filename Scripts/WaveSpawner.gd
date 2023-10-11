extends Node2D
class_name WaveSpawner

var enemy_prefabs = {}
var current_wave_enemies = {}
var current_wave_enemies_count = 1
var current_wave : int = 0

func _ready():
	enemy_prefabs["Enemy01"] = preload("res://Scenes/enemy.tscn")

func _input(event):
	if Input.is_action_just_pressed("Debug"):
		self.spawn_wave()

func spawn_wave():
	self.current_wave += 1
	for i in current_wave_enemies_count:
		var new_enemy_prefab = enemy_prefabs["Enemy01"].instantiate() as Enemy
		self.add_child(new_enemy_prefab)
		new_enemy_prefab.destination_position = -151
		new_enemy_prefab.spawn_position = -500

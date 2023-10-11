extends Node2D
class_name WaveSpawner

var enemy_prefabs = {}
var current_wave_enemies = {}
var current_wave_enemies_count = 18
var current_wave : int = 0

func _ready():
	enemy_prefabs["Enemy01"] = preload("res://Scenes/enemy.tscn")

func _input(event):
	if Input.is_action_just_pressed("Debug"):
		self.spawn_wave()

func spawn_wave():
	self.current_wave += 1
	var spawn_x = -512
	var spawn_y = -151
	var current_count = 1
	for i in current_wave_enemies_count:
		var new_enemy_prefab = enemy_prefabs["Enemy01"].instantiate() as Enemy
		new_enemy_prefab.destination_position = Vector2(spawn_x,spawn_y)
		new_enemy_prefab.spawn_position = Vector2(spawn_x,-500)
		self.add_child(new_enemy_prefab)
		spawn_x += 128
		current_count += 1
		if current_count == (self.current_wave_enemies_count/2) + 1:
			spawn_y -= 128
			spawn_x = -512


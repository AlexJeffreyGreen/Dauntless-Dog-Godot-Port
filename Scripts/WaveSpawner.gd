extends Node2D
class_name WaveSpawner

var enemy_prefabs = {}
var current_wave_enemies = []
var current_wave_enemies_count = 18
var current_wave : int = 0
signal clear_enemy_from_wave

@export var enemey_attribute_collection = []

func _ready():
	enemy_prefabs["Enemy01"] = preload("res://Scenes/enemy.tscn")

func _input(event):
	if Input.is_action_just_pressed("Debug"):
		self.spawn_wave()

func _process(delta):
	pass

func spawn_wave():
	self.current_wave += 1
	var spawn_x = -512
	var spawn_y = -151
	var current_count = 1
	for i in current_wave_enemies_count:
		var new_enemy_prefab
		#if self.current_wave == 1:
		new_enemy_prefab = enemy_prefabs["Enemy01"].instantiate() as Enemy
		new_enemy_prefab.enemy_attributes = self.get_enemy_attribute()
		#else:
		#	new_enemy_prefab = enemy_prefabs["Enemy02"].instantiate() as Enemy02
		new_enemy_prefab.destination_position = Vector2(spawn_x,spawn_y)
		new_enemy_prefab.spawn_position = Vector2(spawn_x,-500)
		self.add_child(new_enemy_prefab)
		#self.current_wave_enemies[i] = new_enemy_prefab
		self.current_wave_enemies.append(new_enemy_prefab)
		new_enemy_prefab.death_signal.connect(self.update_current_wave.bind(new_enemy_prefab))
		#self.clear_enemy_from_wave.connect(new_enemy_prefab.death)
		spawn_x += 128
		current_count += 1
		if current_count == (self.current_wave_enemies_count/2) + 1:
			spawn_y -= 128
			spawn_x = -512

func get_enemy_attribute():
	#TODO - TEMP
	return self.enemey_attribute_collection[self.current_wave - 1] as Enemy_Attributes

func update_current_wave(enemy : Enemy):
	self.current_wave_enemies.erase(enemy)
	print("current wave count - " + str(self.current_wave_enemies.size()))
	if self.current_wave_enemies.size() <= 0:
		self.spawn_wave()

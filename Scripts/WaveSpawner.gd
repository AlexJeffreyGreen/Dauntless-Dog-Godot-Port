extends Node2D
class_name WaveSpawner

var enemy_prefabs = {}
@export var waves = []
@export var starting_y: int = -151
@export var starting_x: int = -512
var current_wave : WaveAttribute
var current_wave_enemies = []
var current_wave_enemies_count = 18
var current_wave_number : int = 0
signal clear_enemy_from_wave

func _ready():
	enemy_prefabs["Enemy01"] = preload("res://Scenes/enemy.tscn")

func _input(event):
	if Input.is_action_just_pressed("Debug"):
		self.spawn_wave()

func _process(delta):
	pass

func spawn_wave():
	#TODO fix this to call some auto load process
	self.new_wave_message()
	
	self.current_wave_number += 1
	if self.current_wave_number > self.waves.size():
		return #TODO - add win
	self.current_wave = self.waves[self.current_wave_number-1]
	var spawn_x = self.starting_x #-512
	var spawn_y = self.starting_y #-151
	var current_count = 1
	for i in self.current_wave.entities.size():
		var new_enemy_prefab
		new_enemy_prefab = enemy_prefabs["Enemy01"].instantiate() as Enemy
		new_enemy_prefab.enemy_attributes = self.current_wave.entities[i]
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


func update_current_wave(enemy : Enemy):
	self.current_wave_enemies.erase(enemy)
	print("current wave count - " + str(self.current_wave_enemies.size()))
	if self.current_wave_enemies.size() <= 0:
		self.spawn_wave()

func new_wave_message():
	var window = self.get_parent().get_node("UI") as DialogueWindow
	var dialogue_entry = DialogueEntry.new()
	dialogue_entry.Dialogue_Actor = DialogueEntry.DIALOGUE_ACTOR.Dover
	dialogue_entry.Dialogue_Portrait = null #TODO
	dialogue_entry.Dialogue_Text = "new wave approaching. prepare your engines. this is not a drill."
	window.add_dialogue(dialogue_entry)
	dialogue_entry = DialogueEntry.new()
	dialogue_entry.Dialogue_Actor = DialogueEntry.DIALOGUE_ACTOR.Dover
	dialogue_entry.Dialogue_Portrait = null #TODO
	dialogue_entry.Dialogue_Text = "protect the galaxy."
	window.add_dialogue(dialogue_entry)

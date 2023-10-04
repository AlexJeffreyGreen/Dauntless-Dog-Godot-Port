extends Area2D
class_name Enemy

@export var health : int = 3
@export var enemy_type : Contants.enemy_type = Contants.enemy_type.EYE
@onready var enemy_animated_sprite = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_entered(area):
	print(area.name + " hit area")
	

func _on_body_entered(body):
	print(body.name + " hit body")

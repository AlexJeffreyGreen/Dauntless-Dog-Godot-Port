extends Resource
class_name Enemy_Attributes

@export var name : String
@export var health : int = 5
@export var attack : int = 1
@export var attack_timer : int = 5
@export var stun_timer : int = 3
@export var sprite_frames : SpriteFrames

enum ENEMY_TYPE {EYE, TIKI} #TODO add more

@export var enemy_type : ENEMY_TYPE


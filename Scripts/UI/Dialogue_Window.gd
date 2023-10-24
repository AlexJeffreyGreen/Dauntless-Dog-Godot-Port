extends CanvasLayer
class_name DialogeWindow

@onready var dialogue_portrait = $DialoguePortrait
@onready var dialogue_text = $DialogueText
#@export var dialogue_actor  #TODO - Pass character so we know who's dialog it is

var dialogues = []


func _ready():
	pass
	
func add_dialogue(entry : DialogueEntry):
	self.dialogues.append(entry)

func remove_dialogue(entry : DialogueEntry):
	self.dialogues.erase(entry)

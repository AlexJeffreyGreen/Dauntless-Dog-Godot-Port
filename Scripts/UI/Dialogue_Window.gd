extends CanvasLayer
class_name DialogeWindow

@onready var dialogue_portrait : AnimatedSprite2D = $Dialogue_Portrait
@onready var dialogue_button : AnimatedSprite2D = $Dialogue_Button
@onready var dialogue_text : Label = $Dialogue_Text

var dialogue_cursor_text : String
var current_dialogue : DialogueEntry
var debug_str : String = "abcdefghijklmnopqrstuvwxyz ";
var dialogues = []
var skip_through : bool = false # not really needed

func _ready():
#	if self.dialogue_text == null:
#		self.dialogue_text = self.get_node("Dialogue_Text")
	self.clear_dialogue_text()
	
func add_dialogue(entry : DialogueEntry):
	self.dialogues.push_back(entry)

func remove_dialogue(entry : DialogueEntry):
	var current_dialog = self.dialogues.pop_front()
	
func _process(delta):
	if Input.is_action_just_pressed("Confirm"):
		self.debug_add_dialogue()
		if self.current_dialogue == null:
			self.current_dialogue = self.dialogues.pop_front()
	if Input.is_action_just_pressed("Debug"):
		#self.debug_add_dialogue()
		self.clear_dialogue_text()
		self.current_dialogue = self.dialogues.pop_front()
		#self.current_dialogue = self.dialogues.pop_front()
#	if Input.is_action_just_pressed("Confirm"):
#		if self.current_dialogue != null:
#			self.skip_through = true
	self.display_dialogue()

func display_dialogue():
	if self.current_dialogue != null && (len(self.dialogue_cursor_text) < len(self.current_dialogue.Dialogue_Text) - 1):
		if !self.dialogue_portrait.is_playing():
			var dialogue_animation_str = DialogueEntry.DIALOGUE_ACTOR.keys()[self.current_dialogue.Dialogue_Actor]
			self.dialogue_portrait.play(dialogue_animation_str)
			self.dialogue_button.play("Idle")
#		if self.skip_through == false:	
		var currentLengthOfDialogue = len(self.dialogue_cursor_text)
		if currentLengthOfDialogue == 0:
			currentLengthOfDialogue = -1
		var nextStringValue = self.current_dialogue.Dialogue_Text[currentLengthOfDialogue + 1]
		self.dialogue_cursor_text += nextStringValue
#		else:
#			self.skip_through = false
#			self.dialogue_cursor_text = ""
#			self.dialogue_cursor_text = self.current_dialogue.Dialogue_Text
		
		self.dialogue_text.text = self.dialogue_cursor_text
		print(self.dialogue_text.text)
		
	if self.current_dialogue == null:
		self.dialogue_portrait.stop() # Stop Animation
		self.dialogue_portrait.frame = 0 #Reset the Animation
		self.dialogue_portrait.visible = false
		self.dialogue_button.visible = false
	else:
		self.dialogue_portrait.visible = true
		self.dialogue_button.visible = true

func random_string(length : int):
	var word: String
	var n_char = len(self.debug_str)
	for i in range(length):
		word += self.debug_str[randi() % n_char]
	return word
func debug_add_dialogue():
	var new_message = random_string(randi_range(1, self.debug_str.length()))
	var dialogue_entry = DialogueEntry.new()
	dialogue_entry.Dialogue_Actor = DialogueEntry.DIALOGUE_ACTOR.Dover
	dialogue_entry.Dialogue_Portrait = null #TODO
	dialogue_entry.Dialogue_Text = new_message
	self.add_dialogue(dialogue_entry)

func clear_dialogue_text():
	self.dialogue_text.text = ""
	self.dialogue_cursor_text = ""

#func _on_typewriter_timer_timeout():
#	if self.current_dialogue != null && len(self.dialogue_cursor_text) < len(self.current_dialogue.Dialogue_Text) - 1:
#		var currentLengthOfDialogue = len(self.dialogue_cursor_text)
#		var nextStringValue = self.current_dialogue.Dialogue_Text[currentLengthOfDialogue + 1]
#		self.dialogue_cursor_text += nextStringValue
#		self.dialogue_text.text = self.dialogue_cursor_text

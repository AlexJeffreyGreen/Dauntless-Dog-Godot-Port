extends State
class_name EnemyDiveState

signal dive_complete

enum DIVE_MODE {DOWN, SIDE, HOMING}
var current_dive_mode

func _ready() -> void:
	self.set_physics_process(false)
	

func _enter_state() -> void:
	var connected = self.actor.get_node("VisibleOnScreenNotifier2D").is_connected("screen_exited", self.on_screen_exited)
	if not connected:
		self.actor.get_node("VisibleOnScreenNotifier2D").connect("screen_exited", self.on_screen_exited)
	self.set_physics_process(true)
	match (self.actor.enemy_type):
		Enemy_Attributes.ENEMY_TYPE.EYE:
			self.current_dive_mode = DIVE_MODE.DOWN
			
	self.animator.play("Attack")

func _physics_process(delta):
	match (self.current_dive_mode):
		DIVE_MODE.DOWN:
			self.actor.global_position.y += 1 * self.actor.max_speed
#	if not self.vision_cast.is_colliding():
#		self.dive_complete.emit()
#	var hit_box_component = self.vision_cast.get_collider() as HitboxComponent
#	if hit_box_component != null:
#		#TODO: determine fix for collision layer and masking
#		if hit_box_component.get_parent().is_in_group("player"):
#			self.actor.shoot_at(hit_box_component)

func _exit_state() -> void:
	#self.actor.get_node("VisibleOnScreenNotifier2D").disconnect("screen_exited", self.on_screen_exited())
	self.set_physics_process(false)

func on_screen_exited():
	print("Emitting completion of dive")
	self.dive_complete.emit()

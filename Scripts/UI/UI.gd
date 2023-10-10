extends Control
class_name UI

@onready var dover_health_slider : VSlider = $HealthUI/DoverHealth


func _process(delta):
	if Global.player != null:
		self.dover_health_slider.value = Global.player.get_health()
	else:
		self.dover_health_slider.hide()

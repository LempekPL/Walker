extends TextureProgress

onready var levelbar = self.get_parent()
onready var tween = levelbar.get_node("UpdateTween")

func _on_health_updated(level, amount):

	tween.interpolate_property(levelbar, "value", levelbar.value, level, 0.4, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	

func _on_max_level_updated(maxLevel):
	levelbar.max_value = maxLevel

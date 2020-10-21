extends Control

onready var krokibar = $krokibar
onready var tween = $UpdateTween

func _on_kroki_updated(kroki, amount):
	
	tween.interpolate_property(krokibar, "value", krokibar.value, kroki, 0.4, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	

func _on_max_updated(max_value):
	krokibar.max_value = max_value

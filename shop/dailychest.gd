extends Button

var hour
var minutes
var seconds

var leftHour
var leftMinutes
var leftSeconds

onready var timer = get_node("Timer")

func _ready():
	timer.set_wait_time(1)
	timer.start()
	
	pass

func _process(delta):
	self.disabled = true
	var time = OS.get_time()
	hour = time.hour
	minutes = time.minute
	seconds = time.second
	self.text = "Odbierz za: " + str(leftHour) + "h" + str(leftMinutes) + "min." + str(leftSeconds) + "sek."
	if(leftHour == 0 && leftMinutes == 0 && leftSeconds == 0):
		self.disabled = false
	pass

func TimerTimeOut():
	leftHour = 24-int(hour)
	leftMinutes = 60-int(minutes)
	leftSeconds = 60-int(seconds)
	pass

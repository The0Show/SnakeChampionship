extends Control

export var minutes = 0
export var seconds = 0
var miliseconds = 0.00
export var stopwatch : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	#Engine.time_scale = 0.1
	
	$CountdownText.hide()
	$StatusText.hide()
	updateTimer()
	
	startGame(1, 0, null, null)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

var minsText
var secsText
var milisecondsText

func updateTimer():
	$TimerText/SegmentText.set_text($TimerText.get_text())
	
	if stopwatch:
		if seconds < 10:
			$TimerText.text = str(minutes) + ":0" + str(seconds)
		else:
			$TimerText.text = str(minutes) + ":" + str(seconds)
		pass
	else:
		if seconds < 10 and not minutes == 0:
			secsText = "0" + str(seconds)
		else:
			secsText = str(seconds)
			
		if minutes == 0:
			minsText = ""
			milisecondsText = "." + str(stepify(miliseconds, 0.1)).replace("0.", "").replace("1.", "")
		else:
			minsText = str(minutes) + ":"
			milisecondsText = ""
			
		
	$TimerText.set_text(minsText + secsText + milisecondsText)
			
func startGame(_minutes, _seconds, music, startingSpeed):
	minutes = _minutes
	seconds = _seconds
	updateTimer()
	
	var t = Timer.new()
	$AnimationPlayer.play("StartGame")

	t.set_wait_time(5)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")

	t.queue_free()
	
	if minutes > 0:
		minutes -= 1
		seconds = 59
	else:
		seconds -= 1
	
	$TimerText/Interval.start(1)
	$AudioStreamPlayer.play(240)

func _on_Interval_timeout():
	if stopwatch:
		seconds += 1
		updateTimer()
		
		if seconds == 60:
			minutes += 1
			seconds = 0
			
		$TimerText/Interval.start(1)
	else:
		seconds -= 1
		
		if seconds < 0 and minutes == 0:
			seconds = 0
			updateTimer()
			$CountdownText.hide()
				
			$StatusText/StatusTextAnimation.seek(0)
			$StatusText.text = "finish!"
			$StatusText/StatusTextAnimation.play("StatusIn")
			$StatusText.show()
			
			$StatusText/AudioStreamPlayer.stop()
			$StatusText/AudioStreamPlayer.play()
			
			$AnimationPlayer.play("GameEnd")
			return
		elif seconds < 0 and not minutes == 0:
			$TimerText/SegmentText/AnimationPlayer.play("New Anim")
			$TimerText/SegmentText.show()
			$TimerText/SegmentText/AudioStreamPlayer.play(0)
			
			minutes -= 1
			seconds = 59
			
		if minutes == 0 and seconds <= 9 and seconds >= 0:
			$CountdownText.hide()
			$CountdownText/CountdownTextAnimation.seek(0)
			$CountdownText.text = str(seconds + 1)
			$CountdownText/CountdownTextAnimation.play("CountdownIn")
			$CountdownText.show()
			
			$CountdownText/AudioStreamPlayer.stop()
			$CountdownText/AudioStreamPlayer.play()
			
		updateTimer()
		$TimerText/Interval.start(1)
	pass # Replace with function body.


func _process(delta):
	miliseconds = $TimerText/Interval.get_time_left()
	updateTimer()

extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var t = Timer.new()
	t.set_wait_time(1)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")

	t.queue_free()
	
	if OS.get_name() == "HTML5":
		$Panel/TextureRect.show()
	else:
		$Panel/VideoPlayer.show()
		
	$Panel/VideoPlayer.play()

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_VideoPlayer_finished():
	SceneChanger.load_scene("Presentation/Title", self)
	pass # Replace with function body.

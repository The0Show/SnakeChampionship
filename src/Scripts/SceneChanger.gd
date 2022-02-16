extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func load_scene(path, current_scene):
	var loader = ResourceLoader.load_interactive("res://Scenes/" + path + ".tscn")
	
	if loader == null:
		print("Scene load failed")
		OS.alert("Scene \"" + path + "\" could not be loaded. It could already be loading.", "Snake Championship")
		return
	
	var loadingoverlay = load("res://Scenes/Overlays/LoadingOverlay.tscn").instance()
	
	get_tree().get_root().call_deferred("add_child", loadingoverlay)
	
	var loadinglabel = loadingoverlay.get_node("Panel/Label")
	var animator = loadingoverlay.get_node("Panel/AnimationPlayer")
	
	animator.stop()
	animator.set_current_animation("RESET")
	animator.seek(0)
	animator.play()
	animator.stop()
	animator.set_current_animation("LoadingOverlayFadeIn")
	animator.seek(0)
	animator.play()
	
	print("Beginning load on " + path + " - " + str(loader.get_stage_count()) + " stages total")
	
	while true:
		var err = loader.poll()
		if err == ERR_FILE_EOF:
			print("Scene " + path + " loaded")
			
			var resource = loader.get_resource()
			get_tree().get_root().call_deferred('add_child', resource.instance())
			current_scene.queue_free()
			loadingoverlay.queue_free()
			break
		elif err == OK:
			var progress = float(loader.get_stage())/loader.get_stage_count()
			loadinglabel.set_text(str(stepify(progress * 100, 1)) + "% (" + str(loader.get_stage()) + "/" + str(loader.get_stage_count()) + " stages)")
			print("Loading scene " + path + " - " + str(stepify(progress * 100, 1)) + "% complete (" + str(loader.get_stage()) + "/" + str(loader.get_stage_count()) + " stages)")
		else:
			print("Scene load failed")
			OS.alert("Scene \"" + path + "\" could not be loaded. It could already be loading.", "Snake Championship")
			break
		yield(get_tree(), "idle_frame")

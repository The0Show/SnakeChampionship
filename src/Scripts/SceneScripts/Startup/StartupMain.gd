extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Panel/VBoxContainer/AnimationPlayer.set_current_animation("StartupFadeIn")
	$Panel/VBoxContainer/AnimationPlayer.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	$Panel/VBoxContainer/Button/UISelect.play()
	SceneChanger.load_scene("UI/InGame", self)
	
	pass # Replace with function body.

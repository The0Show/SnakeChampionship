extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Logo.hide()
	$Button.hide()
	$ColorRect.hide()
	$TitleScreen.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var progress = $TitleScreen.get_playback_position()
	
	if progress > 1.60:
		$Logo.show()
		
	if progress > 4:
		$Button.show()
	pass


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "TitleFadeOut":
		SceneChanger.load_scene("UI/InGame", self)
	
	pass # Replace with function body.


func _on_Button_pressed():
	$TitleScreen.stop()
	$Button/UISelect.play()
	$ColorRect.show()
	$ColorRect/AnimationPlayer.set_current_animation("TitleFadeOut")
	$ColorRect/AnimationPlayer.play()
	pass # Replace with function body.

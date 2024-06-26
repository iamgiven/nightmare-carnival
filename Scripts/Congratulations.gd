extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$BackgroundSound.play()
	$PlayAgainButton.connect("pressed", Callable(self, "_on_PlayAgainButton_pressed"))
	$MenuButton.connect("pressed", Callable(self, "_on_MenuButton_pressed"))

func _on_PlayAgainButton_pressed():
	get_tree().change_scene_to_file("res://Scenes/LevelSelection.tscn")

func _on_MenuButton_pressed():
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")

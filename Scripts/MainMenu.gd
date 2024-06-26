extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$start_menu_bgm.play()
	$Play.connect("pressed", Callable(self, "_on_Play_pressed"))
	$AboutButton.connect("pressed", Callable(self, "_on_AboutButton_pressed"))
	$ExitButton.connect("pressed", Callable(self, "_on_ExitButton_pressed"))

func _on_Play_pressed():
	get_tree().change_scene_to_file("res://Scenes/LevelSelection.tscn")

func _on_AboutButton_pressed():
	get_tree().change_scene_to_file("res://Scenes/About.tscn")

func _on_ExitButton_pressed():
	get_tree().quit()  # Keluar dari game saat tombol "Exit" ditekan

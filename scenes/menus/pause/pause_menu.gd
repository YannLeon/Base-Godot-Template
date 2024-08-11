extends Control
var options_scene = preload("res://scenes/menus/options/options_menu.tscn")
signal resume_pressed

@onready var margin_container = %MarginContainer

func _ready():
	get_tree().paused = true

func _on_quit_button_pressed():
	get_tree().quit()


func _on_resume_button_pressed():
	get_tree().paused = false
	resume_pressed.emit()


func _on_main_menu_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file(Constants.MAIN_MENU_SCENE)


func _on_options_button_pressed():
	var options_instance = options_scene.instantiate()
	margin_container.visible = false
	add_child(options_instance)
	options_instance.back_pressed.connect(on_options_closed.bind(options_instance))


func on_options_closed(options_instance:Node) :
	options_instance.queue_free()
	margin_container.visible = true

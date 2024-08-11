extends Control

var options_scene = preload("res://scenes/menus/options/options_menu.tscn")

@onready var margin_container = $MarginContainer

func _on_play_pressed():
		get_tree().change_scene_to_file(Constants.MAIN_SCENE)


func _on_options_pressed():
	var options_instance = options_scene.instantiate()
	margin_container.visible = false
	add_child(options_instance)
	options_instance.back_pressed.connect(on_options_closed.bind(options_instance))


func _on_quit_pressed():
	get_tree().quit()


func on_options_closed(options_instance:Node) :
	options_instance.queue_free()
	margin_container.visible = true

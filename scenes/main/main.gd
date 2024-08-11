extends Node

var pause_menu_scene = preload("res://scenes/menus/pause/pause_menu.tscn")
@onready var menus = %Menus

func _process(_delta):
	if Input.is_action_just_pressed("pause") :
		var pause_menu_instance = pause_menu_scene.instantiate()
		menus.add_child(pause_menu_instance)
		pause_menu_instance.resume_pressed.connect(on_menu_closed.bind(pause_menu_instance))
		
func on_menu_closed(menu_instance:Node) :
	menu_instance.queue_free()
	get_tree().paused = false

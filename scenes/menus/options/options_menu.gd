extends Control

@onready var main_h_slider = %MainHSlider
@onready var music_h_slider = %MusicHSlider
@onready var sfx_h_slider = %SfxHSlider
@onready var full_screen_toggle = %FullScreenToggle

const MAIN_BUS = 'Master'
const MUSIC_BUS = 'Music'
const SFX_BUS = 'SFX'

signal back_pressed


func _ready():
	var mode = DisplayServer.window_get_mode()
	if mode == DisplayServer.WINDOW_MODE_FULLSCREEN :
		full_screen_toggle.button_pressed=true
	main_h_slider.value = _get_bus_volume_percent(MAIN_BUS)
	sfx_h_slider.value = _get_bus_volume_percent(SFX_BUS)
	music_h_slider.value = _get_bus_volume_percent(MUSIC_BUS)


func _get_bus_volume_percent(bus_name:String) :
	var bus_index=AudioServer.get_bus_index(bus_name)
	var volume_db = AudioServer.get_bus_volume_db(bus_index)
	return db_to_linear(volume_db)


func _set_bus_volume_percent(bus_name:String, volume:float) :
	var bus_index=AudioServer.get_bus_index(bus_name)
	var volume_db=linear_to_db(volume)
	AudioServer.set_bus_volume_db(bus_index,volume_db)


func _on_sfx_h_slider_value_changed(value):
	_set_bus_volume_percent(SFX_BUS,value)


func _on_main_h_slider_value_changed(value):
	_set_bus_volume_percent(MAIN_BUS,value)


func _on_musci_h_slider_value_changed(value):
	_set_bus_volume_percent(MUSIC_BUS,value)


func _on_full_screen_toggle_toggled(toggled_on):
	if(toggled_on) :
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else :
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_back_button_pressed():
	back_pressed.emit()

extends Node3D


@onready var ui_pause := $UI/Pause
@onready var ui_options := $UI/Options

func _ready() -> void:
	Events.toggle_pause_game.connect(toggle_pause_game)
	Events.show_options.connect(_show_options)
	ui_pause.visible = false
	ui_options.visible = false


func toggle_pause_game() -> void:
	if not ui_pause.visible and get_tree().paused: return
	get_tree().paused = not get_tree().paused
	ui_pause.visible = not ui_pause.visible


func _show_options() -> void:
	Events.ui_go_back.connect(_reset, CONNECT_ONE_SHOT)
	ui_pause.visible = false
	ui_options.visible = true


func _reset() -> void:
	ui_pause.visible = true
	ui_options.visible = false

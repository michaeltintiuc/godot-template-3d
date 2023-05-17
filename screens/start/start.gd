extends Node3D


@export_file("*.tscn", "*.scn") var next_scene: String;
@onready var ui_start := $UI/Start
@onready var ui_options := $UI/Options
@onready var ui_loading := $UI/Loading


func _init() -> void:
	Events.start_game.connect(_start_game)
	Events.show_options.connect(_show_options)
	SceneSwitcher.failed.connect(_load_error)
	SceneSwitcher.invalid.connect(_load_error)
	SceneSwitcher.error.connect(_load_error)
	SceneSwitcher.progress.connect(_update_progress)


func _ready() -> void:
	SceneSwitcher.loaded.connect(_switch_scene)
	_reset()


func _switch_scene(scene: PackedScene) -> void:
	var status := get_tree().change_scene_to_packed(scene)
	if OK == status: return
	_load_error(status)


func _start_game() -> void:
	SceneSwitcher.load_scene(next_scene)
	ui_start.visible = false
	ui_options.visible = false
	ui_loading.visible = true


func _show_options() -> void:
	Events.ui_go_back.connect(_reset, CONNECT_ONE_SHOT)
	ui_start.visible = false
	ui_options.visible = true
	ui_loading.visible = false


func _load_error(_sceneOrError) -> void:
	_reset()


func _reset():
	ui_start.visible = true
	ui_options.visible = false
	ui_loading.visible = false


func _update_progress(value: float) -> void:
	ui_loading.update_progress(value)

extends Node


var _done := true
var _scene: String
var _load_status: int = ResourceLoader.THREAD_LOAD_INVALID_RESOURCE
var _load_progress: Array = []


signal start(scene: String)
signal loaded(scene: PackedScene)
signal failed(scene: String)
signal invalid(scene: String)
signal progress(value: float)
signal error(value: Error)


func _init() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS


func _process(_delta) -> void:
	if _done: return
	_process_scene_load()


func _process_scene_load() -> void:
	_load_status = ResourceLoader.load_threaded_get_status(_scene, _load_progress)
	
	progress.emit(_load_progress[0])
	
	if _load_status == ResourceLoader.THREAD_LOAD_INVALID_RESOURCE:
		_done = true
		invalid.emit(_scene)
	elif _load_status == ResourceLoader.THREAD_LOAD_FAILED:
		_done = true
		failed.emit(_scene)
	elif _load_status == ResourceLoader.THREAD_LOAD_LOADED:
		_done = true
		loaded.emit(ResourceLoader.load_threaded_get(_scene))


func load_scene(scene: String) -> void:
	_done = false
	_scene = scene
	var status := ResourceLoader.load_threaded_request(_scene)
	if OK != status: error.emit(status)
	else: start.emit(_scene)

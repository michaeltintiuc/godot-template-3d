class_name AudioSlider extends HSlider


@export var type := Types.AudioSlider.MASTER


func _ready():
	min_value = -80.0
	max_value = 6.0
	value = AudioServer.get_bus_volume_db(type)
	value_changed.connect(_set_bus_volume)


func _set_bus_volume(db: float) -> void:
	AudioServer.set_bus_volume_db(type, db)

extends Control


@onready var progress_bar: ProgressBar = $GridContainer/ProgressBar


func update_progress(value: float) -> void:
	progress_bar.value = value * 100

extends Label

enum TimeType {
	START_OF_MONTH,
	MIDDLE_OF_MONTH,
	END_OF_MONTH,
}

var time_type: TimeType = TimeType.START_OF_MONTH
var elapsed_time: float = 0.0
var _last_time_type: TimeType = TimeType.START_OF_MONTH
var _is_started: bool = false

func _ready() -> void:
	_update_time_type()

func start_countdown() -> void:
	_is_started = true

signal on_new_month()

func _process(delta: float) -> void:
	if not _is_started:
		return
	elapsed_time += delta
	var cycle_time = int(elapsed_time) % 60
	if cycle_time < 20:
		time_type = TimeType.START_OF_MONTH
	elif cycle_time < 40:
		time_type = TimeType.MIDDLE_OF_MONTH
	else:
		time_type = TimeType.END_OF_MONTH

	if time_type != _last_time_type:
		if time_type == TimeType.START_OF_MONTH:
			on_new_month.emit()
		_last_time_type = time_type
	_update_time_type()

func _update_time_type() -> void:
	match time_type:
		TimeType.START_OF_MONTH:
			text = "start of month"
		TimeType.MIDDLE_OF_MONTH:
			text = "middle of month"
		TimeType.END_OF_MONTH:
			text = "end of month"

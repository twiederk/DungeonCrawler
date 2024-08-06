class_name Logger

enum Level { DEBUG, INFO, WARN, ERROR}

var _level = Level.INFO


func debug(message: String):
	if is_level(Level.DEBUG):
		print(message)


func info(message: String):
	if is_level(Level.INFO):
		print(message)


func warn(message: String):
	if is_level(Level.WARN):
		print(message)


func error(message: String):
	if is_level(Level.ERROR):
		print(message)


func is_level(level: Level) -> bool:
	return level >= _level
	

func set_level(level: Level):
	_level = level


func get_level() -> Level:
	return _level

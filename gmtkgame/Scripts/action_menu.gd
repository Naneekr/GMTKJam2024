extends BoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func connect_buttons(_client_func: Callable, _smith_func: Callable, _map_func: Callable) -> void:
	$MarginContainer/AspectRatioContainer/ClientButton.pressed.connect(_client_func)
	$MarginContainer2/AspectRatioContainer2/SmithButton.pressed.connect(_smith_func)
	$MarginContainer3/AspectRatioContainer3/MapButton.pressed.connect(_map_func)

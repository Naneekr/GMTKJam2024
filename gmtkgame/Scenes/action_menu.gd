extends BoxContainer

signal client_signal
signal smith_signal
signal map_signal

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MarginContainer/AspectRatioContainer/ClientButton.pressed.connect(client_signal.emit)
	$MarginContainer2/AspectRatioContainer2/SmithButton.pressed.connect(smith_signal.emit)
	$MarginContainer3/AspectRatioContainer3/MapButton.pressed.connect(map_signal.emit)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

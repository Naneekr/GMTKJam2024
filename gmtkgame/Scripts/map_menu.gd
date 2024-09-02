extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func connect_buttons(callbacks: Array) -> void:
	for i in len(callbacks):
		get_node("GridContainer/Button%s" % (i+1)).pressed.connect(callbacks[i])

extends Control

var num_of_clients: int = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$BoxContainer/MarginContainer/AspectRatioContainer/ClientButton.pressed.connect(self._take_client)
	$BoxContainer/MarginContainer2/AspectRatioContainer2/SmithButton.pressed.connect(self._smith_item)
	$BoxContainer/MarginContainer3/AspectRatioContainer3/MapButton.pressed.connect(self._go_to_map)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _take_client() -> void:
	var rng = RandomNumberGenerator.new()
	
	var client_choice: int = rng.randi_range(1, num_of_clients)
	
	Dialogic.start(["Client1", "Client2"][client_choice-1])
	
func _smith_item() -> void:
	print("Smithing arms!")
	
func _go_to_map() -> void:
	print("Away we go!")

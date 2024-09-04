extends MarginContainer

class_name JobUnit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func create(cx_picture: Resource, cx_name: String, strength: String, dexterity: String, intelligence: String, callback: Callable) -> void:
	find_child("TextureRect").texture = cx_picture
	find_child("NameLabel").text = cx_name
	find_child("StrengthLabel").text = strength
	find_child("DexterityLabel").text = dexterity
	find_child("IntelligenceLabel").text = intelligence
	find_child("Button").pressed.connect(func(): callback.call(self))

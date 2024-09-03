extends MarginContainer

class_name MerchandiseUnit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func create(merch_name: String, strength: String, dexterity: String, intelligence: String) -> void:
	find_child("NameLabel").text = merch_name
	find_child("StrengthLabel").text = strength
	find_child("DexterityLabel").text = dexterity
	find_child("IntelligenceLabel").text = intelligence

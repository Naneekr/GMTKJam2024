extends PopupPanel

var container: VBoxContainer
var job_unit : Resource = preload("res://Scenes/JobUnit.tscn")

enum CxInfo
{
	NAME,
	PICTURE,
	STATS
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	container = $ScrollContainer/VBoxContainer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func add_job_unit(job_data: Dictionary, callback: Callable) -> JobUnit:
	var new_unit: JobUnit = job_unit.instantiate()
	new_unit.create(
		job_data[CxInfo.PICTURE],
		job_data[CxInfo.NAME], 
		str(job_data[CxInfo.STATS][0]), 
		str(job_data[CxInfo.STATS][1]), 
		str(job_data[CxInfo.STATS][2]),
		callback
	)
	container.add_child(new_unit)
	return new_unit

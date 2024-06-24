extends Sprite2D

@export var bin_type : String = "regular"
var bin_types = {
	"glass": "res://trash-game/assets/bins/glass_bin.png",
	"regular": "res://trash-game/assets/bins/common_bin.png",
	"recyclable": "res://trash-game/assets/bins/recycle_bin.png",
}
var bin_order = ["regular", "recyclable","glass"]

func _ready():
	var touch_detection = get_node("TouchDetection")
	if touch_detection:
		touch_detection.connect("input_event", Callable(self, "_on_TouchDetection_input_event"))
	else:
		print("TouchDetection node not found")
	update_bin_image()

func _on_TouchDetection_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		change_bin_type()

func change_bin_type():
	print("touched")
	var current_index = bin_order.find(bin_type)
	var next_index = (current_index + 1) % bin_order.size()
	bin_type = bin_order[next_index]
	print("new type: ", bin_type)
	update_bin_image()

func update_bin_image():
	self.texture = load(bin_types[bin_type])

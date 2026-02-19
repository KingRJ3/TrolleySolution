class_name Mixture extends RigidBody2D

@onready var polygon_2d: Polygon2D = $Polygon2D
@onready var paint_drop_spot: Marker2D = $"../PaintDropSpot"

const TEX_BLUE = preload("res://Frameworks(YourStuff)/Jude/MixColors/blue.png")
const TEX_RED = preload("res://Frameworks(YourStuff)/Jude/MixColors/red.png")
const TEX_YELLOW = preload("res://Frameworks(YourStuff)/Jude/MixColors/yellow.png")

@onready var sprite_2d: Sprite2D = $Sprite2D

@export var colorstart : Color

func _ready() -> void:
	polygon_2d.color = colorstart
	apply_closest_texture(colorstart)
	
func apply_closest_texture(input_color: Color):
	# 1. Snap the messy input color to a "Rigid" constant
	var rigid_color = get_closest_rigid_color(input_color)
	
	# 2. Match the rigid color to the correct texture
	match rigid_color:
		Color.RED:
			sprite_2d.texture = TEX_RED
		Color.YELLOW:
			sprite_2d.texture = TEX_YELLOW
		Color.BLUE:
			sprite_2d.texture = TEX_BLUE
		_:
			push_warning("Color did not match Red, Yellow, or Blue")

# --- The Helper Function (Same as before) ---
func get_closest_rigid_color(c: Color) -> Color:
	var options = [Color.RED, Color.YELLOW, Color.BLUE]
	var best_match = options[0]
	var shortest_dist = 999.0
	
	for option in options:
		var dist = Vector3(c.r, c.g, c.b).distance_squared_to(Vector3(option.r, option.g, option.b))
		if dist < shortest_dist:
			shortest_dist = dist
			best_match = option
			
	return best_match
func interact_once():
	
	freeze = true
	await get_tree().create_timer(.1).timeout
	var tween = get_tree().create_tween()
	var rot_tween = get_tree().create_tween()
	rot_tween.tween_property(self, "rotation", rotation - PI, .5).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(self, "global_position", paint_drop_spot.global_position, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	await tween.finished
	freeze = false

func get_mix():
	return polygon_2d.color

var color_time = .1
func hover():
	modulate = Color.YELLOW
	color_time = .1
	

func _process(delta: float) -> void:
	color_time -= delta
	if color_time < 0:
		modulate = Color.WHITE

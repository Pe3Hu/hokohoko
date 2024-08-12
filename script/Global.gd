extends Node


var rng = RandomNumberGenerator.new()
var arr = {}
var num = {}
var vec = {}
var color = {}
var dict = {}
var flag = {}
var node = {}
var scene = {}


func _ready() -> void:
	init_arr()
	init_num()
	init_vec()
	init_color()
	init_dict()
	
func init_arr() -> void:
	arr.role = ["vendor", "customer"]
	arr.product = ["rock"]
	arr.temperament = ["calm", "greedy"]
	
func init_num() -> void:
	num.index = {}
	num.index.vendor = 0
	num.index.customer = 0
	
	dict.step = {}
	dict.step.role = {}
	dict.step.role["vendor"] = "surcharge"
	dict.step.role["customer"] = "discount"
	
	
func init_dict() -> void:
	init_direction()
	init_corner()
	
func init_direction() -> void:
	dict.direction = {}
	dict.direction.linear3 = [
		Vector3( 0, 0, -1),
		Vector3( 1, 0,  0),
		Vector3( 0, 0,  1),
		Vector3(-1, 0,  0)
	]
	dict.direction.linear2 = [
		Vector2i( 0,-1),
		Vector2i( 1, 0),
		Vector2i( 0, 1),
		Vector2i(-1, 0)
	]
	dict.direction.diagonal = [
		Vector2i( 1,-1),
		Vector2i( 1, 1),
		Vector2i(-1, 1),
		Vector2i(-1,-1)
	]
	dict.direction.zero = [
		Vector2i( 0, 0),
		Vector2i( 1, 0),
		Vector2i( 1, 1),
		Vector2i( 0, 1)
	]
	dict.direction.hex = [
		[
			Vector2i( 1,-1), 
			Vector2i( 1, 0), 
			Vector2i( 0, 1), 
			Vector2i(-1, 0), 
			Vector2i(-1,-1),
			Vector2i( 0,-1)
		],
		[
			Vector2i( 1, 0),
			Vector2i( 1, 1),
			Vector2i( 0, 1),
			Vector2i(-1, 1),
			Vector2i(-1, 0),
			Vector2i( 0,-1)
		]
	]
	
func init_corner() -> void:
	dict.order = {}
	dict.order.pair = {}
	dict.order.pair["even"] = "odd"
	dict.order.pair["odd"] = "even"
	var corners = [3]
	dict.corner = {}
	dict.corner.vector = {}
	
	for corners_ in corners:
		dict.corner.vector[corners_] = {}
		dict.corner.vector[corners_].even = {}
		
		for order_ in dict.order.pair.keys():
			dict.corner.vector[corners_][order_] = {}
		
			for _i in corners_:
				var angle = 2*PI*_i/corners_-PI/2
				
				if order_ == "odd":
					angle += PI/corners_
				
				var vertex = Vector2(1,0).rotated(angle)
				dict.corner.vector[corners_][order_][_i] = vertex
	
func init_blank() -> void:
	dict.blank = {}
	dict.blank.rank = {}
	var exceptions = ["rank"]
	
	var path = "res://asset/json/maoiri_blank.json"
	var array = load_data(path)
	
	for blank in array:
		blank.rank = int(blank.rank)
		var data = {}
		
		for key in blank:
			if !exceptions.has(key):
				data[key] = blank[key]
			
		if !dict.blank.rank.has(blank.rank):
			dict.blank.rank[blank.rank] = []
	
		dict.blank.rank[blank.rank].append(data)
	
func init_vec():
	vec.size = {}
	vec.size.sixteen = Vector2(16, 16)
	vec.size.price = Vector2(24, 100)
	
	init_window_size()
	
func init_window_size():
	vec.size.window = {}
	vec.size.window.width = ProjectSettings.get_setting("display/window/size/viewport_width")
	vec.size.window.height = ProjectSettings.get_setting("display/window/size/viewport_height")
	vec.size.window.center = Vector2(vec.size.window.width/2, vec.size.window.height/2)
	
func init_color():
	var h = 360.0
	
	color.limit = {}
	color.limit.vendor = Color.from_hsv(270.0 / h, 0.8, 0.8, 0.9)
	color.limit.customer = Color.from_hsv(30.0 / h, 0.8, 0.8, 0.9)
	
	color.profit = {}
	color.profit.vendor = Color.from_hsv(270.0 / h, 0.6, 0.8, 0.9)
	color.profit.customer = Color.from_hsv(30.0 / h, 0.6, 0.8, 0.9)
	
	color.streak = {}
	color.streak.vendor = Color.from_hsv(270.0 / h, 1.0, 0.55)
	color.streak.customer = Color.from_hsv(30.0 / h, 1.0, 0.55)
	
func save(path_: String, data_: String):
	var path = path_ + ".json"
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_string(data_)
	
func load_data(path_: String):
	var file = FileAccess.open(path_, FileAccess.READ)
	var text = file.get_as_text()
	var json_object = JSON.new()
	var _parse_err = json_object.parse(text)
	return json_object.get_data()
	
func get_random_key(dict_: Dictionary):
	if dict_.keys().size() == 0:
		print("!bug! empty array in get_random_key func")
		return null
	
	var total = 0
	
	for key in dict_.keys():
		total += dict_[key]
	
	rng.randomize()
	var index_r = rng.randf_range(0, 1)
	var index = 0
	
	for key in dict_.keys():
		var weight = float(dict_[key])
		index += weight/total
		
		if index > index_r:
			return key
	
	print("!bug! index_r error in get_random_key func")
	return null

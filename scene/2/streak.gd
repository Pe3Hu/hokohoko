class_name Streak extends Line2D


@export var price: Price:
	set(price_):
		price = price_
	get:
		return price
var value = null:
	set(value_):
		value = value_
		
		var section = price.sections.get_child(1)
		
		match price.resource.orientation:
			"vertical":
				position.y =  section.position.y#price.size.y - length
				#position.y = (1 - float(value - 1) / price.mediator.limit) * price.size.y
			#"horizontal":
				#position.x = float(value) / price.mediator.limit * price.size.x
	get:
		return value


func init_vertexs() -> void:
	var vertex = Vector2()
	add_point(vertex)
	
	vertex = Vector2(Global.vec.size.price)
	
	match price.resource.orientation:
		"vertical":
			vertex.y = 0
		"horizontal":
			vertex.x = 0
	
	add_point(vertex)
	default_color = Global.color.streak[price.mediator.resource.role]


class_name Section extends Polygon2D


@export var price: Price
@export var resource: SectionResource:
	set(resource_):
		resource = resource_
	get:
		return resource


func init_vertexs() -> void:
	var lengths = Vector2(Global.vec.size.price)
	
	match price.resource.orientation:
		"vertical":
			lengths.y = float(lengths.y) / price.mediator.limit * resource.extent
			position.y = (1 - float(resource.values.back()) / price.mediator.limit) * price.size.y
		#"horizontal":
			#lengths.x = lengths.x / price.mediator.limit * resource.extent
			#position.x = float(resource.values.front() - 1) / price.mediator.limit * price.size.x
	
	var vertexs = []
	
	for direction in Global.dict.direction.zero:
		var vertex = Vector2(direction) * lengths
		vertexs.append(vertex)
		resource.center += vertex
	
	resource.center /= vertexs.size()
	set_polygon(vertexs)

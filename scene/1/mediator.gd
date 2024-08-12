class_name Mediator extends PanelContainer


@export var price: Price


var room: Room:
	set = set_room
var resource: MediatorResource:
	set = set_resource
var limit: int = 100:
	set(limit_):
		limit = limit_
		price.init_sections()
	get:
		return limit

func set_room(room_: Room) -> Mediator:
	room = room_
	var mediators = room.get(resource.role + "s")
	mediators.add_child(self)
	return self
	
func set_resource(resource_: MediatorResource) -> Mediator:
	resource = resource_
	return self
	
func _ready() -> void:
	limit = 100
	
func leave_room() -> void:
	var mediators = room.get(resource.role + "s")
	mediators.remove_child(self)
	queue_free()
	
	var mediator_resources = room.resource.get(resource.role + "s")
	mediator_resources.erase(resource)
	#resource.free()
	
	

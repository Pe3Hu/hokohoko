class_name Room extends PanelContainer


@export var resource: RoomResource:
	set(resource_):
		resource = resource_
		init_mediators()
	get:
		return resource
@export var customers: HBoxContainer
@export var vendors: HBoxContainer

@onready var mediator_scene = preload("res://scene/1/mediator.tscn")


func init_mediators() -> void:
	resource.reset_mediators()
	
	for role in Global.arr.role:
		var mediator_resources = resource.get(role + "s")
		
		for mediator_resource in mediator_resources:
			var mediator = mediator_scene.instantiate()
			mediator.set_resource(mediator_resource).set_room(self)
	
func update_prices() -> void:
	resource.sort_mediators()
	#print("___")
	
	for role in Global.arr.role:
		var mediators = get(role + "s")
		#var temp = []
		
		#while mediators.get_child_count() > 0:
			#var mediator = mediators.get_child(0)
			#mediators.remove_child(mediator)
			#temp.append(mediator)
		#
		#temp.sort_custom(func(a, b): return resource.get(role + "s").find(a.resource) < resource.get(role + "s").find(b.resource))
		#
		#for mediator in temp:
			#mediators.add_child(mediator)
		for mediator in mediators.get_children():
			mediator.price.update_profit()

class_name Price extends PanelContainer


@export var mediator: Mediator
@export var sections: Node2D
@export var limit_section: Section
@export var profit_section: Section
@export var streak: Line2D

@onready var section_scene = preload("res://scene/2/section.tscn")

var resource: PriceResource


func _ready() -> void:
	resource = PriceResource.new()
	
	custom_minimum_size = Global.vec.size.price
	size = custom_minimum_size
	
	init_sections()
	streak.init_vertexs()
	update_profit()
	
func init_sections() -> void:
	var types = ["limit", "profit"]
	var limit_price = mediator.resource.limit_price
	var current_price = mediator.resource.current_price
	
	for type in types:
		var section = get(type + "_section")
		section.resource = SectionResource.new()
		var values = []
		
		match type:
			"limit":
				values = [0, limit_price]
			"profit":
				values = [limit_price, current_price]
		
		section.resource.set_price(resource).set_type(type).set_values(values)
		resource.sections.append(section.resource)
		section.init_vertexs()
		section.color = Global.color[type][mediator.resource.role]
	
func update_profit() -> void:
	if mediator.resource.role == "vendor" and mediator.resource.vault.products[mediator.resource.product.title] == 0:
		mediator.leave_room()
	else:
		var limit_price = mediator.resource.limit_price
		var current_price = mediator.resource.current_price
		var values = [limit_price, current_price]
		var section = sections.get_child(1)
		section.resource.set_values(values)
		
		#print([mediator.resource.role, section.resource])
		section.init_vertexs()
		streak.value = mediator.resource.current_price

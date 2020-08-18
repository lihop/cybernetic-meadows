extends Node2D
# Given a recipe a producer will convert the inputs into the recipes product.


export(Resource) var recipe = null
export(Array, NodePath) var inputs := []
export(Array, NodePath) var outputs := []
# How many units of product this node will hold before it is considered full.
# Once a Producer is full it will no longer producer units until it has
# empty output slots.
export(int) var stack_size := 50


func _ready():
	outputs.resize(stack_size)


func _process(delta):
	pass

extends Node2D

const LAND = 0
const WATER = 15690

const WIDTH = 32 * 4
const HEIGHT = 32 * 4

const CHUNK_SIZE = 32
var generated_chunks = {}


const SCORCHED = 15653
const BARE = 15650
const TUNDRA = 15667
const SNOW = 15673
const TEMPERATE_DESERT = 15634
const SHRUBLAND = TUNDRA
const TAIGA = 15634
const GRASSLAND = 15660
const TEMPERATE_DECIDUOUS_FOREST = 15660
const TEMPERATE_RAIN_FOREST = 15664
const SUBTROPICAL_DESERT = 15670
const TROPICAL_SEASONAL_FOREST = 15675
const TROPICAL_RAIN_FOREST = 15664

var map_seed = hash("Values of beta may give rise to dom!")


var temperature = OpenSimplexNoise.new()
var moisture = OpenSimplexNoise.new()


export(NodePath) var player_node: NodePath
onready var player: Node2D = get_node(player_node)


func _ready():
	generate_chunk(Vector2(0, 0))
	generate_chunk(Vector2(0, 0))


func _process(delta: float) -> void:
	generate_chunk(Map.world_to_map(player.position))


func generate_chunk(coords: Vector2):
	if Map.get_cellv(coords) != TileMap.INVALID_CELL:
		return
	
	generate_back(coords * Vector2(CHUNK_SIZE, CHUNK_SIZE))
	generate_path(coords * Vector2(CHUNK_SIZE, CHUNK_SIZE))
	Map.set_cellv(coords, 0)


func generate_back(coords: Vector2):
	temperature.seed = map_seed
	temperature.octaves = 4
	temperature.period = 150
	temperature.persistence = 0.8
	
	moisture.seed = map_seed + 1
	moisture.octaves = 4
	moisture.period = 150
	moisture.persistence = 0.8
	
	for x in range(CHUNK_SIZE):
		for y in range(CHUNK_SIZE):
			var biome
			var temp = range_lerp(temperature.get_noise_2d(coords.x + x, coords.y + y), -1, 1, 0, 6)
			var moist = range_lerp(moisture.get_noise_2d(coords.x + x, coords.y + y), -1, 1, 0, 4)
			if temp < 1:
						if moist < 1:
							biome = SCORCHED
						elif moist < 2:
							biome = BARE
						elif moist < 3:
							biome = TUNDRA
						else:
							biome = SNOW
			elif temp < 2:
						if moist < 2:
							biome = TEMPERATE_DESERT
						elif moist < 4:
							biome = SHRUBLAND
						else:
							biome = TAIGA
			elif temp < 3:
				if moist < 1:
							biome = TEMPERATE_DESERT
				elif moist < 3:
							biome = GRASSLAND
				elif moist < 5:
							biome = TEMPERATE_DECIDUOUS_FOREST
				else:
							biome = TEMPERATE_RAIN_FOREST
			else:
				if moist < 1:
							biome = SUBTROPICAL_DESERT
				elif moist < 2:
							biome = GRASSLAND
				elif moist < 4:
							biome = TROPICAL_SEASONAL_FOREST
				else:
							biome = TROPICAL_RAIN_FOREST
			$Back.set_cell(coords.x + x, coords.y + y, biome)


func generate_path(coords: Vector2):
	var threshold = 0.5
	# TODO: Get list of natural resources from somewhere else.
	var natural_resources := [
		preload("res://items/natural_resources/tree/tree.tscn"),
		preload("res://items/natural_resources/rock/rock.tscn"),
		preload("res://items/natural_resources/iron_deposit/iron_deposit.tscn")
	]
	var noise_map = {}
	
	for i in range(natural_resources.size()):
		var noise := OpenSimplexNoise.new()
		noise.seed = map_seed - (i + 1)
		noise.octaves = 4
		noise.period = 50
		noise.persistence = 0.8
		noise_map[natural_resources[i]] = {"noise": noise, "threshold": threshold}
		if natural_resources[i] == preload("res://items/natural_resources/tree/tree.tscn"):
			noise_map[natural_resources[i]].threshold = 0.75
	
	for x in range(CHUNK_SIZE):
		for y in range(CHUNK_SIZE):
			var options = {}
			var values = []
			for resource in natural_resources:
				var t = noise_map[resource].threshold
				var noise: OpenSimplexNoise = noise_map[resource].noise
				var n = noise.get_noise_2d(coords.x + x, coords.y + y)
				if n < -(1 - t) or n > 1 - t:
					values.append(n)
					options[n] = resource
			
			if not values.empty():
				values.sort()
				var instance: NaturalResource = options[values[0]].instance()
				instance.position = $Paths.map_to_world(Vector2(coords.x + x, coords.y + y))
				$Paths/YSort.add_child(instance)

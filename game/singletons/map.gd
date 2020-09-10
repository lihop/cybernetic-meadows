extends TileMap
# Keeps track of farm data. The farm area is unlike the other areas in the game
# in that it is procedurally generated and quite large. It also susceptible to
# environmental changes. All things that need to be tracked, which is where this
# singleton comes in.


const CHUNK_SIZE = 32


func _ready():
	cell_size = Vector2(CHUNK_SIZE * 32, CHUNK_SIZE * 32)

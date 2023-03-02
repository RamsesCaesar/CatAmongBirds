extends Camera2D

# In Cat Among Birds, the camera gets moved around by the Player's child node,
# called RemoteTransform2D. There is no GDScript code for that movement.
# As a resource, compare HeartBeasts tutorial :
# https://youtu.be/MA7jSbXfS34
# (RamsesCaesar 2023-03-02 20:15)


onready var topLeft = $Limits/TopLeft
onready var bottomRight = $Limits/BottomRight

func _ready():
	limit_top = topLeft.position.y
	limit_left = topLeft.position.x
	limit_bottom = bottomRight.position.y
	limit_right = bottomRight.position.x

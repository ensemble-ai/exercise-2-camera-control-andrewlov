class_name FourWaySpeedUp
extends CameraControllerBase


@export var push_ratio: float
@export var pushbox_top_left: Vector2 = Vector2(-10, 10)
@export var pushbox_bottom_right: Vector2 = Vector2(10, -10)
@export var speedup_zone_top_left: Vector2 = Vector2(-5, 5)
@export var speedup_zone_bottom_right: Vector2 = Vector2(5, -5)


func _ready() -> void:
	draw_camera_logic = true
	position = target.position
	super()


func _process(delta: float) -> void: 
	if !current:
		return
	
	if draw_camera_logic:
		draw_logic()
	
	var tpos = target.global_position
	var cpos = global_position
	var speedup: bool = true
	
	push_ratio = target.velocity.length() * 0.5
	
	var diff_between_left_edges = (tpos.x - target.WIDTH / 2.0) - (cpos.x + pushbox_top_left.x)
	if diff_between_left_edges < 0:
		global_position.x += diff_between_left_edges  # keeps it trapped in the box and pushes it in the direction of the target
		speedup = false # don't overlap movementts
	#right
	var diff_between_right_edges = (tpos.x + target.WIDTH / 2.0) - (cpos.x - pushbox_top_left.x)
	if diff_between_right_edges > 0:
		global_position.x += diff_between_right_edges 
		speedup = false
	#top
	var diff_between_top_edges = (tpos.z - target.HEIGHT / 2.0) - (cpos.z - pushbox_top_left.y)
	if diff_between_top_edges < 0:
		global_position.z += diff_between_top_edges 
		speedup = false
	#bottom
	var diff_between_bottom_edges = (tpos.z + target.HEIGHT / 2.0) - (cpos.z + pushbox_top_left.y)
	if diff_between_bottom_edges > 0:
		global_position.z += diff_between_bottom_edges 
		speedup = false
	
	if target.position.x >= global_position.x + speedup_zone_bottom_right.x and speedup != false: #right
		global_position += push_ratio * target.velocity.normalized() * delta
	elif target.position.x < global_position.x + speedup_zone_top_left.x and speedup != false: #left
		global_position += push_ratio * target.velocity.normalized() * delta
	elif target.position.z > global_position.z + speedup_zone_top_left.y and speedup != false: #top
		global_position += push_ratio * target.velocity.normalized() * delta
	elif target.position.z < global_position.z + speedup_zone_bottom_right.y and speedup != false: #bottom
		global_position += push_ratio * target.velocity.normalized() * delta
	
	super(delta)


func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF

	# Outer Pushbox
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(pushbox_top_left.x, 0, pushbox_top_left.y))
	immediate_mesh.surface_add_vertex(Vector3(pushbox_bottom_right.x, 0, pushbox_top_left.y))
	immediate_mesh.surface_add_vertex(Vector3(pushbox_bottom_right.x, 0, pushbox_top_left.y))
	immediate_mesh.surface_add_vertex(Vector3(pushbox_bottom_right.x, 0, pushbox_bottom_right.y))
	immediate_mesh.surface_add_vertex(Vector3(pushbox_bottom_right.x, 0, pushbox_bottom_right.y))
	immediate_mesh.surface_add_vertex(Vector3(pushbox_top_left.x, 0, pushbox_bottom_right.y))
	immediate_mesh.surface_add_vertex(Vector3(pushbox_top_left.x, 0, pushbox_bottom_right.y))
	immediate_mesh.surface_add_vertex(Vector3(pushbox_top_left.x, 0, pushbox_top_left.y))

	# Inner Speedup Zone
	immediate_mesh.surface_add_vertex(Vector3(speedup_zone_top_left.x, 0, speedup_zone_top_left.y))
	immediate_mesh.surface_add_vertex(Vector3(speedup_zone_bottom_right.x, 0, speedup_zone_top_left.y))
	immediate_mesh.surface_add_vertex(Vector3(speedup_zone_bottom_right.x, 0, speedup_zone_top_left.y))
	immediate_mesh.surface_add_vertex(Vector3(speedup_zone_bottom_right.x, 0, speedup_zone_bottom_right.y))
	immediate_mesh.surface_add_vertex(Vector3(speedup_zone_bottom_right.x, 0, speedup_zone_bottom_right.y))
	immediate_mesh.surface_add_vertex(Vector3(speedup_zone_top_left.x, 0, speedup_zone_bottom_right.y))
	immediate_mesh.surface_add_vertex(Vector3(speedup_zone_top_left.x, 0, speedup_zone_bottom_right.y))
	immediate_mesh.surface_add_vertex(Vector3(speedup_zone_top_left.x, 0, speedup_zone_top_left.y))
	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()

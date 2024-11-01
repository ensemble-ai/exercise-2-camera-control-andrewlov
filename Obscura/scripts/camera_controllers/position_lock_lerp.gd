class_name PositionLockLerp
extends CameraControllerBase


@export var follow_speed:float 
@export var catchup_speed:float 
@export var leash_distance:float = 12


func _ready() -> void:
	draw_camera_logic = true
	super()
	position = target.position


func _process(delta: float) -> void: 
	if !current:
		position = target.position
		return
	
	if draw_camera_logic:
		draw_logic()
	
	var direction
	
	var tpos = target.global_position
	var cpos = global_position
	var distance = sqrt(pow(cpos.x - tpos.x, 2) + pow(cpos.z - tpos.z, 2)) 
	
	follow_speed = 0.6 * sqrt(pow(target.velocity.x, 2) + pow(target.velocity.z, 2))
	catchup_speed = 90
	
	if distance > leash_distance:
		if target.velocity != Vector3.ZERO:
			global_position += target.velocity * delta
		else:
			direction = (tpos - cpos).normalized()
			global_position += direction * catchup_speed * delta
	else: 
		if target.velocity == Vector3.ZERO:
			direction = (tpos - cpos).normalized()
			global_position += direction * catchup_speed * delta
		else:
			direction = (tpos - cpos).normalized()
			global_position += direction * follow_speed * delta
	
	super(delta)


func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	var cross_size: float = 5
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(-cross_size/2, 0, 0))
	immediate_mesh.surface_add_vertex(Vector3(cross_size/2, 0, 0))
	
	immediate_mesh.surface_add_vertex(Vector3(0, 0, -cross_size/2))
	immediate_mesh.surface_add_vertex(Vector3(0, 0, cross_size/2))
	
	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()

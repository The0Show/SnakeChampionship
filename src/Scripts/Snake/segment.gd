"""
Segment
=======

A single snake body segment.
"""
extends Sprite


"""
The cell this segment ocupies on the grid.
"""
var cell: Vector2 = TheGrid.TOPLEFT_CELL setget set_cell


"""
Used to check collisions against another body segments.
"""
func is_same_cell(another_cell: Vector2) -> bool:
	return cell == another_cell


"""
`cell` property setter.
"""
func set_cell(value: Vector2) -> void:
	cell = value if not value < TheGrid.TOPLEFT_CELL else TheGrid.TOPLEFT_CELL

	# Make sure the sprite is always updated accordingly.
	position = TheGrid.CELL_LENGTH * cell

/*
Thought this could be useful for at least a couple of you out there with clear spools. Opaque spools will only work if they have a little window of the filament inside all the way from the top layer to the bottom layer. Unfortunately Polymaker just appears to have stopped making clear spools, so meh but hey.
*/

num_max_windings_layer := 30 ; maximal number of windings that can be in any layer
diameter_inner_spool_wall_mm := 100 ; end to end diameter of the hole in the center of the spool, including wall thickness
density_filament_g_cm_cubed := 1.27 ; generally petg is 1.27, pla is 1.25
diameter_filament_mm := 1.75

num_layers_remaining_in_spool := 1 ; integer, do include a nearly depleted layer, and use num_windings_consumed_topmost_layer to deduct missing windings
num_windings_consumed_topmost_layer := 11 ; how many windings in the topmost layer are depleted (ok to estimate, will be rounded up)

; dont modify:

pi := 3.141592653589793

meters_total = 0
grams_total = 0


loop % num_layers_remaining_in_spool
{
	num_layers_from_inner_spool_wall := A_Index ; start from inside moving outward, A_Index 1 being innermost filament layer, 2 being second etc
	
	if (A_Index = num_layers_remaining_in_spool)
		num_windings_in_this_layer := num_max_windings_layer - Ceil(num_windings_consumed_topmost_layer)
	else
		num_windings_in_this_layer := num_max_windings_layer
	
	meters_in_layer := num_windings_in_this_layer * (2 * pi * (diameter_inner_spool_wall_mm + diameter_filament_mm + (num_layers_from_inner_spool_wall * diameter_filament_mm)) / 2) / 1000
	
	grams_in_layer := ((pi * (diameter_filament_mm / 2)**2 * (meters_in_layer * 1000)) / 1000) * density_filament_g_cm_cubed
	
	meters_total += meters_in_layer
	grams_total += grams_in_layer
	
}

msgbox,% "Total meters remaining in spool:`n" meters_total "`n`nTotal grams remaining in spool:`n" grams_total
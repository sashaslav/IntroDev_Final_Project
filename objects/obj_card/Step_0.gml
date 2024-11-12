/// @description Insert description here
// You can write your code in this editor

switch(global.state) {
	case STATES.CHOOSE:
		//if the card is in the player's hand
		if(in_player_hand)
		{
			if(position_meeting(mouse_x, mouse_y, id)) 
			{
				y = lerp(y, (target_y-15), 0.2);
			}
			//if the mouse is over the card and we press the mouse button
			if(position_meeting(mouse_x, mouse_y, id) &&
			mouse_check_button_pressed(mb_left)) 
			{
				//flip the card	
				obj_dealer.player_selected = id;
			}
		}
		break;
	/*
	case STATES.COMP_CHOOSE:
		if(obj_dealer.comp_selected != noone) {
			obj_dealer.comp_selected.target_y = (room_height * 0.3) + 20;
		}
		break;
		*/
	default:
		//show_debug_message("cannot click");
		break;
}






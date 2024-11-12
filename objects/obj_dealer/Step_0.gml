//if we're dealing

//note: ONLY ONE CASE CAN BE TRUE AT A TIME; dont need to be ordered to work


switch(global.state) {
	//player gets dealt cards
	case STATES.DEAL:
		if(move_timer == 0) {
			//find the number of cards currently in the player's hand
			var _player_num = ds_list_size(player_hand);
			//if the player has less than 4 cards
			if(_player_num < 3) {
				//grab the top card of the list
				var _dealt_card = ds_list_find_value(deck, ds_list_size(deck)-1);
				//remove it from the deck and add it to the hand
				ds_list_delete(deck, ds_list_size(deck) - 1);
				ds_list_add(player_hand, _dealt_card);
				//set the card in the hand's position
				_dealt_card.target_x = room_width/3 + _player_num * hand_x_offset;
				_dealt_card.target_y = room_height * 0.8;
				//let the card know it's in the player's hand
				_dealt_card.in_player_hand = true;
				_dealt_card.face_up = true;
				audio_play_sound(snd_card,1,false);
			} else {
				//once we have 4 cards, we're no longer dealin
				//dealing = false;	
				global.state = STATES.COMP_DEAL;
			}
		}
		break;
	//computer gets dealt cards
	case STATES.COMP_DEAL:
		if(move_timer == 0) {
			//find the number of cards currently in the player's hand
			var _comp_num = ds_list_size(comp_hand);
			//if the player has less than 4 cards
			if(_comp_num < 3) {
				//grab the top card of the list
				var _dealt_comp_card = ds_list_find_value(deck, ds_list_size(deck)-1);
				//remove it from the deck and add it to the hand
				ds_list_delete(deck, ds_list_size(deck) - 1);
				ds_list_add(comp_hand, _dealt_comp_card);
				//set the card in the hand's position
				_dealt_comp_card.target_x = room_width/3 + _comp_num * hand_x_offset;
				_dealt_comp_card.target_y = room_height * 0.3;
				//let the card know it's in the player's hand
				_dealt_comp_card.in_comp_hand = true;
				audio_play_sound(snd_card,1,false);
			} else {
				//once we have 4 cards, we're no longer dealin
				//dealing = false;	
				global.state = STATES.CHOOSE;
			}
		}
		break;
	//player chooses a card
	case STATES.CHOOSE:
		if(player_selected != noone) {
			audio_play_sound(snd_card,1,false);
			global.state = STATES.COMP_CHOOSE;
		}
		break;
	//computer chooses a card
	case STATES.COMP_CHOOSE:
		if (move_timer == 0) {
			var _picked = irandom(ds_list_size(comp_hand)-1);
			comp_hand[| _picked].face_up = true;	
			//ds_list_add(comp_selected, comp_hand[| _picked]);
			comp_selected = comp_hand[| _picked];
			if(comp_selected != noone) {
				audio_play_sound(snd_card,1,false);
				global.state = STATES.COMPARE
			}
		}
		break;
	//system compares the cards and assigns who wins the round
	case STATES.COMPARE:
	
		//player = sciss, comp = rock
		if(player_selected.face_index == 1 && comp_selected.face_index == 2) {
			//computer gets a point
			comp_score += 1;
			audio_play_sound(snd_lose,2,false);
		} 
		//both = scissors
		else if(player_selected.face_index == 1 && comp_selected.face_index == 1) {
			//tie, no points
		}
		//player = sciss, comp = paper
		else if(player_selected.face_index == 1 && comp_selected.face_index == 0) {
			//player gets a point
			player_score += 1;
			audio_play_sound(snd_win,2,false);
		}
		//both = paper
		else if(player_selected.face_index == 0 && comp_selected.face_index == 0) {
			//tie
		}
		//player = paper, comp = sciss
		else if(player_selected.face_index == 0 && comp_selected.face_index == 1) {
			//comp point
			comp_score += 1;
			audio_play_sound(snd_lose,2,false);
		}
		//player = paper, comp = rock
		else if(player_selected.face_index == 0 && comp_selected.face_index == 2) {
			//player point
			player_score += 1;
			audio_play_sound(snd_win,2,false);
		}
		//player = rock, comp = paper
		else if(player_selected.face_index == 2 && comp_selected.face_index == 0) {
			//comp point
			comp_score += 1;
			audio_play_sound(snd_lose,2,false);
		}
		//player = rock, comp = sciss
		else if(player_selected.face_index == 2 && comp_selected.face_index == 1) {
			//player point
			player_score += 1;
			audio_play_sound(snd_win,2,false);
		}
		//both = rock
		else if(player_selected.face_index == 2 && comp_selected.face_index == 2) {
			//tie
		}
		
		global.state = STATES.RESOLVE;
		break;
	case STATES.RESOLVE:
		if(move_timer == 0) {
			var _hand_num = ds_list_size(player_hand);
			if(_hand_num > 0) {
				var _hand_card = ds_list_find_value(player_hand, ds_list_size(player_hand) - 1);
				ds_list_delete(player_hand, ds_list_size(player_hand) - 1);
				ds_list_add(discard, _hand_card);
				_hand_card.target_x = room_width * 0.9;
				_hand_card.target_y = y - ds_list_size(discard);
				_hand_card.face_up = false;
				audio_play_sound(snd_card,1,false);
			} else {
				player_selected = noone;
				global.state = STATES.COMP_RESOLVE;
			}
		}
		break;
	case STATES.COMP_RESOLVE:
		if(move_timer == 0) {
			var _comp_hand_num = ds_list_size(comp_hand);
			if(_comp_hand_num > 0) {
				var _comp_hand_card = ds_list_find_value(comp_hand, ds_list_size(comp_hand) - 1);
				ds_list_delete(comp_hand, ds_list_size(comp_hand) - 1);
				ds_list_add(discard, _comp_hand_card);
				_comp_hand_card.target_x = room_width * 0.9;
				_comp_hand_card.target_y = y - ds_list_size(discard);
				_comp_hand_card.face_up = false;
				audio_play_sound(snd_card,1,false);
			} else {
				comp_selected = noone;
				if(ds_list_size(deck) == 0) {
					global.state = STATES.RESHUFFLE;
				} else {
					global.state = STATES.DEAL;
				}
			}
		}
		break;
	case STATES.RESHUFFLE:
		if (move_timer == 0) {
			//finds the number of cards currently in the DECK
			var _discard_num = ds_list_size(discard);
			//if the discard pile has 12 cards 
			if(_discard_num > 0) {
				//grab the top card of the DISCARD list
				var _discard_card = ds_list_find_value(discard, ds_list_size(discard) - 1);
				//remove it from the discard pile and put it back into the deck
				ds_list_delete(discard, ds_list_size(discard) - 1);
				ds_list_add(deck, _discard_card);
				_discard_card.target_x = x; //room_width * 0.9;
				_discard_card.target_y = y - ds_list_size(deck);
				_discard_card.face_up = false;
				audio_play_sound(snd_card,1,false);
			} else {
				global.state = STATES.DEAL;
			}
		}
		break;
	
	
}
	/*
} else if(global.state == STATES.CHOOSE) {

} else if(global.state == STATES.COMPARE) {

}
*/

move_timer++;
if(move_timer == 25) {
	move_timer = 0;
}







//enum = set of constants
enum STATES
{
	DEAL,
	CHOOSE,
	COMPARE,
	RESOLVE,
	RESHUFFLE,
	COMP_DEAL,
	COMP_CHOOSE,
	COMP_COMPARE,
	COMP_RESOLVE
}

//this is how we'll manage our game states
global.state = STATES.DEAL;

//space between cards in the hand
hand_x_offset = 100;

//total number of cards in the deck
num_cards = 24;

//make the lists that'll hold our cards depending on what state they're in
deck = ds_list_create();
player_hand = ds_list_create();
//player_selected = ds_list_create();
discard = ds_list_create();
comp_hand = ds_list_create();
//comp_selected = ds_list_create();

move_timer = 0;

player_score = 0;
comp_score = 0;

player_selected = noone;
comp_selected = noone;

//create the cards
for(var _i = 0; _i < num_cards; _i++) 
{
	//make a new card
	var _new_card = instance_create_layer(x, y, "Cards", obj_card);
	//set its face index
	//modulo (%) allows us to iterate within the loop
	//and set our face card to 0, 1, or 2
	_new_card.face_index = _i % 3;
	//if our card is face up
	_new_card.face_up = false;
	//if our card is in the player's hand
	_new_card.in_player_hand = false;
	_new_card.in_comp_hand = false;
	_new_card.target_x = x;
	_new_card.target_y = y;
	//add the card to the deck
	ds_list_add(deck, _new_card);
}

//shuffle our deck
randomize();
ds_list_shuffle(deck);

//loop through and put the card at the appropriate position
for(var _i = 0; _i < num_cards; _i++) 
{
	deck[| _i].depth = num_cards - _i;
	deck[| _i].target_y = y - (2 * _i);
}







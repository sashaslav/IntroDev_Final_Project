/// @description Insert description here
// You can write your code in this editor

if(abs(x - target_x) > 1)
{
	x = lerp(x, target_x, 0.2);
} else {
	x = target_x;
}
if(abs(y - target_y) > 1) 
{
	y = lerp(y, target_y, 0.2);
} else {
	y = target_y;
}

//set our card face based on our index
if(face_index == 0) sprite_index = spr_red;
if(face_index == 1) sprite_index = spr_blue;
if(face_index == 2) sprite_index = spr_yellow;

//if we're not face up, just use the card back
if(!face_up) sprite_index = spr_card;

//draw the card
draw_sprite(sprite_index, image_index, x, y);







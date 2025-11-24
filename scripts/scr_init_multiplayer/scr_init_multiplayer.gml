


//multiplayer characters
//0 - robot 

//multiplayer animation states
//0 - Still
//1 - Walking
//2 - Jumping
//3 - Jetpack
//4 - Grapple
//5 - Slide
//6 - Air Dodge
//7 - 
//8 - Wall Jump
//9 - Attack
//10 - 
//11 - Take Damage
//12 - Stagger
//13 - Die
//14 - Fall (for sprite initialize scripts)
//15 - Backwards Fall


//multiplayer robot sprite skeleton points

//key - [character code][actionstate][body part][x or y]

global.skeleton1[0][0][0][0] = 14 //still sprite l arm x
global.skeleton1[0][0][0][1] = -28 //still sprite l arm y
global.skeleton1[0][0][1][0] = -24 //still sprite r arm x
global.skeleton1[0][0][1][1] = -16 //still sprite r arm y
global.skeleton1[0][0][2][0] = -4 //still sprite head x	
global.skeleton1[0][0][2][1] = -48 //still sprite head y
global.skeleton1[0][1][0][0] = 14 //walk sprite l arm x
global.skeleton1[0][1][0][1] = -24 //walk sprite l arm y
global.skeleton1[0][1][1][0] = -24 //walk sprite r arm x
global.skeleton1[0][1][1][1] = -16 //walk sprite r arm y
global.skeleton1[0][1][2][0] = -4 //walk sprite head x	
global.skeleton1[0][1][2][1] = -48 //walk sprite head y
global.skeleton1[0][2][0][0] = 18 //jump sprite l arm x 58,16
global.skeleton1[0][2][0][1] = -32 //jump sprite l arm y 
global.skeleton1[0][2][1][0] = -32 //jump sprite r arm x 16,16
global.skeleton1[0][2][1][1] = -28 //jump sprite r arm y
global.skeleton1[0][2][2][0] = -4 //jump sprite head x	36,4
global.skeleton1[0][2][2][1] = -48 //jump sprite head y
global.skeleton1[0][3][0][0] = 18 //jetpack sprite l arm x 58,16
global.skeleton1[0][3][0][1] = -32 //jetpack sprite l arm y 
global.skeleton1[0][3][1][0] = -32 //jetpack sprite r arm x 16,16
global.skeleton1[0][3][1][1] = -28 //jetpack sprite r arm y
global.skeleton1[0][3][2][0] = -4 //jetpack sprite head x	36,4
global.skeleton1[0][3][2][1] = -48 //jetpack sprite head y



global.skeleton1[0][5][0][0] = 42 //slide sprite l arm x 58,16   94,11
global.skeleton1[0][5][0][1] = 66 //slide sprite l arm y 
global.skeleton1[0][5][1][0] = 16 //slide sprite r arm x 16,16   106.52
global.skeleton1[0][5][1][1] = 32 //slide sprite r arm y
global.skeleton1[0][5][2][0] = 47 //slide sprite head x	36,4    111,27
global.skeleton1[0][5][2][1] = 42 //slide sprite head y      64,-20 origin

global.skeleton1[0][8][0][0] = 18 //jetpack sprite l arm x 58,16
global.skeleton1[0][8][0][1] = -32 //jetpack sprite l arm y 
global.skeleton1[0][8][1][0] = 0 //jetpack sprite r arm x 16,16
global.skeleton1[0][8][1][1] = 0 //jetpack sprite r arm y
global.skeleton1[0][8][2][0] = -4 //jetpack sprite head x	36,4
global.skeleton1[0][8][2][1] = -48 //jetpack sprite head y



global.skeleton1[0][14][0][0] = 14 //fall sprite l arm x 50,16
global.skeleton1[0][14][0][1] = -28 //fall sprite l arm y 
global.skeleton1[0][14][1][0] = -28 //fall sprite r arm x 8, 16
global.skeleton1[0][14][1][1] = -28 //fall sprite r arm y 
global.skeleton1[0][14][2][0] = -8 //fall sprite head x	28,0
global.skeleton1[0][14][2][1] = -44 //fall sprite head y
global.skeleton1[0][15][0][0] = 18 //backjump sprite l arm x 58,16
global.skeleton1[0][15][0][1] = -32 //backjump sprite l arm y 
global.skeleton1[0][15][1][0] = -32 //backjump sprite r arm x 16,16
global.skeleton1[0][15][1][1] = -28 //backjump sprite r arm y
global.skeleton1[0][15][2][0] = -4 //backjump sprite head x	36,4
global.skeleton1[0][15][2][1] = -48 //backjump sprite head y

	//36,44
//robot sprites
//global.skeleton1[1][0][0] = 48 //still sprite l arm x
//global.skeleton1[1][0][1] = 48 //still sprite l arm y
//global.skeleton1[1][1][0] = 48 //still sprite l arm y
image_speed = 0;
actionState = 0;
enemyHealth = 100;
lineArray =  [768, 704]; //y coordinates for front and back enemy lines
ySpeed = 0;
xSpeed = 0;
blinkVar = 0;
initialPause = irandom_range(40,60);
triggerPause = 30;
bulletIncrement = 0;
bulletSpeed = 0;
triggerTimer = 0;
depth = -150;

if x < 0 {
	xSide = -1;
} else if (x > 2400) {
	xSide = 1;
}
destinationX = 0;
destinationY = 0;

shootingTimer = 0;

jumpVelocity = 0.5;

//jumping
xPos = 0;
yPos = 0;


faceArray = [ 
	{
	jump: spr_arcadeShooter_crewCutJump,
	kneel: spr_arcadeShooter_crewCutKneel,
	pistol: spr_arcadeShooter_crewCutPistol,
	run: spr_arcadeShooter_crewCutRun,
	shotgun: spr_arcadeShooter_crewCutShotgun,
	sneak: spr_arcadeShooter_crewCutSneak
	}, 
	{
	jump: spr_arcadeShooter_flatTopJump,
	kneel: spr_arcadeShooter_flatTopKneel,
	pistol: spr_arcadeShooter_flatTopPistol,
	run: spr_arcadeShooter_flatTopRun,
	shotgun: spr_arcadeShooter_flatTopShotgun,
	sneak: spr_arcadeShooter_flatTopSneak
	}, 
	{
	jump: spr_arcadeShooter_fullBeardJump,
	kneel: spr_arcadeShooter_fullBeardKneel,
	pistol: spr_arcadeShooter_fullBeardPistol,
	run: spr_arcadeShooter_fullBeardRun,
	shotgun: spr_arcadeShooter_fullBeardShotgun,
	sneak: spr_arcadeShooter_fullBeardSneak
	}, 
	{
	jump: spr_arcadeShooter_malePatternJump,
	kneel: spr_arcadeShooter_malePatternKneel,
	pistol: spr_arcadeShooter_malePatternPistol,
	run: spr_arcadeShooter_malePatternRun,
	shotgun: spr_arcadeShooter_malePatternShotgun,
	sneak: spr_arcadeShooter_malePatternSneak
	}
]

bodyStruct = {
	jump: spr_arcadeShooter_jumpBody,
	kneel: spr_arcadeShooter_kneelBody,
	pistol: spr_arcadeShooter_pistolBody,
	run: spr_arcadeShooter_runBody,
	shotgun: spr_arcadeShooter_shotgunBody,
	sneakPistol: spr_arcadeShooter_sneakPistolBody,
	sneakShotgun: spr_arcadeShooter_sneakShotgunBody
};

enemyFace = faceArray[faceIndex].jump;
image_index = poseIndex;
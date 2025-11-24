if (player.weaponType == 1) {
    visible = true;
};

rifleCharge = player.rifleCharge;
rifleCharge = round(rifleCharge/12) * 12;
barWidth = 304 * rifleCharge/900;
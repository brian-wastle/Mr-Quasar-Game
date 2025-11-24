// Enemy States:
// 0 - Idle
// 1 - Attack
//// Attack States:
//// 0 - Charge
//// 1 - Jump
//// 2 - Tornado
//// 3 - Shoot
// 2 - Damage
// 3 - Death

event_inherited();

if (bossInst == noone && instance_exists(obj_runAndGun1_miniboss2)) {
    bossInst = obj_runAndGun1_miniboss2.id;
}

// Idle State
if (enemyState == 0) {
	// set sprites
	if (sprite_index != spr_runAndGun1_bullIdle && 
	sprite_index != spr_runAndGun1_bullIdle2) {
	    sprite_index = spr_runAndGun1_bullIdle;
		currentIndex = 0;
		stateTimer[0] = 0;
		stateTimer[1] = 0;
	}
	
	// animate
    if (stateTimer[0] < 5) {
	    stateTimer[0] += 1;
	} else if (currentIndex < image_number - 1) {
		stateTimer[0] = 0;
		currentIndex += 1;
	} else {
		stateTimer[0] = 0;
		currentIndex = 0;
		idleLoop += 1;
	}
	
	// switch idle sprites on loop
	var maxLoops = sprite_index == spr_runAndGun1_bullIdle? 3 : 1;
	if (idleLoop >= maxLoops) {
	    idleLoop = 0;
		sprite_index = sprite_index == spr_runAndGun1_bullIdle? 
			spr_runAndGun1_bullIdle2 : spr_runAndGun1_bullIdle;
	}
	
	// Trigger stun state
	if (damageFlag == 1) {
	    enemyState = 2;
		stateTimer[0] = 0;
		stateTimer[1] = 0;
		sprite_index = spr_runAndGun1_bullFall;
		currentIndex = 0;
		idleLoop = 0;
		bossInst.damageFlag = 1;
	}
	
	// Trigger death state
	if (enemyHealth <= 0) {
		enemyState = 3;
		damageState = 0;
		stateTimer[0] = 0;
		stateTimer[1] = 0;
		currentIndex = 0;
		bossInst.damageFlag = 1;
	}
}

// Attack State
if (enemyState == 1) {
    switch (attackState) {
	    case 0: // Dash
	        if (sprite_index != spr_runAndGun1_bullAngry && sprite_index != spr_runAndGun1_bullCharge) {
			    sprite_index = spr_runAndGun1_bullAngry;
				currentIndex = 0;
			} else if (sprite_index == spr_runAndGun1_bullAngry) {			// animate
			    if (stateTimer[0] < 6) {
				    stateTimer[0] += 1;
				} else if (currentIndex < image_number - 1) {
					stateTimer[0] = 0;
					currentIndex += 1;
				} else if (bossInst.currentIndex >= 2) {
					stateTimer[0] = 0;
					sprite_index = spr_runAndGun1_bullCharge;
					currentIndex = 0;
				}
			} else if (sprite_index == spr_runAndGun1_bullCharge) {			// animate
			    if (stateTimer[0] < 5) {
				    stateTimer[0] += 1;
				} else if (currentIndex < 3) {
					stateTimer[0] = 0;
					currentIndex += 1;
				} else if (currentIndex < 7) {
					if (sign(bossInst.xOffset) == sign(bossInst.currentDir) &&
					(abs(bossInst.xOffset) > 100)) {
					    stateTimer[0] = 0;
						currentIndex += 1;
					}
				} 
			}
			
			// Slide
			if (sprite_index == spr_runAndGun1_bullCharge && currentIndex > 3 && currentIndex < 8) {
				// handle accel
				if (xSpeed < maxSpeed) {
				    xSpeed += 1;
				}
				if (sign(x - xCenter) == sign(currentDir) && abs(x - xCenter) > 360) {
					currentIndex = 8;
				} else {
					var slideSpeed = lerp(3,24, xSpeed / maxSpeed);
					x += slideSpeed * currentDir;
				}
			} else if (sprite_index == spr_runAndGun1_bullCharge && currentIndex >= 8) {
				if (abs(x - xCenter) < xBorder) {
					if (xSpeed > 0) {
					    xSpeed -= 1;
					}
					if (xSpeed == maxSpeed/2) {
					    currentIndex = 9;
					}
				    var slideSpeed = lerp(20,2, xSpeed / maxSpeed);
					x += slideSpeed * currentDir;
				} else {
					enemyState = 0;
					currentDir *= -1;
					stateTimer[0] = 0;
					stateTimer[1] = 0;
				}
			}
			
			// handle y axis jitter
			if (vibrationOffset == 0 && enemyState == 1 && xSpeed > 0) {
				vibrationOffset = 2;
			} else if (enemyState == 1 && xSpeed > 0) {
				if (vibeTimer[0] < 3) {
					vibeTimer[0] += 1;
				} else {
					vibeTimer[0] = 0;
					vibrationOffset *= -1;
				}
			} else {
				vibeTimer[0] = 0;
				vibrationOffset = 0;
			}
	        break;
		case 1: // Jump Attack
		    if (sprite_index != spr_runAndGun1_bullJump) {
		        sprite_index = spr_runAndGun1_bullJump;
		        currentIndex = 0;
		        stateTimer[0] = 0;
		    }

		    if (!hopInit) { 
				if (stateTimer[0] < 60) {
				    stateTimer[0] += 1;
				} else {
					stateTimer[0] = 0;
					groundY = y;
					hopInit = true;
				}
				
			} else {
				// On the ground
			    if (!hopAir ) {
			        if (stateTimer[0]++ >= 3)         // 3-step pause between frames
			        {
			            stateTimer[0] = 0;

			            if (currentIndex < 4)         // play 0→5
			            {
			                currentIndex += 1;
			            }
			            else                          // reached frame 5 → take off
			            {
			                currentIndex  = 5;        // first airborne frame
			                hopXSpeed     = currentDir * (hopHSpeed + 2);
			                hopYSpeed     = hopVImpulse;
			                hopAir        = true;
			            }
			        }
			    } else {
					// Airborne
			        jumpXMotion();
			        // animation
			        var startFalling = (hopYSpeed >= -8);	// Zero Y speed is the peak of the jump, 
			        if (startFalling && stateTimer[0]++ >= 3) { // negative integers are prior to peak
			            stateTimer[0] = 0;
			            if (currentIndex != 10) {
			                currentIndex += 1;  
						} else {
							if (stateTimer[1] < 5) {
							    stateTimer[1] += 1;
							} else {
								stateTimer[1] = 0;
								currentIndex += 1;  
							}
						}
			        }
			    }
			}

		    // Landing
		    if (hopAir && hopYSpeed >= 0 && y >= groundY) {
		        y         = groundY;
		        hopYSpeed = 0;
		        hopAir    = false;
		        stateTimer[0] = 0;                     // reset wind-up timer

		        if (lapCount >= 3) {
		            // clean reset
		            hopInit			= false;
		            lapCount		= 0;
		            hopAir			= false;
		            hopHSpeed		= 10;

		            enemyState		= 0;                   // back to idle
		            stateTimer[0]	= 0;
					stateTimer[1]	= 0;
		            break;                             // leave case 1
		        } else {
		            currentIndex = 0;                  // ready for next wind-up
		        }
		    }
			break;
		case 2: // Tornado
		    if (!hopInit) { 
				if (sprite_index != spr_runAndGun1_bullWindup) {
				    sprite_index = spr_runAndGun1_bullWindup;
					currentIndex = 0;
				}
				if (stateTimer[1] < 60) {
				    stateTimer[1] += 1;
				} else {
					if (currentIndex < image_number - 1) {
					    if (stateTimer[0] < 5) {
						    stateTimer[0] += 1;
						} else {
							stateTimer[0] = 0;
							currentIndex += 1;
						}
					} else {
						stateTimer[0] = 0;
						stateTimer[1] = 0;
						groundY = y;
						hopInit = true;
					}
				}
			} else {
				if (sprite_index != spr_runAndGun1_bullTornado && sprite_index != spr_runAndGun1_bullRecover) {
			        sprite_index = spr_runAndGun1_bullTornado;
			        currentIndex = 0;
					stateTimer[0] = 0;
			    }
				// Animation
				if (sprite_index == spr_runAndGun1_bullTornado) {
				    if (++stateTimer[0] >= 6) {
				        stateTimer[0] = 0;
				        currentIndex = (currentIndex + 1) mod image_number; 
				    }
				}
			    
			    // Airborne
			    if (hopAir) { 
					jumpXMotion();
			    }
			}
		    // Landing
		    if (hopAir && hopYSpeed >= 0 && y >= groundY) {
		        y = groundY;
		        hopYSpeed = 0;
		        hopAir = false;
				if (lapCount >= 5) {
					recoverState = 1;
				}  
		    }
			if (recoverState == 1) {
				if (sprite_index != spr_runAndGun1_bullRecover) {
					sprite_index = spr_runAndGun1_bullRecover;
					stateTimer[0] = 0;
					stateTimer[1] = 0;
					currentIndex = 0;
				}
				
				var threshold = 2;
				if (currentIndex == 4) {	
					threshold = 20;
				} else if (currentIndex > 4) {
					threshold = 6;
				}
				if (stateTimer[1] < threshold) {
						stateTimer[1] += 1;
				} else if (currentIndex < image_number - 1) {
					stateTimer[1] = 0;
					currentIndex += 1;
				} else {
					hopInit  = false;
					lapCount = 0;
					hopAir   = false;
					recoverState = 0;

					enemyState    = 0;
					attackState   = 0;
					stateTimer[0] = 0;
					stateTimer[1] = 0;
				}
			break;
			}

		    // Restart jump
		    if (!hopAir && enemyState == 1 && attackState == 2)
		    {
		        hopXSpeed = currentDir * tornadoHSpeed;
		        hopYSpeed = tornadoVImpulse;
		        hopAir    = true;
		    }
	        break;
		case 3: // Shoot
	        if (sprite_index != spr_runAndGun1_bullShoot) {
			    sprite_index = spr_runAndGun1_bullShoot;
				currentIndex = 0;
				stateTimer[0] = 0;
				stateTimer[1] = 0;
			}
			if (stateTimer[0] < 5) {
			    stateTimer[0] += 1;
			} else if (currentIndex == image_number - 3) {
				// Right rear side smoke
				instance_create_layer(x + currentDir * 8, y - 212, "Instances", obj_runAndGun1_bullSmokeRound, {
					smokeDir: 1
				});
				instance_create_layer(x + currentDir * 16, y - 212, "Instances", obj_runAndGun1_bullSmokeRound, {
					smokeDir: -1
				});
				// Right side smoke on shot
				instance_create_layer(x + currentDir * 8, y - 192, "Instances", obj_runAndGun1_bullSmoke, {
					smokeDir: 1
				});
				instance_create_layer(x + currentDir * 16, y - 192, "Instances", obj_runAndGun1_bullSmoke, {
					smokeDir: -1
				});
				
				// Left rear side smoke
				instance_create_layer(x + currentDir * 72, y - 212, "Instances", obj_runAndGun1_bullSmokeRound, {
					smokeDir: 1
				});
				instance_create_layer(x + currentDir * 80, y - 212, "Instances", obj_runAndGun1_bullSmokeRound, {
					smokeDir: -1
				});
				// Left side smoke
				instance_create_layer(x + currentDir * 72, y - 192, "Instances", obj_runAndGun1_bullSmoke, {
					smokeDir: 1
				});
				instance_create_layer(x + currentDir * 80, y - 192, "Instances", obj_runAndGun1_bullSmoke, {
					smokeDir: -1
				});
				currentIndex += 1;
				stateTimer[0] = 0;
			} else if (currentIndex == image_number - 2) {
				spawnMissiles(currentDir * 64, 212, 90 - (currentDir * 30));
				spawnMissiles(currentDir * 16, 212, 90 - (currentDir * 10));
				currentIndex += 1;
				stateTimer[0] = 0;
			} else if (currentIndex == image_number - 1) {
				attackState = 4;
				stateTimer[0] = 0;
				stateTimer[1] = 0;
			} else if (currentIndex != 9 && currentIndex != 11) {
				currentIndex += 1;
				stateTimer[0] = 0;
				stateTimer[1] = 0;
			} else if (currentIndex == 9 || currentIndex == 11) {
				if (stateTimer[1] < 20) {
				    stateTimer[1] += 1;
				} else {
					currentIndex += 1;
					stateTimer[0] = 0;
					stateTimer[1] = 0;
				}
			}
	        break;
		case 4: // Shoot cooldown
			if (stateTimer[0] < 5) {
			    stateTimer[0] += 1;
			} else if (currentIndex > 0) {
				stateTimer[0] = 0;;
				currentIndex -= 1;
				if (currentIndex == 12) {
				    currentIndex = 9;
				}
			} else if (currentIndex = 0) {
				stateTimer[0] = 0;
				enemyState = 0;
			}
			break;
	}
}


// Neutral Damage State
if (hitFlag == 1 && enemyState < 2 && damageFlag != 1) {
	if (enemyHealth >= 3000 - (currentPhase + 1) * 1000) {
	enemyHealth -= rifleCharge > 0 ? rifleCharge : 10;
	rifleCharge = 0;
	// Recalc current phase
	var thisPhase = currentPhase;
	currentPhase = 2 - floor(enemyHealth/3000 * 3);
		if (thisPhase != currentPhase && enemyHealth > 0) {
			enemyHealth = 3000 - (currentPhase * 1000 + 1);
			damageFlag = 1;
		} 
	}
	bulletInst = noone;
	hitRegistered = 1;
	hitFlag = 0;
}


// Stun Damage State
if (enemyState == 2) {
	damageFlag = 0;
	// Initial fall animation
    if (damageState == 0 && sprite_index == spr_runAndGun1_bullFall) {
		if (stateTimer[0] < 5) {
		    stateTimer[0] += 1;
		} else if (currentIndex < image_number - 1) {
			currentIndex += 1;
			stateTimer[0]= 0;
		} else {
			damageState = 1;
			sprite_index = spr_runAndGun1_bullDamage;
			currentIndex = 0;
			stateTimer[0] = 0;
			stateTimer[1] = 240;
		}
	}
	// Vulnerable to damage, references scientist's health now
	if (damageState == 1) {
		// Check scientist health and phase
		var healthPhase = 2 - floor(bossInst.enemyHealth/120 * 3);
		if (hitFlag == 1) {
			if (bossInst.damageState != 0) {
				if (currentIndex == 0 && stateTimer[0] == 0) {
					stateTimer[0] += 1;
				}
				if (bossInst.enemyHealth >= 120 - currentPhase * 40) {
					bossInst.enemyHealth -= rifleCharge > 0 ? rifleCharge/5 : 2;
					rifleCharge = 0;
					bossInst.damageFlag = 2;
					if (bossInst.enemyHealth < 120 - currentPhase * 40) {
					    bossInst.enemyHealth = 120 - currentPhase * 40 - 1;
					}
					hitRegistered = 1;
				}
			}
			bulletInst = noone;
			hitFlag = 0;
			
		}
		// Recalc scientist phase
		var mbPhase = 2 - floor(bossInst.enemyHealth/120 * 3);
		
		// Animation
		if (currentIndex != 0 || stateTimer[0] != 0) {
		    if (stateTimer[0] < 4) {
			    stateTimer[0] += 1;
			} else if (currentIndex < image_number - 1) {
				currentIndex += 1;
				stateTimer[0]= 0;
			} else {
				currentIndex = 0;
				stateTimer[0]= 0;
			}
		}
		
		// End Damage State
		if (bossInst.damageState != 0) {
			if (healthPhase == mbPhase && stateTimer[1] > 0) {
			    stateTimer[1] -= 1;
			}
		}
		// Player damages miniboss enough to progress phase
		if (healthPhase < mbPhase) {
		    bossInst.enemyHealth = 120 - currentPhase * 40 - 1;
			bossInst.damageState = 1;
			bossInst.damageFlag = 3;
			damageState = 2;
			sprite_index = spr_runAndGun1_bullFall;
			currentIndex = image_number - 1;
			stateTimer[0] = 0;
			stateTimer[1] = 0;
		}
		// Player does not cause enough damage in time
		if (stateTimer[1] == 0 && damageState == 1) {
		    enemyHealth += 20;
			if (enemyHealth >= (3 - currentPhase) * 1000 + 300) {
				bossInst.damageFlag = 0;
				bossInst.damageState = 2;
				bossInst.stateTimer[0] = 0;
				enemyHealth = (3 - currentPhase) * 1000 + 300;
			    damageState = 2;
				sprite_index = spr_runAndGun1_bullFall;
				currentIndex = image_number - 1;
				currentPhase = 2 - floor(enemyHealth/3000 * 3);
				stateTimer[0] = 0;
				stateTimer[1] = 0;
			}
		}
	}
	if (damageState == 2) {
	    if (stateTimer[0] < 4) {
			stateTimer[0] += 1;
		} else if (currentIndex > 0) {
			currentIndex -= 1;
			stateTimer[0]= 0;
		} else if (bossInst.enemyState == 0){
			enemyState = 0;
			damageState = 0;
			stateTimer[0]= 0;
			currentPhase = 2 - floor(enemyHealth/3000 * 3);
		}
	}
}

// Death state
if (enemyState == 3) {
	switch (damageState) {
      case 0:
			if (sprite_index != spr_runAndGun1_bullFall) {
			    sprite_index = spr_runAndGun1_bullFall;
				currentIndex = 0;
			}
			if (stateTimer[0] < 5) {
			    stateTimer[0] += 1;
			} else if (currentIndex < image_number - 1) {
				currentIndex += 1;
				stateTimer[0]= 0;
			} else {
				damageState = 1;
				sprite_index = spr_runAndGun1_bullDamage;
				currentIndex = 0;
				stateTimer[0] = 0;
			}
		break;
	case 1:
		// Check health and phase
		if (hitFlag == 1) {
			if (bossInst.damageState != 0) {
				if (currentIndex == 0 && stateTimer[0] == 0) {
					stateTimer[0] += 1; // Use this as a flag to trigger animation below
				}
				if (bossInst.enemyHealth > 0) {
					bossInst.enemyHealth -= rifleCharge > 0 ? rifleCharge/5 : 2;
					bossInst.damageFlag = 2;
					if (bossInst.enemyHealth < 0) {
						bossInst.enemyHealth = 0;
					}
				}
			}
			hitRegistered = 1;
			hitFlag = 0;
		}
		// Animation
		if (currentIndex != 0 || stateTimer[0] != 0) {
		    if (stateTimer[0] < 4) {
			    stateTimer[0] += 1;
			} else if (currentIndex < image_number - 1) {
				currentIndex += 1;
				stateTimer[0]= 0;
			} else {
				currentIndex = 0;
				stateTimer[0]= 0;
			}
		}

		// Player damages miniboss enough to progress to ending animation
		if (bossInst.enemyHealth <= 0) {
			damageState = 2;
			currentIndex = 0;
			stateTimer[0] = 0;
			stateTimer[1] = 0;
		}
		break;
	case 2:
        stateTimer[0] += 1;
        if (stateTimer[0] < 7 - deathLoops) {
			stateTimer[0] += 1;
		} else if (currentIndex < image_number - 1) {
			currentIndex += 1;
			stateTimer[0] = 0;
		} else if (deathLoops < 3) {
			deathLoops += .1;
			currentIndex = 0;
			stateTimer[0] = 0;
		} else {
			sprite_index = spr_runAndGun1_bullJump;
			currentIndex = 10;
			var timeToApex = abs(hopVImpulse) / hopGravity; 
			var totalFrames = round(timeToApex * 2);        
			hopXSpeed = (startX - x) / totalFrames;  
			hopYSpeed = hopVImpulse;
			hopAir = true;
			groundY = y;
			damageState = 3;
		}
        break;
	case 3:
      if (hopAir) {
        jumpXMotion();
        if (y >= groundY) {
          y = groundY;
          x = startX;
          damageState = 4;
		  obj_runAndGun1_pitCover.state = 3;
		  instance_create_layer(x - 32, y, "Instances", obj_runAndGun_explosion);
		  instance_create_layer(x + 32, y, "Instances", obj_runAndGun_explosion);
		  
		  instance_create_layer(x + currentDir * 8, y - 26, "Instances", obj_runAndGun1_bullSmokeRound, {
				smokeDir: 1
			});
			instance_create_layer(x + currentDir * 16, y - 26, "Instances", obj_runAndGun1_bullSmokeRound, {
				smokeDir: -1
			});
			// Right side smoke on shot
			instance_create_layer(x + currentDir * 8, y, "Instances", obj_runAndGun1_bullSmoke, {
				smokeDir: 1
			});
			instance_create_layer(x + currentDir * 16, y, "Instances", obj_runAndGun1_bullSmoke, {
				smokeDir: -1
			});
				
			// Left rear side smoke
			instance_create_layer(x + currentDir * 72, y - 26, "Instances", obj_runAndGun1_bullSmokeRound, {
				smokeDir: 1
			});
			instance_create_layer(x + currentDir * 80, y - 26, "Instances", obj_runAndGun1_bullSmokeRound, {
				smokeDir: -1
			});
			// Left side smoke
			instance_create_layer(x + currentDir * 72, y, "Instances", obj_runAndGun1_bullSmoke, {
				smokeDir: 1
			});
			instance_create_layer(x + currentDir * 80, y, "Instances", obj_runAndGun1_bullSmoke, {
				smokeDir: -1
			});
        }
    }
    break;
	case 4:
		jumpXMotion();
		if (y > 1420) {
			instance_destroy(obj_runAndGun_miniHealthBar);
		    instance_destroy();
		}
		break;
	}
}
ySpeed = hopYSpeed;
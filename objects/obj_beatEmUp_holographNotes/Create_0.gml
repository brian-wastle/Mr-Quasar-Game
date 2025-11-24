depth = 2;
spriteOpacity = .4;
outlineOpacity = .3;
bgOpacity = .3;
frameCount = 0;


function applyNoiseFilter(value, noiseRange = 0.01) {
    var noise = (random(1) * 2 - 1) * noiseRange;
    var newValue = value + noise;
    return newValue;
}


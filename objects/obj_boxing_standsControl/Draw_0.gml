var firstImageIndex = currentIndex;
var secondImageIndex = (currentIndex + 1) mod imageCount;
var imageY = 1380;

draw_sprite_ext(
    backgroundImages[firstImageIndex], 0, 
    scrollOffset + 1920 / 2 - 156, imageY, 
    1, 1, 0, c_white, .6
);

draw_sprite_ext(
    backgroundImages[secondImageIndex], 0, 
    scrollOffset + imageSpacing + 1920 / 2 - 156, imageY, 
    1, 1, 0, c_white, .6
);

if (scrollOffset > 0) {
    var previousImageIndex = (currentIndex - 1 + imageCount) mod imageCount;
    draw_sprite_ext(
        backgroundImages[previousImageIndex], 0, 
        scrollOffset - imageSpacing + 1920 / 2 - 156, imageY, 
        1, 1, 0, c_white, .6
    );
};
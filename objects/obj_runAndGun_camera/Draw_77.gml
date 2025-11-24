gpu_set_blendenable(false);

// Where does the game image land?
var surfW  = camWidth  * zoom;
var surfH  = camHeight * zoom;

var winW   = window_get_width();
var winH   = window_get_height();

// Center and vertical pan
var drawX  = (winW - surfW) * 0.5;
var drawY  = (winH - surfH) * 0.5 + drawOffset;

// Sub‑pixel snap
var subX   = -(frac(x      / 4) * 4) * zoom;
var subY   = -(frac(yFixed / 4) * 4) * zoom;

var picX   = drawX + subX;        // picture top‑left on the monitor
var picY   = drawY + subY;

// Draw the surface
draw_surface_ext(application_surface, picX, picY, zoom, zoom, 0, c_white, 1);

// Draw the letter‑box bars
var barHeight = 4 * round(barCurrent / 4);
if (barHeight > 0) {
    draw_set_color(c_black);
    draw_rectangle(0, 0, winW, barHeight, false);
    draw_rectangle(0, winH - barHeight, winW, winH, false);
}

gpu_set_blendenable(true);
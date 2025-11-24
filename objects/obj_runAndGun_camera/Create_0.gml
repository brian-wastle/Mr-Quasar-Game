// ------------ virtual resolution -----------------
camWidth  = 1920;
camHeight = 1080;

// application surface handling
surface_resize(application_surface, camWidth + 1, camHeight);
application_surface_draw_enable(false);

// ------------ tracking & zoom --------------------
yFixed      = round(room_height * 0.5 / 4) * 4;
targetObj      = obj_RunAndGun_Player;   // or noone
cutscene    = false;

zoomBase    = calcBaseZoom();            // 1, 1.25, 1.5, 2
zoomLevels  = [1, 1.2, 1.4, 1.6];       // relative factors
zoomIndex   = 0;
zoom        = zoomBase * zoomLevels[0];
targetZoom  = zoom;

targetPos   = { xPos : x, yPos : yFixed };

drawOffset   = 0;   // screen‑space vertical pan (pixels)
drawOffsetT  = 0;

smoothScreen = 10;
smoothPos    = 36;
smoothZoom   = 10;

// ------------ letter‑box animation ---------------
barTarget    = 0;          // px
barCurrent   = 0;          // px
barSpeed     = 0.20;       // lerp weight
letterboxPct = 0.12;       // 12 % of visible height

function updateBarTarget(_picH) {
    // 8-→12 % interpolation (use 50 % if you like)
    var pct = 0.04 + clamp((_picH - 1080) / (1620 - 1080), 0, 1) * (0.16 - 0.04);
    barTarget = 4 * round(pct * _picH / 4);   // snap to 4 px
}

function hideBars()  {barTarget = 0;}

/// Set camera focus during cut‑scenes, handles pan and zoom as well
function scrCameraFocus(_xRoom, _yParam, _zoomIdx, _instant=false)
{
    // ------------------------------------------------ 1. enter cut‑scene mode
    targetObj   = noone;
    cutscene = true;

    // ------------------------------------------------ 2. horizontal lock
    targetPos.x = round(_xRoom / 4) * 4;
    targetPos.y = yFixed;                       // camera never moves in Y

    // ------------------------------------------------ 3. choose zoom
    zoomIndex  = clamp(_zoomIdx, 0, array_length(zoomLevels) - 1);
	targetZoom = zoomBase * zoomLevels[zoomIndex];

	// ------------------------------------------------ 3. compute letterbox height from view height
	var picH = camHeight * targetZoom;
    updateBarTarget(picH);       // <<< only call here

    // Snap to multiples of 4
    function snap4(v) { return round(v / 4) * 4; }

    // ------------------------------------------------ 4. vertical framing
    var roomDelta;          // how far we move the *room* coordinate in Y

    if (abs(_yParam) <= 1)   // --- percentage style -------------------------
    {
        // picture height in room units is camHeight
        roomDelta = snap4(_yParam * camHeight);     // keep 4‑px grid
    }
    else                     // --- absolute room Y (legacy) -----------------
    {
        var yTarget = snap4(_yParam);
        roomDelta   = yTarget - yFixed;             // already 4‑px snapped
    }

    // Convert the room delta to **screen‑space** pixels
    // (multiply AFTER snapping so we still land on 4 * zoom pixels)
    drawOffsetT = -roomDelta * targetZoom;

    // ------------------------------------------------ 5. optional instant cut
    if (_instant)
    {
        x          = targetPos.x;
        drawOffset = drawOffsetT;
        zoom       = targetZoom;
    }
}

/// Leaves cut‑scene, recentres the screen, zooms back out.
function scrCameraFollow(_who)
{
    targetObj   = _who;
    cutscene = false;
    hideBars();

    // ease back to default zoom
    zoomIndex  = 0;
    targetZoom = zoomBase * zoomLevels[0];

    // ease screen back to centre
    drawOffsetT = 0;
}

function calcBaseZoom() {
    var winW = window_get_width();
    var winH = window_get_height();

    // scales you actually support
    var allowed = [1, 1.25, 1.5, 2];

    var fit  = min(winW / camWidth, winH / camHeight);
    var best = 1;
    for (var i = 0; i < array_length(allowed); ++i) {
        if (allowed[i] <= fit) best = allowed[i];
    }
    return best;
}
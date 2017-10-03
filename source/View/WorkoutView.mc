using Toybox.Graphics as Gfx;
using Toybox.System as Sys;

class WorkoutView extends IQView {

	hidden var x;
	hidden var restY;
	hidden var timeY;
	hidden var repsY;
	
	function initialize(delegate) {
		IQView.initialize(delegate); 
    }
    
    function onLayout(dc) {
        IQView.onLayout(dc);
		x = width/2; 
		var screenShape = Sys.getDeviceSettings().screenShape;
		if (screenShape == Sys.SCREEN_SHAPE_ROUND) {
			restY = height * 3 /4 + 5;
        	timeY = height/4 + 10;
        	repsY = height/4 - 15;
    	} else if (screenShape == Sys.SCREEN_SHAPE_SEMI_ROUND) {
        	restY = height * 3 /4;
        	timeY = height/2 - 50;
        	repsY = height/2 - 70;
    	} else {
    		restY = height * 3 /4;
        	timeY = height/2 - 30;
        	repsY = height/2 - 70;
    	}
    }

    function onUpdate(dc) {
    	IQView.onUpdate(dc);
   		drawRest(dc); 
   		drawTime(dc); 
   		drawReps(dc); 
    }
    
    function drawRest(dc) {
    	if (getDelegate().restRunning()) {
        	dc.drawText(x, restY, Gfx.FONT_LARGE, "Rest", Gfx.TEXT_JUSTIFY_CENTER);
        }
    }
    
    function drawTime(dc) {
    	var sec = getDelegate().getSeconds();
    	var timeString = Lang.format("$1$:$2$", [(sec/60), (sec%60).format("%02d")]);
        dc.drawText(x, timeY, Gfx.FONT_NUMBER_THAI_HOT, timeString, Gfx.TEXT_JUSTIFY_CENTER);
    }
    
    function drawReps(dc) {
    	if (getDelegate().getRepsOn()) {
        	dc.drawText(x, repsY, Gfx.FONT_LARGE, "Rep: " + getDelegate().getReps(), Gfx.TEXT_JUSTIFY_CENTER);
        }
    }
}
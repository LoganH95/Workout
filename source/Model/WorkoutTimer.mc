using Toybox.Timer as Timer;
using Toybox.Application as App;
using Toybox.System as Sys;

class WorkoutTimer {
	var sec, isRunning, reps, isFinishing; 
	hidden var settings, type; 
	
	enum { 
		timer_type,
		rest_type
	}
	
	function initialize(settings) {
        self.settings = settings;
        reset(); 
	}
	
	function reset() {
		clockReset(); 
		reps = 0; 
		type = timer_type;  
		isRunning = false; 
		isFinishing = false; 
	}
    
	function clockReset() {
		sec = 0; 
	}
	
	function restRunning() {
		return isRunning && type == rest_type; 
	}
	
	function swapTimer() {
		type = type == timer_type ? rest_type : timer_type;
	}
	
	function incrementSec() {
		sec += 1;
		checkTime(); 
	}
	
	function startTimer() {
		isRunning = true; 
	}
	
	function pauseTimer() {
		isRunning = false; 
	}
	
	function endTimer() {
		var repeat = settings.getRepeat();
		if (!repeat) {
			isRunning = false; 
		} else if (type == timer_type) {
			reps += 1; 
		}
		
		if (repeat && settings.getRest()) {
			swapTimer(); 
		} 
		
		isFinishing = false;
		clockReset();
	}
	
	function checkTime() {
		if (sec > getStartingTime() - 3) {
			isFinishing = true; 
		}
		if (sec > getStartingTime()) {
			endTimer();
		}
	}
	
	function getStartingTime() {
		if (type == timer_type) {
			return settings.getStartingSeconds();
		} else {
			return settings.getRestTime();
		}
	}
}
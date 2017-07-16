using Toybox.Application as App;

class WorkoutTimerSettings {
	hidden var startingSeconds, repeat, rest, restTime;
	
	function fetchSettings() {
		var app = App.getApp();
		rest = app.getProperty("rest");
		repeat = app.getProperty("reps");
		restTime = app.getProperty("restTime");
		startingSeconds = app.getProperty("sec");
	}
	
	function getStartingSeconds() {
		if (startingSeconds == null) {
			return 30; 
		}
		return startingSeconds; 
	}
	
	function getRest() {
		if (rest == null) {
			return false; 
		}
		return rest; 
	}
	
	function getRestTime() {
		if (restTime == null) {
			return 5;  
		}
		return restTime; 
	}

	function getRepeat() {
		if (repeat == null) {
			return false; 
		}
		return repeat; 
	}
}
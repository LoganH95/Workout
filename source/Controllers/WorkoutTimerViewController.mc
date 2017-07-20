using Toybox.WatchUi as Ui;

class WorkoutTimerViewController extends ViewController {

	hidden var timer, workoutTimer, settings;
	
	function initialize() {
		ViewController.initialize();
		view = new WorkoutView(self);
	}
	
	//View Life Cycle
	
	function viewDidLoad() {
		settings = new WorkoutTimerSettings();
		workoutTimer = new WorkoutTimer(settings); 
    	timer = new Timer.Timer();
	}
	
	function viewWillUpdate(dc) {
    	settings.fetchSettings();
	}
	
	function reloadView() {
        checkTimerFinished(); 
		ViewController.reloadView();
	}
	
	//Behavior Delegate
	
	function onMenu() {
    	pauseTimer(); 
        Ui.pushView(new Rez.Menus.MainMenu(), new WorkoutMenuDelegate(self), Ui.SLIDE_UP);
        return true;
    }
    
    function onTap(evt) {
    	toggleTimer();
    	return true; 
    }
    
    function onNextMode() {
    	toggleTimer();
    	return true; 
    }
    
    function onKey(evt) {
    	if (evt.getKey() == 4) {
    		toggleTimer();
    		return true;
    	}
    	else {
    		return false; 
    	}
    }
    
    //Timer Methods
    
    function toggleTimer() {
    	if (workoutTimer.isRunning) {
    		pauseTimer(); 
    	} else {
    		startTimer(); 
    	}
    }
    
    function startTimer() {
    	timer.start(method(:timerIncrement), 1000, true);
    	Attention.vibrate([new Attention.VibeProfile(10, 200)]);
    	workoutTimer.startTimer();
    }
    
    function pauseTimer() {
    	timer.stop(); 
    	workoutTimer.pauseTimer(); 
    }
    
    function timerIncrement() {
    	workoutTimer.incrementSec(); 
		reloadView();
    }
    
    function restartTimer() {
		workoutTimer.reset(); 
	}
	
	function checkTimerFinished() {
    	if (!workoutTimer.isRunning) {
        	timer.stop(); 
        }	
        vibrateOnFinish();
    }
    
    function getRepsOn() {
    	return settings.getRepeat();
    }
    
    function restRunning() {
    	return workoutTimer.restRunning();
    }
    	
    function getReps() {
    	return workoutTimer.reps;
    }
    
    function getSeconds() {
    	return workoutTimer.sec;
    }
	
	//Vibration
	
	function vibrateOnFinish() {
    	if (workoutTimer.isFinishing) {
        	Attention.vibrate([new Attention.VibeProfile(10, 800)]);
        }
    }
    
    //Menu Delegate
    
    function settingsDidChange() {
    	settings.fetchSettings();
    	restartTimer();
    }
}
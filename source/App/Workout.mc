using Toybox.Application as App;

class WorkoutApp extends App.AppBase {

	function initialize() {
		AppBase.initialize();
	}

    function onStart(state) {
    }

    function onStop(stat) {
    }
    
    function getInitialView() {
    	var controller = new WorkoutTimerViewController();
        return [ controller.getView(), controller ];
    }

}

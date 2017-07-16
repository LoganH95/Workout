using Toybox.WatchUi as Ui;

class ViewController extends Ui.BehaviorDelegate {
	hidden var title, view, parentViewController; 
	
	function initialize() {
		BehaviorDelegate.initialize();
		title = ""; 
		view = new IQView(self);
	}
	
	function reloadView() {
		 Ui.requestUpdate(); 
	}
	
	function viewDidLoad(dc) {
		//Subclass can override to provide functionallity
	}
	
	function viewDidAppear(dc) {
		//Subclass can override to provide functionallity
	}
	
	function getView() {
		return view; 
	}
	
	function getTitle() {
		return title;
	}
	
	function setParentViewController(parentViewController) {
		self.parentViewController = parentViewController; 
	}
	
	//Behavior Delegate
	
	function onKey(evt) {
		if (parentViewController == null) {
			return; 
		}
		parentViewController.onKey(evt); 
	}
	
	function onMenu() {
		if (parentViewController == null) {
			return; 
		}
        parentViewController.onMenu();
    }
    
    function onTap(evt) {
    	if (parentViewController == null) {
			return; 
		}
    	parentViewController.onTap(evt);
    }
	
	function onSwipe(evt) {
		if (parentViewController == null) {
			return; 
		}
    	parentViewController.onSwipe(evt);
    }
}
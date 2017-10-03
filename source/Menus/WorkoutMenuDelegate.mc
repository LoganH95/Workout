using Toybox.WatchUi as Ui;
using Toybox.Application as App;

class WorkoutMenuDelegate extends Ui.MenuInputDelegate {

	hidden var delegate;
	hidden const REPS_PROPERTY = "reps";
	hidden const REST_PROPERTY = "rest";
	
	function initialize(delegate) {
        MenuInputDelegate.initialize();
        self.delegate = delegate.weak();
    }

    function onMenuItem(item) {
    	switch (item) {
    		case :Time:
    			Ui.pushView(new TimePicker(), new TimePickerDelegate(self), Ui.SLIDE_IMMEDIATE);
    			break;
    		case :Reps:
    			Ui.pushView(new Rez.Menus.OnOffMenu(), new OnOffConfirmationDelegate(self, REPS_PROPERTY), Ui.SLIDE_IMMEDIATE);
    			break;
    		case :Rest:
    			Ui.pushView(new Rez.Menus.OnOffMenu(), new OnOffConfirmationDelegate(self, REST_PROPERTY), Ui.SLIDE_IMMEDIATE);
    			break;
    		case :Restart:
    			notifyDelegateSettingsDidChange();
    			break;
    	}
    }
    
    function getDelegate() {
    	return delegate.get();
    }	
    
    function notifyDelegateValueTurnedOn(property) {
    	switch (property) {
    		case REPS_PROPERTY:
    			//DO NOTHING
    			return;
    		case REST_PROPERTY:
        		Ui.pushView(new TimePicker(), new RestPickerDelegate(self), Ui.SLIDE_IMMEDIATE); 
    		default:
    			//DO NOTHING
    			return;
    	}
    }
    
    function notifyDelegateSettingsDidChange() {
    	getDelegate().settingsDidChange();
    }
}

class OnOffConfirmationDelegate extends Ui.MenuInputDelegate {

	hidden var delegate;
	hidden var property;

     function initialize(delegate, property) {
        MenuInputDelegate.initialize();
        self.delegate = delegate.weak();
        self.property = property;
    }

    function onMenuItem(item) {
    	var value = item == :On;
        App.getApp().setProperty(property, value);
        if (value) {
        	getDelegate().notifyDelegateValueTurnedOn(property);
        }
        getDelegate().notifyDelegateSettingsDidChange();
    }
    
    function getDelegate() {
    	return delegate.get();
    }	
}

class RestConfirmationDelegate extends Ui.MenuInputDelegate {

	hidden var delegate;

    function initialize(delegate) {
    	MenuInputDelegate.initialize();
        self.delegate = delegate.weak();
    }

    function onMenuItem(item) {
        App.getApp().setProperty("rest", item == :On);
        if (item == :On) {
        	 Ui.pushView(new TimePicker(), new RestPickerDelegate(getDelegate()), Ui.SLIDE_IMMEDIATE); 
        }
        getDelegate().notifyDelegateSettingsDidChange();
    }
    
    function getDelegate() {
    	return delegate.get();
    }	
}
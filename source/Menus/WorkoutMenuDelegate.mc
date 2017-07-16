using Toybox.WatchUi as Ui;
using Toybox.Application as App;

class WorkoutMenuDelegate extends Ui.MenuInputDelegate {
	hidden var delegate;
	
	function initialize(delegate) {
        MenuInputDelegate.initialize();
        self.delegate = delegate.weak();
    }

    function onMenuItem(item) {
        if (item == :Time) {
    		Ui.pushView(new TimePicker(), new TimePickerDelegate(self), Ui.SLIDE_IMMEDIATE);
        } else if (item == :Reps) {
            Ui.pushView(new Rez.Menus.OnOffMenu(), new RepsConfirmationDelegate(self), Ui.SLIDE_IMMEDIATE);
        } else if (item == :Rest) {
            Ui.pushView(new Rez.Menus.OnOffMenu(), new RestConfirmationDelegate(self), Ui.SLIDE_IMMEDIATE);
        } else if (item == :Restart) {
        	notifyDelegateSettingsDidChange();
        }
    }
    
    function getDelegate() {
    	return delegate.get();
    }	
    
    function notifyDelegateSettingsDidChange() {
    	getDelegate().settingsDidChange();
    }
}

class RepsConfirmationDelegate extends Ui.MenuInputDelegate {
	hidden var delegate;

     function initialize(delegate) {
        MenuInputDelegate.initialize();
        self.delegate = delegate.weak();
    }

    function onMenuItem(item) {
        if (item == :On) {
            App.getApp().setProperty("reps", true);
        } else if (item == :Off) {
            App.getApp().setProperty("reps", false);
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
        if (item == :On) {
            App.getApp().setProperty("rest", true);
            Ui.pushView(new TimePicker(), new RestPickerDelegate(getDelegate()), Ui.SLIDE_IMMEDIATE); 
        } else if (item == :Off) {
            App.getApp().setProperty("rest", false);
        }
        getDelegate().notifyDelegateSettingsDidChange();
    }
    
    function getDelegate() {
    	return delegate.get();
    }	
}
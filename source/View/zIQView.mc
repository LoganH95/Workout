using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class IQView extends Ui.View {
	hidden var delegate, height, width;
	
	function initialize(delegate) {
		View.initialize(); 
		self.delegate = delegate.weak(); 
    }
    
    function onLayout(dc) { 	
    	getDelegate().viewDidLoad(dc);
    	height = dc.getHeight();
        width = dc.getWidth();
    }
    
    function onUpdate(dc) {
    	View.onUpdate(dc);
    	dc.setColor( Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
    	getDelegate().viewDidAppear(dc);
        dc.drawText(5, 0, Gfx.FONT_MEDIUM, getDelegate().getTitle(), Gfx.TEXT_JUSTIFY_LEFT);
    }
    
    function getDelegate() {
    	return delegate.get(); 
    }
}
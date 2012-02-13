# moofx 3 (µfx)

broken alpha version 0.8.7

## usage

### animate

	µ(element).fx(styles); //animate styles, default options
	
	µ(element).fx(property, value); //animate property to value
	
	µ(element).fx(styles, options); //animate styles using options
	
	µ(element).fx(property, value, options); //animate property to value using options
	
	µ(element).fx(styles, {duration: 5000}); //5s duration
	
	µ(element).fx(styles, {duration: "5000ms", equation: 'cubic-bezier(0.17,0.67,0.83,0.67)'}); //5s duration, cubic-bezier easing function
	
	µ(element).fx(styles, {duration: "5s", equation: 'cubic-bezier(0,1,1,0)'}); //5s duration, cubic-bezier easing function
	
	µ(element).fx(styles, {duration: "5s", equation: 'cubic-bezier(0,1,1,0)', callback: function(){ //5s duration, cubic-bezier easing function, completion callback
		console.log('animated');
	}});
	
### style

	µ(element).style(styles);
	
	µ(element).style({background: 'red'});  //set styles

	µ(element).fx(property, value); //set style property to value

	µ(element).fx(property); //getter

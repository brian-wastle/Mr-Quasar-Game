///@param start
///@param increment
///@param max
function increase(argument0, argument1, argument2) {
	var start = argument0;
	var increment = argument1;
	var nmax = argument2;
	var result = start + increment;
	while(result >= nmax)
	    result -= nmax;
	while(result < 0)
	    result += nmax;
	return result;

}


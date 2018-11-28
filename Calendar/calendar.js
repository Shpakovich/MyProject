var W, day, month, numYear,numCentury,result;
day = 0;
month = 0;
year = 0;
result=0;


	
	function gets(){
		day = document.getElementById('day').value;
		month = document.getElementById('month').value;
		//разделение года на 2 части
		a = document.getElementById('year').value;
		b = String(a).split("");
		//записть в переменную
		numYear = b[2] + b[3];
		numCentury = b[0] + b[1];

		if (+month >= 3){
			month = +month - 2;
		}
		else if(+month < 3){
			month = +month + 10;
		}

		/*if (month > 10) {
			numYear = numYear - 1;
		}*/
		
		
		W = +day + Math.round((13 * +month - 1)/5) + +numYear + Math.round(+numYear / 4) + Math.round(+numCentury / 4) - 2 * +numCentury;

		result = Math.abs(W)%7;

		if(W < 7){
			result = 7 - W;
		}

		alert(result);
	
}



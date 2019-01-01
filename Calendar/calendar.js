var W, day, month, numYear,numCentury,result;
day = 0;
month = 0;
result=0;

	function clear(){
		allert('pidr');
		document.getElementById('weekp').reset();
	}

	
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

		if (month > 10) {
			numYear = numYear - 1;
		}
		
		W = +day + Math.floor((13 * +month - 1)/5) + +numYear + Math.floor(+numYear / 4) + Math.floor(+numCentury / 4) - 2 * +numCentury;

		result = Math.abs(W)%7;

		if(W < 7){
			result = W;
		}

	switch (result)
		{
		case 0:	
		weekp.innerHTML = "It's Sunday";break;
		case 1:
		weekp.innerHTML = "It's Monday"; break;
		case 2:
		weekp.innerHTML = "It's Tuesday"; break;
		case 3: 
		weekp.innerHTML = "It's Wednesday";break;
		case 4:
		weekp.innerHTML = "It's Thursday"; break;
		case 5:
		weekp.innerHTML = "It's Friday";break;
		case 6:
		weekp.innerHTML = "It's Suturday"; break;
		}
}




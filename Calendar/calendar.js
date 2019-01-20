var W, day, month, numYear,numCentury,result;
day = 0;
month = 0;
result=0;


function NonFriday (){
				document.getElementsByClassName('main')[0].style.background="url(img/calender.jpg) center";
				document.getElementsByClassName('main')[0].style.backgroundSize="cover";
				document.getElementsByClassName('main-overlain')[0].style.backgroundImage="-webkit-linear-gradient(60deg, rgb(153, 50, 204) 0%, rgb(47, 79, 79) 100%)";
				document.getElementsByClassName('main-overlain')[0].style.backgroundImage="-o-linear-gradient(60deg, rgb(153, 50, 204) 0%, rgb(47, 79, 79) 100%)";
				document.getElementsByClassName('main-overlain')[0].style.backgroundImage="linear-gradient(150deg, rgb(153, 50, 204) 0%, rgb(47, 79, 79) 100%)";
}


	function clearOut(){
		//сброс всех параментов
		document.getElementById('day').value = " ";
		document.getElementById('month').value = " ";
		document.getElementById('year').value = " ";
		weekp.innerHTML = "Welcome";
		if( day == 13 && result == 5){
			audio.volume = 0.0;
			NonFriday();
			}

	}

	
	function gets(){

		// убираем подпись под днем недели при первом запуске
		var ps = document.querySelector(".ps");
		ps.style.display = "none"; 
		// присваеваем значение инпутов в переменные 
		day = document.getElementById('day').value;
		month = document.getElementById('month').value;
		//разделение года на 2 части
		a = document.getElementById('year').value;
		b = String(a).split("");
		//записть в переменную
		numYear = b[2] + b[3];
		numCentury = b[0] + b[1];

		// меняем значения месяцев и года формулы на нормальные
		if (+month >= 3){
			month = +month - 2;
		}
		else if(+month < 3){
			month = +month + 10;
		}

		if (month > 10) {
			numYear = numYear - 1;
		}
		// формула рассчёта дня недели
		W = +day + Math.floor((13 * +month - 1)/5) + +numYear + Math.floor(+numYear / 4) + Math.floor(+numCentury / 4) - 2 * +numCentury;

		result = Math.abs(W)%7;

		if(W < 7){
			result = W;
		}
		//вывод на экран(замена дифа)
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

		//ошибки при неправильных значениях
		if(month>12 || day>31){
			weekp.innerHTML = "Error type of Date";
		}
		

		function mus (){
			 audio = new Audio(); // Создаём новый элемент Audio
  			audio.src = 'audio/Undertaker.mp3'; // Указываем путь к звуку "клика"
		}
			if( day == 13 && result == 5){
				document.getElementsByClassName('main')[0].style.background="url(img/13.gif) center";
				weekp.innerHTML = "It's Friday of 13!";
				document.getElementsByClassName('main')[0].style.backgroundSize="cover";
				document.getElementsByClassName('main-overlain')[0].style.backgroundImage="none";
			mus();
  			audio.autoplay = true; // Автоматически запускаем
  			audio.volume = 0.3;
			}
			else{
				audio.volume = 0.0;
				NonFriday();
			}
}





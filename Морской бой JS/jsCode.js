/*var element = document.getElementById('test');
var el2 = document.getElementById('test2');

element.onclick = function() {
    element.style.background="url(img/explosion.jpg) center";
    element.style.backgroundSize = "250% 250%";
}

el2.onclick = function() {
    el2.style.background="url(img/miss.jpg) center";
    el2.style.backgroundSize = "160% 160%";
}
*/
var arrayShip = new Array();
var wrongId = new Array();
var oneDeckShip = new Array();
var deck = new Array();
var continueShips = new Array();
var deckShips = new Array();

var oneDeck = 4,twoDeck = 3, threeDeck = 2, fourDeck =1;


//document.getElementById('oneDeck').innerHTML = oneDeck;
	
			var table1 = document.getElementById('tableShot');
			table1.style.opacity = "0.4";

function newShip(id){
	var changeEl = document.getElementById(id);
	var checkField = 0;
	var checkTest = 0;
	for (;arrayShip.length < 16; arrayShip.length + 1)
		{
			
			if(arrayShip.indexOf(id) > -1){
					alert("alarm!");
					return arrayShip;
			}
			
			var onlyId = id.replace(/[^+\d]/g, '') - 0;

			if(wrongId.indexOf(onlyId) > -1){
				alert("Dont do This!");
				return arrayShip;
			}

			// Обработка края поля и добавления WrongId
			if (((onlyId%10)!=0)&&((onlyId%10)!=1)) {
			wrongId[wrongId.length] = onlyId - 11;
			wrongId[wrongId.length] = onlyId - 9;
			wrongId[wrongId.length] = onlyId - 0 + 9;
			wrongId[wrongId.length] = onlyId -0 + 11;
			}
			if ((onlyId%10)==0) {
			wrongId[wrongId.length] = onlyId - 11;
			wrongId[wrongId.length] = onlyId - 0 + 9;
			}
			if ((onlyId%10)==1) {
			wrongId[wrongId.length] = onlyId - 9;
			wrongId[wrongId.length] = onlyId - 0 + 11;
			}

				//подсчёт возможных продолжений для многопалубника
				oneDeckShip[oneDeckShip.length]=onlyId -10;
				oneDeckShip[oneDeckShip.length]=onlyId -1;
				oneDeckShip[oneDeckShip.length]=onlyId -0 +1;
				oneDeckShip[oneDeckShip.length]=onlyId -0 +10;

				//сброс массива если id не попадает в позиции oneDeckShip(то есть многопалубный)
						/*for (var i = 0; i < oneDeckShip.length; i++) {
					alert(oneDeckShip[i] == onlyId);
				}*/
				alert(checkField);

				if(oneDeckShip.indexOf(onlyId)>-1){
					
					alert("SomeDeck ship");
					checkField = 1;
				}

				if(checkField == 0){	
					for(position = 0;position < 4; position++)
					{
						deck[deck.length] = arrayShip.indexOf("id" + oneDeckShip[position]);
						alert(deck);
						checkTest = 1;
					}
				}



			/*if(checkField == 1){
				alert(arrayShip[arrayShip.length - 1].replace(/[^+\d]/g, '') - 0 + 1);
				continueShips[continueShips.length] = arrayShip[0].replace(/[^+\d]/g, '') - 1;
				continueShips[continueShips.length] = arrayShip[0].replace(/[^+\d]/g, '') - 10;
				continueShips[continueShips.length] = arrayShip[0].replace(/[^+\d]/g, '') -0 + 1;
				continueShips[continueShips.length] = arrayShip[0].replace(/[^+\d]/g, '') -0 + 10;
				continueShips[continueShips.length] = arrayShip[arrayShip.length - 1].replace(/[^+\d]/g, '') - 0 + 1;
				continueShips[continueShips.length] = arrayShip[arrayShip.length - 1].replace(/[^+\d]/g, '') - 0 - 1;
				continueShips[continueShips.length] = arrayShip[arrayShip.length - 1].replace(/[^+\d]/g, '') - 0 + 10;
				continueShips[continueShips.length] = arrayShip[arrayShip.length - 1].replace(/[^+\d]/g, '') - 0 - 10;

				alert("ВАЖНО !! " + onlyId);
				alert("ВАЖНО СЕЙЧАС ! " + continueShips);
				if (continueShips.indexOf(onlyId) == -1) {
					deckShips[deckShips.length] = arrayShip;
					arrayShip = []; 
					alert("Okey " + arrayShip);
				}
			}*/

		if (checkField === 1) 
		{
			var first = Math.floor(arrayShip[0].replace(/[^+\d]/g, '') - 0) /10;
			var sec = Math.floor(arrayShip[arrayShip.length - 1].replace(/[^+\d]/g, '') - 0) /10;
			alert(first + sec);

			if (first == sec) {
				alert("aliluaaa");
			}
		}

				// запись в массив deck 
			if (checkTest == 0) {	
				for(position = 0;position < oneDeckShip.length; position++)
				{
						deck[deck.length] = arrayShip.indexOf("id" + oneDeckShip[position]);
				}

				alert(arrayShip);
				alert(oneDeckShip);
			}
			
			if (checkField === 1) {
						alert("new code");
						var overlap = new Array();
						var overlap2 = new Array();

						if(oneDeckShip.indexOf(onlyId) == -1){
							overlap = [];
							overlap2 = [];
							alert("reset");
						}
							
							for(p = 0; p < arrayShip.length; p++)
								{
									for (i = 0; i < oneDeckShip.length; i++)
									{
				        				if (("id" + oneDeckShip[i]) === arrayShip[p]) {
				            			overlap[overlap.length] = oneDeckShip[i];
				            			alert("Array same " + overlap);
				        				}
				        			}
				        		}

							for (var i = 0; i < overlap.length; i++) {
				  				if (overlap2[overlap[i]]) {
				    			overlap2[overlap[i]] += 1;
				  				} else {
				    			overlap2[overlap[i]] = 1;
				  				}
				  				alert("Array2 over " + overlap2);
				  				alert("Array2 OMG " + overlap2.length);
							}
							
							var filtered = overlap2.filter(function (el) {
				 			return el != null;
							});
							alert("Array2 new " + filtered);	
							var maxValueNew = filtered.length;
							alert(maxValueNew);

				}

								var maxValue = Math.max.apply(null,deck);
								//alert(oneDeckShip);
								//alert(deck);

				if (maxValue == -1) {
						oneDeck --;
						document.getElementById('oneDeck').innerHTML = oneDeck;
				}
				if (maxValueNew == 1) {
						twoDeck --;
						document.getElementById('twoDeck').innerHTML = twoDeck;
						oneDeck ++;
						document.getElementById('oneDeck').innerHTML = oneDeck;
				}
				if (maxValueNew == 2) {
						threeDeck --;
						document.getElementById('threeDeck').innerHTML = threeDeck;
						twoDeck ++;
						document.getElementById('twoDeck').innerHTML = twoDeck;
				}
				if (maxValueNew == 3) {
						fourDeck --;
						document.getElementById('fourDeck').innerHTML = fourDeck;
						threeDeck ++;
						document.getElementById('threeDeck').innerHTML = threeDeck;
				}

				if(maxValueNew > 3){
						alert("Вы не можете строить более 4 палубного корабля");
						return arrayShip;
				}

			changeEl.style.background = "url(img/ships.jpg) center";
			changeEl.style.backgroundSize = "100% 100%";
			arrayShip[arrayShip.length] = id;
			//alert(arrayShip);
				if(arrayShip.length > 5){
					table1.style.opacity = "1";
				}
				
			return arrayShip;
		}
}


function shot(id){
	var equivalentId = id.replace(/[^+\d]/g, '') - 100;
	if(arrayShip.length < 5){
		return arrayShip.length;
	}else{

			var element = document.getElementById(id);
			if(arrayShip.indexOf("id"+equivalentId) > -1)
			{

				
				element.style.background="url(img/explosion.jpg) center";
    			element.style.backgroundSize = "250% 250%";
    			//alert(equivalentId);
			}
			else{
				element.style.background="url(img/miss.jpg) center";
    			element.style.backgroundSize = "160% 160%";
			}
		}
}
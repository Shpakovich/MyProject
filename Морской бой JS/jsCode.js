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
var grandArrayShip = new Array();
var grandArrayShipNum = new Array();
var wrongId = new Array();
var oneDeckShip = new Array();
var deck = new Array();
var continueShips = new Array();
var deckShips = new Array();
var nearIdPosition = new Array();
var posibleId = new Array();
var grandPosibleId = new Array();
var grandPosibleIdNum = new Array();
var resetID = new Array();

var checkQuantityShips = 0;
var oneDeck = 4,twoDeck = 3, threeDeck = 2, fourDeck =1;


	
			var table1 = document.getElementById('tableShot');
			table1.style.opacity = "0.4";

function newShip(id)
{
	var changeEl = document.getElementById(id);
	var checkField = 0;
	var checkTest = 0;
	checkQuantityShips = 0;

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


				if(oneDeckShip.indexOf(onlyId)>-1){
					checkField = 1;
				}

				if(checkField == 0){
				// сброс posibleId при начале нового корабля т.к. новые значения корабля
					checkQuantityShips = 1;
					posibleId = [];
					for(position = 0;position < 4; position++)
					{
						deck[deck.length] = arrayShip.indexOf("id" + oneDeckShip[position]);
						alert(deck);
						checkTest = 1;
					}
							// чистим resetID,записываем в posibleId значения продолжения корабля
							resetID = [];
							posibleId[posibleId.length] = onlyId + 1;
							posibleId[posibleId.length] = onlyId + 10;
							posibleId[posibleId.length] = onlyId - 1;
							posibleId[posibleId.length] = onlyId - 10;
							//alert(posibleId + "  oneDeck  "+ resetID);
				}
				// если вторая ячейка корабля и он идёт в линию чистим posibleId от значений -10 и +10
				if (arrayShip.length == 1) {
					if (Math.floor(Math.floor(arrayShip[0].replace(/[^+\d]/g, '') - 0) /10) == Math.floor(Math.floor(onlyId) /10)) {
					posibleId[0] = posibleId[0];
					posibleId[1] = posibleId[2];
					posibleId.length = 2;
					}
				}


		// это историческая хуйня!
		if (checkField === 1) 
		{
			// проверка направления корабля
			var first = Math.floor(arrayShip[0].replace(/[^+\d]/g, '') - 0) /10;
			var sec = Math.floor(onlyId) /10;
			resetID = [];
			if (Math.floor(first) == Math.floor(sec)) {
				var direction = "line";
				posibleId[posibleId.length] = onlyId + 1;
				posibleId[posibleId.length] = onlyId - 1;
				resetID[resetID.length] = Math.min.apply(null,posibleId);
				resetID[resetID.length] = Math.max.apply(null,posibleId);
			}else{
				var direction = "column";
				posibleId[posibleId.length] = onlyId + 10;
				posibleId[posibleId.length] = onlyId - 10;
				resetID[resetID.length] = Math.min.apply(null,posibleId);
				resetID[resetID.length] = Math.max.apply(null,posibleId);
			}
			alert(posibleId + "   "+ resetID);
		}

		// если новый корабль не в posibleId, то запись arrayShip в grandArrayShip и сброс arrayShip
		if (posibleId.indexOf(onlyId) == -1) {
			arrayShip = [];
			if (grandArrayShip.length < 100) {
			grandArrayShip[grandArrayShip.length] = arrayShip;
			}
		}

		// проверка поз-ции нового корабля, нету ли его рядом со старым
		grandPosibleId[grandPosibleId.length] = posibleId;
		//раскрытие двухмерного массива grandPosibleId[] в одномерный grandPosibleIdNum
		grandPosibleIdNum = [].concat(...grandPosibleId);
		//поиск текущего ID в значениях массива grandPosibleIdNum
		if (grandPosibleIdNum.indexOf(onlyId) > -1) {
			nearIdPosition = [];
			nearIdPosition[nearIdPosition.length] = onlyId + 1;
			nearIdPosition[nearIdPosition.length] = onlyId + 10;
			nearIdPosition[nearIdPosition.length] = onlyId - 1;
			nearIdPosition[nearIdPosition.length] = onlyId - 10;
			alert("here is ships!!! " + nearIdPosition); //рядом стоит корабль
			// делаем из многомерного массива grandArrayShip одномерный grandArrayShipNum c типом num
 			grandArrayShipNum = [].concat(...grandArrayShip);
			for (var i = 0; i < grandArrayShipNum.length; i++) {
				grandArrayShipNum[i] = grandArrayShipNum[i].replace(/[^+\d]/g, '') - 0;
			}

			alert(grandArrayShipNum + " a nu ka");
			alert(grandArrayShipNum.length + " kol-vo");
				for (checkPoint = 0; checkPoint < nearIdPosition.length; checkPoint++) {

					for (cP = 0; cP < grandArrayShipNum.length; cP++) {
						//alert((grandArrayShipNum[cP] + "").replace(/[^+\d]/g, '') - 0);
						var nearId = (grandArrayShipNum[cP] + "").replace(/[^+\d]/g, '') - 0;
						alert( nearId +" nearId   " +grandArrayShipNum);
						alert( nearIdPosition[checkPoint] + " nearIdPosition  " + nearIdPosition);
							if (nearId == nearIdPosition[checkPoint]) {
								var qShips = nearId + (nearId  - onlyId);
								var qShips2;
								var qShips3;
								checkQuantityShips = 2;
								alert("Its two Deck Ship!!! " + qShips);
									if(grandArrayShipNum.indexOf(qShips) > -1){
										qShips2 = qShips + (qShips - nearId);
										checkQuantityShips = 3;
										alert("Its three Deck Ship!!! " + qShips2);
											if (grandArrayShipNum.indexOf(qShips2) > -1) {
												qShips3 = qShips2 + (qShips2 - qShips);
												checkQuantityShips = 4;
												alert("Its Four Deck Ship!!! " + qShips3);
											}
												if (grandArrayShipNum.indexOf(qShips3) > -1) {
													alert("omg 5 Deck!!! " + qShips3);
													checkQuantityShips = 5;
												}
									}
							}
					}
				}
		}
		/*добавить условие, что при поподании в here is ships!!!
		проверяются поля рядом и при совпадении grandArrayShip
		считается палубы корабле, else остаётся без изменений
		*/

				// запись в массив deck 
			if (checkTest == 0) {	
				for(position = 0;position < oneDeckShip.length; position++)
				{
						deck[deck.length] = arrayShip.indexOf("id" + oneDeckShip[position]);
				}
			}
			
			if (checkField === 1) 
			{
						alert("new code");
						var overlap = new Array();
						var overlap2 = new Array();

						// не работает
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

				if (checkQuantityShips == 1) {
						oneDeck --;
						document.getElementById('oneDeck').innerHTML = oneDeck;
				}
				if (checkQuantityShips == 2) {
						twoDeck --;
						document.getElementById('twoDeck').innerHTML = twoDeck;
						oneDeck ++;
						document.getElementById('oneDeck').innerHTML = oneDeck;
				}
				if (checkQuantityShips == 3) {
						threeDeck --;
						document.getElementById('threeDeck').innerHTML = threeDeck;
						twoDeck ++;
						document.getElementById('twoDeck').innerHTML = twoDeck;
				}
				if (checkQuantityShips == 4) {
						fourDeck --;
						document.getElementById('fourDeck').innerHTML = fourDeck;
						threeDeck ++;
						document.getElementById('threeDeck').innerHTML = threeDeck;
				}

				if(checkQuantityShips == 5){
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
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

var fleatEnemy = new Array();
var newFleatEnemy = new Array();
var table2WrongId = new Array();

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
	var clearWrongId = true;

	for (;grandArrayShipNum.length < 21; arrayShip.length + 1)
	{
			
			if(arrayShip.indexOf(id) > -1){
					alert("alarm!");
					return arrayShip;
			}
			if ((oneDeck + twoDeck + threeDeck + fourDeck) == 0){
				alert("Game Start!");
				return arrayShip;
			}

			var onlyId = id.replace(/[^+\d]/g, '') - 0;

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
					if (oneDeck < 1) {
						alert("У вас лимит 1 палубных кораблей!");
						oneDeckShip = oneDeckShip.slice([0],[oneDeckShip.length - 4]);
						return arrayShip;
					}
					grandArrayShipNum = [].concat(...grandArrayShip);
					posibleId = [];
					/*for(position = 0;position < 4; position++)
					{
						deck[deck.length] = arrayShip.indexOf("id" + oneDeckShip[position]);
						checkTest = 1;
					}*/
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


 			if (arrayShip.length > 0){
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
					//alert(posibleId + "   "+ resetID);
				}
			}

		// если новый корабль не в posibleId, то запись arrayShip в grandArrayShip и сброс arrayShip
		if (posibleId.indexOf(onlyId) == -1) {
			arrayShip = [];
			if (grandArrayShip.length < 100) {
			grandArrayShip[grandArrayShip.length] = arrayShip;
			}
		}
			
		//поиск текущего ID в значениях массива grandPosibleIdNum
		if (grandPosibleIdNum.indexOf(onlyId) > -1) {
			nearIdPosition = [];
			nearIdPosition[nearIdPosition.length] = onlyId + 1;
			nearIdPosition[nearIdPosition.length] = onlyId + 10;
			nearIdPosition[nearIdPosition.length] = onlyId - 1;
			nearIdPosition[nearIdPosition.length] = onlyId - 10;
			// alert("here is ships!!! " + nearIdPosition); //рядом стоит корабль
			// делаем из многомерного массива grandArrayShip одномерный grandArrayShipNum c типом num
 			grandArrayShipNum = [].concat(...grandArrayShip);
			for (var i = 0; i < grandArrayShipNum.length; i++) {
				grandArrayShipNum[i] = grandArrayShipNum[i].replace(/[^+\d]/g, '') - 0;
			}

				for (checkPoint = 0; checkPoint < nearIdPosition.length; checkPoint++) {

					for (cP = 0; cP < grandArrayShipNum.length; cP++) {
						//alert((grandArrayShipNum[cP] + "").replace(/[^+\d]/g, '') - 0);
						var nearId = (grandArrayShipNum[cP] + "").replace(/[^+\d]/g, '') - 0;
							if (nearId == nearIdPosition[checkPoint]) {
								var qShips = nearId + (nearId  - onlyId);
								var qShips2;
								var qShips3;
								checkQuantityShips = 2;
									if (twoDeck < 1) {
										alert("У вас лимит 2 палубных кораблей!");
										oneDeckShip = oneDeckShip.slice([0],[oneDeckShip.length - 4]);
										return arrayShip;
									}
									if(grandArrayShipNum.indexOf(qShips) > -1){
										qShips2 = qShips + (qShips - nearId);
										checkQuantityShips = 3;
											if (threeDeck < 1) {
												alert("У вас лимит 3 палубных кораблей!");
												oneDeckShip = oneDeckShip.slice([0],[oneDeckShip.length - 4]);
												return arrayShip;
											}
										//alert("Its three Deck Ship!!! " + qShips2);
											if (grandArrayShipNum.indexOf(qShips2) > -1) {
												qShips3 = qShips2 + (qShips2 - qShips);
												checkQuantityShips = 4;
													if (fourDeck < 1) {
														alert("У вас лимит 4 палубных кораблей!");
														oneDeckShip = oneDeckShip.slice([0],[oneDeckShip.length - 4]);
														return arrayShip;
													}
											}
												if (grandArrayShipNum.indexOf(qShips3) > -1) {
													clearWrongId = false;
													alert("omg 5 Deck!!! " + qShips3);
													checkQuantityShips = 5;
													oneDeckShip = oneDeckShip.slice([0],[oneDeckShip.length - 4]);
													return arrayShip;
												}
									}
							}
					}
				}
		}
		 	if ((oneDeck + twoDeck + threeDeck + fourDeck) == 1){
				grandArrayShipNum[grandArrayShipNum.length] = id;
			}
		//раскрытие двухмерного массива grandPosibleId[] в одномерный grandPosibleIdNum
		grandPosibleId[grandPosibleId.length] = posibleId;
		grandPosibleIdNum = [].concat(...grandPosibleId);
		// проверка поз-ции нового корабля, нету ли его рядом со старым
			if(clearWrongId) // при условии что onlyId в правильном положении
			{
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

				if(wrongId.indexOf(onlyId) > -1){
					alert("Dont do This!");
					oneDeckShip = oneDeckShip.slice([0],[oneDeckShip.length - 4]);
					return arrayShip;
				}
			}
		/*
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
			}*/

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
						oneDeckShip = oneDeckShip.slice([0],[oneDeckShip.length - 4]);
						return arrayShip;
				}

			changeEl.style.background = "url(img/ships.jpg) center";
			changeEl.style.backgroundSize = "100% 100%";
			arrayShip[arrayShip.length] = id;
			if (grandArrayShipNum.length > 10) {
				if (fleatEnemy.length < 100) {
					generateEnemyField();
				}
			createPosibleId(randomInteger(fleatEnemy));
			}
				if((oneDeck + twoDeck + threeDeck + fourDeck) == 0){
					table1.style.opacity = "1";
				}
				console.log(grandArrayShip + '\n' + grandPosibleId + '\n' + grandArrayShipNum + '\n' + grandPosibleIdNum + '\n' + "..............."+ '\n');
			return arrayShip;
	}
}
		function generateEnemyField() {
			for (let i = 1; i <= 100; i++) {
   				fleatEnemy.push(i);
			}
		return fleatEnemy;
		}

		function coinToss() {
    		return Math.floor(Math.random() * 2);
		}
		function randomInteger(fleatEnemy) {
  		// случайное число
  					do{
  						var rand = fleatEnemy[Math.floor(Math.random() * fleatEnemy.length)];
  					}while(fleatEnemy[rand] == undefined);
  					//Math.floor(Math.random() * (fleatEnemy.length));
  					if (Math.floor(Math.random() * 2)) {
  						var randomizerDirection = 1;
  					}else{randomizerDirection = 10; }
  					
  					newFleatEnemy[newFleatEnemy.length] = rand;
  					newFleatEnemy[newFleatEnemy.length] = ((rand + randomizerDirection) != undefined) ? rand + randomizerDirection :
  					((rand - randomizerDirection) != undefined) ? (rand - randomizerDirection) :
  					-1;
  					alert(newFleatEnemy);

  					if((rand + randomizerDirection) != undefined){
  					newFleatEnemy[newFleatEnemy.length] = rand + randomizerDirection;
  					}else if((rand - randomizerDirection) != undefined){
  						newFleatEnemy[newFleatEnemy.length] = rand - randomizerDirection;
  					}
 					alert(newFleatEnemy);
  				return Math.floor(rand);
  				ceil — округляет все в большую сторону,
				floor — в меньшую,
				round — меньше 0.5 — в меньшую, больше 0.5 — в большую.
		}

		function createPosibleId(rand){	
				// Обработка края поля и добавления WrongId
				if (((rand%10)!=0)&&((rand%10)!=1)) {
					if(rand > 11){
						table2WrongId[table2WrongId.length] = rand - 11;
					}
					if(rand > 9){
						table2WrongId[table2WrongId.length] = rand - 9;
					}
					if(rand < 92){
						table2WrongId[table2WrongId.length] = rand - 0 + 9;
					}
					if(rand < 89){
						table2WrongId[table2WrongId.length] = rand -0 + 11;
					}
				}
				if ((rand%10)==0) {
					if(rand > 11){
						table2WrongId[table2WrongId.length] = rand - 11;
					}
					if(rand < 92){
						table2WrongId[table2WrongId.length] = rand - 0 + 9;
					}
				}
				if ((rand%10)==1) {
					if(rand > 9){
						table2WrongId[table2WrongId.length] = rand - 9;
					}
					if(rand < 89){
						table2WrongId[table2WrongId.length] = rand -0 + 11;
					}
				}
		alert(rand + "  " +table2WrongId);
		// Удаление эл-тов из массива-таблицы врага
		delete fleatEnemy [rand - 1];//удалить тек. сгонерированны id
			for (let i = 0; i < table2WrongId.length; i++) {
				if (fleatEnemy.includes(table2WrongId[i])){
					delete fleatEnemy[fleatEnemy.indexOf(table2WrongId[i])];
					//newFleatEnemy[newFleatEnemy.length] = table2WrongId[i];
				}
				alert(rand);
			}
		}


// функция обстрела кораблей
function shot(id){
	var equivalentId = id.replace(/[^+\d]/g, '') - 100;
	alert(equivalentId);
	if(grandArrayShipNum.length < 20){

		return grandArrayShipNum.length;
	}else{
			var element = document.getElementById(id);
			if(grandArrayShipNum.indexOf("id"+equivalentId) > -1)
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

//Генерация поля с кораблями бота

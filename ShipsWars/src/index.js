import EnemyField from './enemyField';

let cellArray = [];

let EnemyFieldEl = new EnemyField();
EnemyFieldEl.blockField();

for (let i = 1; i <= 100; i++) {
    cellArray.push(document.getElementById('id'+i));
}

cellArray.forEach( function(element, index) {
    element.addEventListener("click", function() {
        clickCell(index)
    });
});

/* for (let index = 0; index < cellArray.length; index++) {
    cellArray[index].addEventListener("click", function() {clickCell(index)});
} */

function clickCell(index) {
    // добавить индекс в массив используемых ячеек / от туда формируется массив не допустимых для постановки кораблей ячеек
    cellArray[index].style.background = "url(img/ships.jpg) center";
    cellArray[index].style.backgroundSize = "100% 100%";
}
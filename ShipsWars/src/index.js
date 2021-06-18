import EnemyField from './enemyField';

let cellArray = [];
let activeCells = [];
let invalidCells = [];

let EnemyFieldEl = new EnemyField();
EnemyFieldEl.blockField();

for (let i = 1; i <= 100; i++) {
    cellArray.push(document.getElementById('id'+i));
}

cellArray.forEach( function(element, index) {
    element.addEventListener("click", function() {
        clickCell(index);
    });
});

function clickCell(index) {
    // добавить индекс в массив используемых ячеек / от туда формируется массив не допустимых для постановки кораблей ячеек
    if(!invalidCells.includes(index)){
        addToActiveCells(index);
        cellArray[index].style.background = "url(img/ships.jpg) center";
        cellArray[index].style.backgroundSize = "100% 100%";
    } else {
        alert('Invalid Cell')
    }
}

function addToActiveCells(index) {
    activeCells.push(index);
    console.log(activeCells);
    changeInvalidCells(index);
}

function changeInvalidCells(index) {
    const calcInvalidCells = [-11, -9, 9, 11];
    const calcInvalidCellsLeft = [-9, 11];
    const calcInvalidCellsRight = [-11, 9];

    // вынести index % 10 в отдельную константу
    // проверять что  index + calcInvalidCellsLeft[i] не больше 99 и не меньше 0. Для чистоты массива

        if(!(index % 10)) {
            for (let i = 0; i < 2; i++) {
                invalidCells.push(index + calcInvalidCellsLeft[i]);
            }
        } else if((index % 10) === 9) {
            for (let i = 0; i < 2; i++) {
                invalidCells.push(index + calcInvalidCellsRight[i]);
            }
        } else {
            for (let i = 0; i < 4; i++) {
                invalidCells.push(index + calcInvalidCells[i]);
            }
        }

    console.log(invalidCells);
}
import EnemyField from './enemyField';

let cellArray = [];
let activeCells = [];
let invalidCells = [];
let neighborsCells = [];
const neighborsCellsArray = [];
let shipsCount = {
    'singleDeck': 4,
    'doubleDeck': 3,
    'threeDeck': 2,
    'fourDeck': 1
};

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
    // console.log(activeCells);
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
    checkShipsCount(index);
    // console.log(invalidCells);
}

function checkShipsCount(index) {
    const calcNeighborsCells = [-10, -1, 1, 10];

    neighborsCells = [];
    for (let i = 0; i < 4; i++) {
        neighborsCells.push(index + calcNeighborsCells[i]);
    }

    // проверить есть ли рядом активное поле в neighborsCellsArray и выдаём направление
    // если есть определяем направление

    let directionString = '';
    function isNeighborsCells ( element, index1 ) {
        let direction = -1;
        for (let i = 0; i < element?.neighborsCells.length;i++) {
            if (direction === -1) {
                direction = element?.neighborsCells[i].indexOf(index);
            }
        }
        if (direction === 1 || direction === 2) {
            directionString = 'horizontal';
            neighborsCellsArray[index1].neighborsCells.push(neighborsCells);
        } else if (direction === 0 || direction === 3) {
            directionString = 'vertical';
            neighborsCellsArray[index1].neighborsCells.push(neighborsCells);
        }

        return directionString !== '';
    }

    if (neighborsCellsArray.some(isNeighborsCells)) {
        return true;
    } else {
        neighborsCellsArray.push({'neighborsCells': [neighborsCells]});
    }

    console.log(neighborsCellsArray);


    // для первого запуска
    if (!neighborsCellsArray.length) {
        neighborsCellsArray.push({'neighborsCells': [neighborsCells]});
    }
}

export default class EnemyField {
    enemyFieldElement = document.getElementById('tableShot');

    blockField() {
        this.enemyFieldElement.style.opacity = "0.4";
    };
}
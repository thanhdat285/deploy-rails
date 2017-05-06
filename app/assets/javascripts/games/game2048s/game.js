var Game2048s = function() {
  cells_html = [];
  cells = [[0,0,0,0], [0,0,0,0], [0,0,0,0], [0,0,0,0]];
  moveDone = true;
  score = 0;

  moveNotChange = '';

  this.start = function() {
    initCells();
    randomNumber2();
    addKeyEventListener();
  }

  function initCells() {
    for(var i = 0; i < 4; i++) {
      var rows = [];
      for(var j = 0; j < 4; j++) {
        rows.push($('#box_game > .cell[data-position="' + i + '-' + j + '"]'));
      }
      cells_html.push(rows);
    }
  }

  function randomNumber2() {
    var cells_to_random = [];
    for(var r = 0; r < 4; r++) {
      for(var c = 0; c < 4; c++) {
        if(emptyCell(r, c)) {
          cells_to_random.push({x: r, y: c});
        }
      }
    }
    var len = cells_to_random.length;
    if(len == 0) {
      moveDone = true;
      return;
    }

    var random = parseInt(Math.random()*len);
    var x = cells_to_random[random].x;
    var y = cells_to_random[random].y;
    cells[x][y] = 2;

    var size = 2;
    cells_html[x][y].addClass('cell-appear');

    var appear = setInterval(function() {
      size += 8;
      cells_html[x][y].css('background-size', size + 'px ' + size + 'px');
      if(size >= 98) {
        clearInterval(appear);
        cells_html[x][y].removeAttr('style');
        cells_html[x][y].attr('class', 'cell cell-2');
        score += 2;
        moveDone = true;
      }
    }, 10);
  }

  function emptyCell(x, y) {
    return cells[x][y] == 0 ? true : false;
  }

  function addKeyEventListener() {
    $(window).keydown(function(keyEvent) {
      if(moveDone) {
        if(keyEvent.keyCode == 37) { // key left
          moveDone = false;
          moveLeft();
        } else if(keyEvent.keyCode == 38) { // key up
          moveDone = false;
          moveUp();
        } else if(keyEvent.keyCode == 39) { // key right
          moveDone = false;
          moveRight();
        } else if(keyEvent.keyCode == 40) { // key down
          moveDone = false;
          moveDown();
        }
      }
    })
  }

  function moveLeft() {
    var change = false;
    for(var row = 0; row < 4; row++) {
      var max_col = 3;
      for(var col = 0; col < max_col; col++) {
        if(cells[row][col] == 0) {
          shiftLeft(row, col);
          col-=2;
          max_col--;
        } else if(cells[row][col] == cells[row][col+1]) {
          cells[row][col] *= 2;
          score += cells[row][col];
          change = true;
          shiftLeft(row, col+1);
          max_col--;
        }
      }
    }
    if(!change) {
      if(moveNotChange == 'vertical') gameOver();
      else moveNotChange = 'horizontal';
    } else {
      moveNotChange = '';
    }
    reDraw();
    randomNumber2();
  }

  function moveUp() {
    var change = false;
    for(var col = 0; col < 4; col++) {
      var max_row = 3;
      for(var row = 0; row < max_row; row++) {
        if(row < 0) continue;
        if(cells[row][col] == 0) {
          shiftUp(row, col);
          row-=2;
          max_row--;
        } else if(cells[row][col] == cells[row+1][col]) {
          cells[row][col] *= 2;
          score += cells[row][col];
          change = true;
          shiftUp(row+1, col);
          max_row--;
        }
      }
    }
    if(!change) {
      if(moveNotChange == 'horizontal') gameOver();
      else moveNotChange = 'vertical';
    } else {
      moveNotChange = '';
    }
    reDraw();
    randomNumber2();
  }

  function moveRight() {
    var change = false;
    for(var row = 0; row < 4; row++) {
      var min_col = 0;
      for(var col = 3; col > min_col; col--) {
        if(cells[row][col] == 0) {
          shiftRight(row, col);
          col+=2;
          min_col++;
        } else if(cells[row][col] == cells[row][col-1]) {
          cells[row][col] *= 2;
          score += cells[row][col];
          change = true;
          shiftRight(row, col-1);
          min_col++;
        }
      }
    }
    if(!change) {
      if(moveNotChange == 'vertical') gameOver();
      moveNotChange = 'horizontal';
    } else {
      moveNotChange = '';
    }
    reDraw();
    randomNumber2();
  }

  function moveDown() {
    var change = false;
    for(var col = 0; col < 4; col++) {
      var min_row = 0;
      for(var row = 3; row > min_row; row--) {
        if(row > 3) continue;
        if(cells[row][col] == 0) {
          shiftDown(row, col);
          row+=2;
          min_row++;
        } else if(cells[row][col] == cells[row-1][col]) {
          cells[row][col] *= 2;
          score += cells[row][col];
          change = true;
          shiftDown(row-1, col);
          min_row++;
        }
      }
    }
    if(!change) {
      if(moveNotChange == 'horizontal') gameOver();
      else moveNotChange = 'vertical';
    } else {
      moveNotChange = '';
    }
    reDraw();
    randomNumber2();
  }

  function shiftLeft(x, y) {
    for(var col = y; col < 3; col++) {
      cells[x][col] = cells[x][col+1];
    }
    cells[x][3] = 0;
  }

  function shiftRight(x, y) {
    for(var col = y; col > 0; col--) {
      cells[x][col] = cells[x][col-1];
    }
    cells[x][0] = 0;
  }

  function shiftUp(x, y) {
    for(var row = x; row < 3; row++) {
      cells[row][y] = cells[row+1][y];
    }
    cells[3][y] = 0;
  }

  function shiftDown(x, y) {
    for(var row = x; row > 0; row--) {
      cells[row][y] = cells[row-1][y];
    }
    cells[0][y] = 0;
  }

  function reDraw() {
    for(var x = 0; x < 4; x++){
      for(var y = 0; y < 4; y++) {
        cells_html[x][y].attr('class', 'cell cell-' + cells[x][y]);
      }
    }
    $('#score').html(score);
  }

  function gameOver() {
    console.log('gameOver');
  }
}

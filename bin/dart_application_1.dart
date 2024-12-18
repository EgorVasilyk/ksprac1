import 'dart:io';

void main() {
  int? boardSize = getBoardSize();
  if (boardSize == null) {
    return;
  }

  List<List<String>> gameBoard = List.generate(boardSize, (i) => List.filled(boardSize, ' '));

  String currentPlayer = 'X';

  bool gameOver = false;

  while (!gameOver) {
    printGameBoard(gameBoard);

    print('Ход игрока $currentPlayer. Введите позицию (номер строки, номер столбца):');

    int? row = getCoordinate("Строки", boardSize);
    if (row == null) {
      continue;
    }

    int? col = getCoordinate("Столбца", boardSize);
    if (col == null) {
      continue;
    }

    if (isValidMove(gameBoard, [row, col])) {
      gameBoard[row - 1][col - 1] = currentPlayer;

      gameOver = checkGameOver(gameBoard);
      if (gameOver) {
        break;
      }

      currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
    } else {
      print('Неверный ход. Попробуйте снова.');
    }
  }

  printGameBoard(gameBoard);
  if (gameOver) {
    print('Победа игрока $currentPlayer!');
  } else {
    print('Ничья!');
  }
}

int? getBoardSize() {
  print('Введите размер игрового поля (от 3 до 9):');
  String? input = stdin.readLineSync();
  if (input == null) {
    print('Ввод не получен. Попробуйте еще раз.');
    return null;
  }

  int? size;
  try {
    size = int.parse(input.trim());
  } catch (e) {
    print('Неверный ввод. Пожалуйста, введите число.');
    return null;
  }

  if (size < 3 || size > 9) {
    print('Неверный ввод. Размер поля должен быть от 3 до 9.');
    return null;
  }

  return size;
}

int? getCoordinate(String type, int boardSize) {
  print('Введите номер $type (от 1 до $boardSize):');
  String? input = stdin.readLineSync();
  if (input == null) {
    print('Ввод не получен. Попробуйте еще раз.');
    return null;
  }

  int? coordinate;
  try {
    coordinate = int.parse(input.trim());
  } catch (e) {
    print('Неверный ввод. Пожалуйста, введите число.');
    return null;
  }

  if (coordinate < 1 || coordinate > boardSize) {
    print('Неверный ввод. Пожалуйста, введите число от 1 до $boardSize.');
    return null;
  }

  return coordinate;
}

bool isValidMove(List<List<String>> board, List<int> position) {
  return position[0] >= 1 && position[0] <= board.length &&
      position[1] >= 1 && position[1] <= board.length &&
      board[position[0] - 1][position[1] - 1] == ' ';
}

  void printGameBoard(List<List<String>> board) {
    int size = board.length;

    print('---------');
    for (int i = 0; i < size; i++) {
      stdout.write('|');
      for (int j = 0; j < size; j++) {
        stdout.write(' ${board[i][j]} ');
        if (j < size) {
          stdout.write('|');
        }
      }
      print('');
      stdout.write('---------');
      print('');
    }
  }


bool checkGameOver(List<List<String>> board) {
  int size = board.length;

  for (int i = 0; i < size; i++) {
    if (board[i][0] != ' ' &&
        board[i][0] == board[i][1] &&
        board[i][0] == board[i][2]) {
      return true;
    }
  }

  for (int i = 0; i < size; i++) {
    if (board[0][i] != ' ' &&
        board[0][i] == board[1][i] &&
        board[0][i] == board[2][i]) {
      return true;
    }
  }

  if (board[0][0] != ' ' &&
      board[0][0] == board[1][1] &&
      board[0][0] == board[2][2]) {
    return true;
  }
  if (board[0][size - 1] != ' ' &&
      board[0][size - 1] == board[1][size - 2] &&
      board[0][size - 1] == board[2][size - 3]) {
    return true;
  }

  for (int i = 0; i < size; i++) {
    for (int j = 0; j < size; j++) {
      if (board[i][j] == ' ') {
        return false;
      }
    }
  }

  return true;
}
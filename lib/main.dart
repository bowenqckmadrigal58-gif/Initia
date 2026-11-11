import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'package:stockfish/stockfish.dart';

void main() => runApp(const InitiaApp());

class InitiaApp extends StatelessWidget {
  const InitiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Initia Chess',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF121212),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFFF2A54),
          surface: Color(0xFF0A1128),
        ),
      ),
      home: const ChessGameScreen(),
    );
  }
}

class ChessGameScreen extends StatefulWidget {
  const ChessGameScreen({super.key});

  @override
  State<ChessGameScreen> createState() => _ChessGameScreenState();
}

class _ChessGameScreenState extends State<ChessGameScreen> {
  ChessBoardController controller = ChessBoardController();
  late Stockfish stockfish;

  @override
  void initState() {
    super.initState();
    stockfish = Stockfish();
    stockfish.stdin = 'uci\n';
    stockfish.stdin = 'setoption name Skill Level value 20\n';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'I N I T I A',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 4),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: ChessBoard(
                controller: controller,
                boardColor: BoardColor.darkBrown,
                boardOrientation: PlayerColor.white,
                onMove: () {
                  stockfish.stdin = 'position fen ${controller.getFen()}\n';
                  stockfish.stdin = 'go movetime 1000\n';
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF2A54),
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () => controller.resetBoard(),
              child: const Text(
                'بازی جدید',
                style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Gamestate 
{
  final List<String> board;
  final bool isX;
  final String winner;
  final int xWinTime;
  final int oWinTime;
  final int drawTime;
  final int? winStart;
  final int? winEnd;

  Gamestate({
    required this.board, 
  required this.isX,
  this.winner='', 
  required this.xWinTime, 
  required this.oWinTime,
  required this.drawTime,
  this.winStart,
  this.winEnd
  });

Gamestate copyWith({List<String>? board, bool? isX, String? winner, int? xWinTime, int? oWinTime, int? drawTime, int? winStart, int? winEnd})
{
  return Gamestate(
    board: board ?? this.board, 
    isX: isX ?? this.isX,
    winner: winner ?? this.winner ,
    xWinTime: xWinTime ?? this.xWinTime,
    oWinTime: oWinTime ?? this.oWinTime,
    drawTime: drawTime ?? this.drawTime,
    winStart: winStart ?? this.winStart,
    winEnd: winEnd ?? this.winEnd
    );
}
}

class GameNotifer extends Notifier<Gamestate>
{
  @override
  Gamestate build() {
    loadscore();
    return Gamestate(board: List.filled(9, ""), isX: true,xWinTime: 0,oWinTime: 0, drawTime: 0, winStart: null, winEnd: null);
  }


List<dynamic> _checkWinner(List<String>currentBoard)
{
  const winningLines=[
    [0,1,2], [3,4,5], [6,7,8],
    [0,3,6], [1,4,7], [2,5,8],
    [0,4,8], [2,4,6]
  ];
  for (var line in winningLines)
  {
    String a=currentBoard[line[0]];
    String b=currentBoard[line[1]];
    String c=currentBoard[line[2]];
    if (a!='' && a==b  && a==c) 
    {
      
      return [a,line[0],line[2]];
    }
  }
  if (!currentBoard.contains('')) return ["Hòa"];
  return [];
}
void reset()
{
  state=Gamestate(board: List.filled(9, ''), isX: true, xWinTime: state.xWinTime, oWinTime: state.oWinTime, drawTime: state.drawTime);
}

void totalReset()
{
   state=Gamestate(board: List.filled(9, ''), isX: true,xWinTime: 0,oWinTime: 0, drawTime: 0);
   savescore(0, 0, 0);
}

  void play(int index)
  {
    if (state.board[index]!='' || state.winner!='') return;
    final newBoard=[...state.board];
    newBoard[index]=state.isX ? "X" : "O";
    List<dynamic> winList=_checkWinner(newBoard);
  final newWinner=(winList.isNotEmpty) ? winList[0] : null;
    int newxwintime=newWinner=='X' ? state.xWinTime+1 : state.xWinTime;
    int newowintime=newWinner=='O' ? state.oWinTime+1 : state.oWinTime;
     int newDrawtime=newWinner=="Hòa" ? state.drawTime+1 : state.drawTime;
     int? newStart=(winList.length>1) ? winList[1] : null;
     int? newEnd=(winList.length>1) ? winList[2] : null;
    state=state.copyWith(
      board: newBoard,
      isX: !state.isX,
      winner: newWinner,
      xWinTime: newxwintime,
      oWinTime: newowintime,
      drawTime: newDrawtime,
     winStart: newStart,
      winEnd: newEnd
    );
    savescore(newxwintime, newowintime, newDrawtime);
  }
  Future<void>savescore(int x, int o, int draw) async{
   final prefs=await SharedPreferences.getInstance();
   prefs.setInt("X", x);
   prefs.setInt("O", o);
   prefs.setInt("draw", draw);
  }
  Future<void>loadscore() async{
    final prefs=await SharedPreferences.getInstance();
    state=state.copyWith(
      board: state.board,
      isX: state.isX,
      winner: state.winner,
      xWinTime: prefs.getInt("X") ?? 0,
      oWinTime: prefs.getInt("O") ?? 0,
      drawTime: prefs.getInt("draw") ?? 0
    );
  }
}

final gameProvider=NotifierProvider<GameNotifer, Gamestate>((){
  return GameNotifer();
});
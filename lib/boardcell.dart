import 'package:flutter/material.dart';
import 'gamestate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'themeprovider.dart';

class Boardcell extends ConsumerWidget {
  Boardcell({super.key, required this.index});
  final int index;

  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cellValue=ref.watch(gameProvider.select((state)=>state.board[index]));
    final currTheme=ref.watch(themeNotifierProvider);
    int row=index~/3;
    int col=index%3;
    return  InkWell(
                    onTap: (){
                      ref.read(gameProvider.notifier).play(index);
                    },
                    child: Container(
                     decoration:  BoxDecoration(
                      border: currTheme==ThemeMode.light ? 
                      Border(
                        top: row>0 ? const BorderSide(color: Colors.black, width: 3) : BorderSide.none,
                        bottom: row<2 ? const BorderSide(color: Colors.black, width: 3) : BorderSide.none,
                        left: col>0 ? const BorderSide(color: Colors.black, width: 3) : BorderSide.none,
                         right: col<2 ? const BorderSide(color: Colors.black,width: 3) : BorderSide.none,
                        ) 
                      :
                      Border(
                        top: row>0 ? const BorderSide(color: Colors.white,width: 3) : BorderSide.none,
                        bottom: row<2 ? const BorderSide(color: Colors.white,width: 3) : BorderSide.none,
                        left: col>0 ? const BorderSide(color: Colors.white,width: 3) : BorderSide.none,
                         right: col<2 ? const BorderSide(color: Colors.black,width: 3) : BorderSide.none,
                      ),
                      ),
                      child: Center(child: Text(cellValue
                      , style: TextStyle(
                        fontSize: 50,
                        color:cellValue=="X" ? Colors.red : Colors.blue
                      ),
                      )),
                    ),
                  );
  }

}

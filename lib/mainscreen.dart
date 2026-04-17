import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/gamestate.dart';
import 'themeprovider.dart';
import 'boardcell.dart';
import 'painter.dart';

class Mainscreen extends ConsumerStatefulWidget {
  const Mainscreen({super.key});

  @override
  ConsumerState<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends ConsumerState<Mainscreen> {


  @override
  Widget build(BuildContext context) {
      final int? winStart=ref.watch((gameProvider).select((state)=>state.winStart));
      final int? winEnd=ref.watch((gameProvider).select((state)=>state.winEnd));
       final winner=ref.watch(gameProvider.select((state)=>state.winner));
       final isX=ref.watch(gameProvider.select((state)=>state.isX));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){ref.read(themeNotifierProvider.notifier).changeTheme();}, 
          icon: ref.watch(themeNotifierProvider)==ThemeMode.light ? Icon(CupertinoIcons.sun_max) : Icon(CupertinoIcons.moon) 
          ),
        title: ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (Rect bounds){
            return LinearGradient(
              colors: [Colors.blue, Colors.red],
            ).createShader(bounds);
          },
          child: Text("Tic Tac Toe", style: TextStyle(fontSize: 35,fontWeight: .bold),)),
          actions: [
          if (winner!='')  IconButton(
              onPressed: (){ref.read(gameProvider.notifier).totalReset();},
              icon: Icon(CupertinoIcons.refresh_thick),
            )
          ],
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: .center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Column(
                  children: [
                    Text("X", style: TextStyle(color:Colors.red, fontWeight: .bold, fontSize: 25),),
                    Text("${ref.watch(gameProvider.select((state)=>state.xWinTime))} wins", style: TextStyle(color:Colors.red, fontWeight: .bold, fontSize: 20),),
                  ],
                ),
                 Column(
                  children: [
                    Icon(CupertinoIcons.equal_circle, size: 25,),
                        SizedBox(height: 10,),
                    Text("${ref.watch(gameProvider.select((state)=>state.drawTime))} draws", style: TextStyle(fontWeight: .bold, fontSize: 20),)
                  ],
                ),
                Column(
                  children: [
                    Text("O",style: TextStyle(color:Colors.blue, fontWeight: .bold, fontSize: 25),),
                
                    Text("${ref.watch(gameProvider.select((state)=>state.oWinTime))} wins", style: TextStyle(color:Colors.blue, fontWeight: .bold, fontSize: 20),),
                  ],
                )
              ],
            ),
          ),
        Consumer(builder: (context,ref,child)
        {     
          return  winner=='' ? (isX ? Text("Lượt người chơi X", style: TextStyle(
            color: Colors.red,
            fontWeight: .bold,
            fontSize: 30
          ),) 
          : Text("Lượt người chơi O", style: TextStyle(
            color: Colors.blue,
            fontWeight: .bold,
            fontSize: 30
          ),)) : Text(
          winner!="Hòa" ? "Người chơi $winner thắng" : "Hòa",
            style: TextStyle(
              color: Colors.amber,
              fontWeight: .bold,
              fontSize: 30
            ), 
          );
        }),
             Padding(
               padding: const EdgeInsets.all(20),
               child: CustomPaint(
                foregroundPainter: (winStart!=null && winEnd!=null) ? WinningPainter(winStart, winEnd) : null,
                 child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                  itemCount: 9,
                   itemBuilder: (BuildContext context, int index){
                    return Boardcell(index: index);
                  }),
               ),
             ),
             Center(child: TextButton(

              onPressed: (){ref.read(gameProvider.notifier).reset();}, 
              child: ShaderMask(
                blendMode: .srcIn,
                shaderCallback: (bounds) {
                  return LinearGradient(
                    colors: [Colors.blue, Colors.red] 
                  ).createShader(bounds);
                },
                child: Text("Reset lại bảng điểm", 
                style: TextStyle(fontSize: 30),
                ),
              ),
              ))
          
        ],
      ),
    );
  }
}
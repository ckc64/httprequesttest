import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class DashBoardChart extends StatefulWidget {
  @override
  _DashBoardChartState createState() => _DashBoardChartState();
}

class _DashBoardChartState extends State<DashBoardChart> 
with SingleTickerProviderStateMixin {
    Animation <int> animation;
    AnimationController animationController;

_countCasesController(int begin, int end){
      animationController = AnimationController(duration: Duration(seconds: 2),vsync:this);
    animation = IntTween(begin: 0, end:end).animate(
      CurvedAnimation(parent:animationController,curve: Curves.easeInOut))..addListener((){
        setState(() {
          
        });
      });
    animationController.forward();
}
    @override
  void initState() {
    super.initState();
    _countCasesController(0, 12345);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      body: StaggeredGridView.count(
        physics: BouncingScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        padding: EdgeInsets.symmetric(horizontal:16.0, vertical:8.0),
        children: <Widget>[
          Text(animation.value.toString()),
          myItems(
      
              txtTitle: "CONFIRMED CASES",
              txtTitleFontSize: 30,
              colorTitle: Colors.black,
              countsPH: animation.value.toString(),
              countsGlobal: "1000000000"

          ),
          myItems(
            txtTitle: "RECOVERED",
              txtTitleFontSize: 25,
              colorTitle: Colors.black,
              countsPH: "50000",
              countsGlobal: "1000000000"
          ),
           myItems(
            txtTitle: "DEATHS",
              txtTitleFontSize: 25,
              colorTitle: Colors.black,
              countsPH: "50000",
              countsGlobal: "1000000000"
          ),
          // myItems(Icons.people,"Death","12414","1412",Colors.green),
          // myItems(Icons.people,"Trends","12412","124124",Colors.green),
          // myItems(Icons.people,"Trends","12412","1241241",Colors.green)
        ],
        staggeredTiles: [
          StaggeredTile.extent(2, 20),
          StaggeredTile.extent(2, 150),
          StaggeredTile.extent(1, 150),
          StaggeredTile.extent(1, 150),
          // StaggeredTile.extent(2, 250),
          // StaggeredTile.extent(2, 250),
        ],
      ),
    );
  }

  Material myItems({
  String txtTitle,
  double txtTitleFontSize,
  Color colorTitle,
  String countsPH,
  String countsGlobal,

  }){
      return Material(
        color:Colors.white,
        elevation: 14.0,
        shadowColor: Colors.black,
        borderRadius: BorderRadius.circular(24.0),
        child: Container(
          
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                txtTitle,
                style: TextStyle(
                  color: colorTitle,
                  fontSize: txtTitleFontSize,
                ),
              ),
              Text(
                countsPH,
                style: TextStyle(
                  color: colorTitle,
                  fontSize: 45,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text("Global",
                style: TextStyle(
                  color: colorTitle,
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(countsGlobal,
               style: TextStyle(
                  color: colorTitle,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              )
            ],
          ),
        )
    );
  }
}
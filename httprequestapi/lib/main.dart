import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:httprequestapi/ConfirmedCases.dart';
import 'package:httprequestapi/Services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
    primaryColor: Colors.red,
      ),
      darkTheme: ThemeData(
    brightness: Brightness.dark,
  ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class Gender{
  int id;
  String name;

  Gender(this.id,this.name);

  static List<Gender>getGenders(){
    return<Gender>[
      Gender(1, "All Gender"),
      Gender(2, "Male"),
      Gender(3, "Female")
    ];
  }
}

class Status{
  int id;
  String name;

 Status(this.id,this.name);

  static List<Status>getStatus(){
    return<Status>[
      Status(1, "All Status"),
      Status(2, "Admitted"),
      Status(3, "Recovered"),
      Status(4, "Died")
    ];
  }
}

class Months{
  int id;
  String name;

 Months(this.id,this.name);

  static List<Months>getMonths(){
    return<Months>[
       Months(0, "All Months"),
      Months(1, "Jan"),
      Months(2, "Feb"),
      Months(3, "Mar"),
      Months(4, "Apr"),
      Months(5, "May"),
      Months(6, "Jun"),
      Months(7, "Jul"),
      Months(8, "Aug"),
      Months(9, "Sept"),
      Months(10, "Oct"),
      Months(11, "Nov"),
      Months(12, "Dec"),
    ];
  }
}

class _MyHomePageState extends State<MyHomePage> {

  final debouncer = Debouncer(milliseconds: 2000);
 
  
  List<Gender> genders = Gender.getGenders();
  List<Months> months = Months.getMonths();
  List<Status> status = Status.getStatus();

  List<DropdownMenuItem<Gender>> dropDownMenuGenderItems;
  List<DropdownMenuItem<Months>> dropDownMenuMonthsItems;
  List<DropdownMenuItem<Status>> dropDownMenuStatusItems;

  Gender _selectedGender;
  Months _selectedMonth;
  Status _selectedStatus;
  List<ConfirmedCases> confirmedCases = List();
  List<ConfirmedCases> filteredConfirmedCases = List();

@override
  void initState() {
     // TODO: implement initState
    super.initState();
   dropDownMenuGenderItems = buildDropdownGenderMenuItems(genders);
   _selectedGender = dropDownMenuGenderItems[0].value;
   
   dropDownMenuMonthsItems= buildDropdownMonthsMenuItems(months);
   _selectedMonth = dropDownMenuMonthsItems[0].value;
   dropDownMenuStatusItems= buildDropdownStatusMenuItems(status);
   _selectedStatus = dropDownMenuStatusItems[0].value;
   Services.getConfirmedCases().then((confirmedCasesFromServer){
     setState(() {
       confirmedCases = confirmedCasesFromServer;
       filteredConfirmedCases = confirmedCases;
     });
   });
  }
      List<DropdownMenuItem<Months>> buildDropdownMonthsMenuItems(List months){
      List<DropdownMenuItem<Months>> items = List();
      for(Months month in months){
        items.add(
          DropdownMenuItem(
            value:month,
            child:Text(month.name)
            )
          );
      }
      return items;
  }
    List<DropdownMenuItem<Status>> buildDropdownStatusMenuItems(List statuss){
      List<DropdownMenuItem<Status>> items = List();
      for(Status status in statuss){
        items.add(
          DropdownMenuItem(
            value:status,
            child:Text(status.name)
            )
          );
      }
      return items;
  }

  List<DropdownMenuItem<Gender>> buildDropdownGenderMenuItems(List genders){
      List<DropdownMenuItem<Gender>> items = List();
      for(Gender gender in genders){
        items.add(
          DropdownMenuItem(
            value:gender,
            child:Text(gender.name)
            )
          );
      }
      return items;
  }
  String genderRole;
  onChangeDropdownGenderItem(Gender selectedGender){
    setState(() {
      _selectedGender = selectedGender;
      if(_selectedGender.name == "Male"){
        genderRole = "M";
      }else if(_selectedGender.name == "Female"){
        genderRole = "F";
      }else{
        genderRole = "";
      }
    });
  }
    onChangeDropdownStatusItem(Status selectedStatus){
    setState(() {
      _selectedStatus = selectedStatus;
    });
  }
    onChangeDropdownMonthsItem(Months selectedMonths){
    setState(() {
      _selectedMonth = selectedMonths;
    });
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
    
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top:25,left: 10,right:10,bottom: 25),
                height: 100,
                color: Colors.green[300],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      child:    DropdownButton(
                        
                      value: _selectedGender,
                      items: dropDownMenuGenderItems,
                      onChanged: (string){
                        onChangeDropdownGenderItem(string);
                        
                          setState(() {
                            filteredConfirmedCases = confirmedCases.where((u)=>
                            (u.gender.toLowerCase().contains(genderRole.toLowerCase()))).toList();
                            
                          });
                      },
                      
                    ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                    ),
                 
                     Container(
                       padding: EdgeInsets.all(10),
                       child: DropdownButton(
                        
                        value: _selectedMonth,
                        items: dropDownMenuMonthsItems,
                        onChanged: onChangeDropdownMonthsItem,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                     ),
                       Container(
                         padding: EdgeInsets.all(10),
                         child: DropdownButton(
                      
                      value: _selectedStatus,
                      items: dropDownMenuStatusItems,
                      onChanged: onChangeDropdownStatusItem,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                       ),
                    
                  ],
                )
                ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: filteredConfirmedCases.length,
                  itemBuilder: (BuildContext context, int index){
                    return Card(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "PH"+filteredConfirmedCases[index].caseNo
                            ),
                            SizedBox(height: 5.0,),
                             Text(
                              filteredConfirmedCases[index].status
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
          ],
        ),
      
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => print(""),
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ),
    );
  }
}

class Debouncer{
  final int milliseconds;
  VoidCallback action;
  Timer _timer;
  Debouncer({this.milliseconds});
  run(VoidCallback action){
    if(null != _timer){
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds),action);
  }
}
 


import 'package:flutter/material.dart';
import 'package:httprequestapi/LockdownCities.dart';
import 'package:httprequestapi/Services.dart';
import 'package:httprequestapi/dashboardchart.dart';

import 'Debouncer.dart';

class LockedDownCitiesPage extends StatefulWidget {
  @override
  _LockedDownCitiesPageState createState() => _LockedDownCitiesPageState();
}
class Regions{
  String id;
  String name;

  Regions(this.id,this.name);

  static List<Regions>getRegions(){
    return<Regions>[
      Regions("NCR","National Capital Region"),
      Regions("I","Ilocos Region"),
      Regions("CAR", "Cordillera Administrative Region"),
      Regions("II","Cagayan Valley"),
      Regions("III","Central Luzon"),
      Regions("IV-A","Calabarzon"),
      Regions("Mimaropa","Southwestern Tagalog Region"),
      Regions("5","Bicol Region"),
      Regions("VI","Western Visayas"),
      Regions("VII","Central Visayas"),
      Regions("VIII","Eastern Visayas"),
      Regions("IX","Zamboanga Peninsula"),
      Regions("X","Northern Mindanao"),
      Regions("XI","Davao Region"),
      Regions("XII","Soccsksargen"),
      Regions("XIII","Caraga Region"),
      Regions("BARMM","Bangsamoro ARMM"),
    ];
  }
}
class _LockedDownCitiesPageState extends State<LockedDownCitiesPage> {

   final debouncer = Debouncer(milliseconds: 2000);
 
  
  List<Regions> regions = Regions.getRegions();
  List<DropdownMenuItem<Regions>> dropDownMenuRegionItems;
  Regions _selectedRegion;

  List<LockdownCities> lockdownCities = List();
  List<LockdownCities> filteredLockdownCities = List();

        List<DropdownMenuItem<Regions>> buildDropdownRegionsMenuItems(List regions){
      List<DropdownMenuItem<Regions>> items = List();
      for(Regions region in regions){
        items.add(
          DropdownMenuItem(
            value:region,
            child:Text(region.id)
            )
          );
      }
      return items;
  }
  
  onChangedDropdownRegionsItem(Regions selectedRegions){
    setState(() {
      _selectedRegion = selectedRegions;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
       dropDownMenuRegionItems= buildDropdownRegionsMenuItems(regions);
   _selectedRegion = dropDownMenuRegionItems[0].value;
      ServicesLockdownCities.getLockedDownCities().then((lockedDownCitiesFromServer){
     setState(() {
       lockdownCities = lockedDownCitiesFromServer;
       filteredLockdownCities = lockdownCities;
       
     });

      });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text("Lockdown Cities"),
        actions: <Widget>[
          IconButton(
            onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>DashBoardChart())),
            icon: Icon(Icons.ac_unit),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
       
        children: <Widget>[
            Container(
              padding: EdgeInsets.only(top:25,left: 10,right:10,bottom: 25),
                height: 100,
                color: Colors.green[300],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("Select Region : "),
                    Container(
                      width:MediaQuery.of(context).size.width/2,
                      padding: EdgeInsets.all(10),
                      child:    DropdownButton(
                        isExpanded: true,
                        
                      value: _selectedRegion,
                      items: dropDownMenuRegionItems,
                      onChanged: (string){
                       
                        onChangedDropdownRegionsItem(string);
                        
                          setState(() {
                            filteredLockdownCities = lockdownCities.where((u)=>
                            (u.region.toLowerCase() == _selectedRegion.id.toLowerCase())
                            
                            ).toList();
                          });

                      },
                      
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
                  itemCount: filteredLockdownCities.length,
                  itemBuilder: (BuildContext context, int index){
                    return Card(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Region : "+filteredLockdownCities[index].region
                            ),
                            Text(
                              filteredLockdownCities[index].lgu
                            ),
                          
                             Text(
                              filteredLockdownCities[index].estPopulation
                            ),
                             Text(
                              filteredLockdownCities[index].cases
                            ),
                             Text(
                              filteredLockdownCities[index].recovered
                            ),
                            Text(
                              filteredLockdownCities[index].deaths
                            ),
                          
                      
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )

        ],
      )

    );
  }
}
class LockdownCities{
  final String lgu;
  final String region;
  final String startDate;
  final String estPopulation;
  final String cases;
  final String deaths;
  final String recovered;

  LockdownCities({this.lgu, 
  this.region, 
  this.startDate, 
  this.estPopulation, 
  this.cases, 
  this.deaths, 
  this.recovered});

     factory LockdownCities.fromJson(Map<String, dynamic> json){
       return LockdownCities(
          lgu:json["lgu"],
          region: json["region"],
          startDate: json["startDate"],
          estPopulation: json["estimated_population"].toString(),
          cases: json["cases"].toString(),
          deaths: json["deaths"].toString(),
          recovered: json["recovered"].toString()
       );
     }
}
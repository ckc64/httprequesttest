class ConfirmedCases {
  final String caseNo;
  final String dateConF;
  final String age;
  final String gender;
  final String nationality;
  final String hospitalAdmittedTo;
  final String hadRecentTravelAbroad;
  final String status;
  final String otherInformation;

  ConfirmedCases({
      this.caseNo,
      this.dateConF,
      this.age,
      this.gender,
      this.nationality,
      this.hospitalAdmittedTo,
      this.hadRecentTravelAbroad,
      this.status,
      this.otherInformation});

     factory ConfirmedCases.fromJson(Map<String, dynamic> json){
       return ConfirmedCases(
           caseNo: json["case_no"].toString(),
          dateConF: json["date"],
          age: json["age"].toString(),
          gender : json["gender"],
          nationality : json["nationality"],
          hospitalAdmittedTo: json["hospital_admitted_to"],
          hadRecentTravelAbroad: json["had_recent_travel_history_abroad"],
          status : json["status"],
          otherInformation : json["other_information"]
       );
     }
}

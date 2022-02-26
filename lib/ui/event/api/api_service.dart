// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
// import 'dart:convert';
// import 'package:webrtc_app/model/login_model.dart';
// import 'package:webrtc_app/model/event.dart';
// class APIService{
//
//   // Future<LoginResponseModel> login(LoginRequestModel requestModel) async{
//   //   String url = 'https://vms.hcdt.vn:20003/vms/api/host/login';
//   //   final respone = await http.post(Uri.parse(url), body: requestModel.toJson());
//   //   if(respone.statusCode == 200 || respone.statusCode == 400){
//   //     return LoginResponseModel.fromJson(json.decode(respone.body));
//   //   }else{
//   //     throw Exception('Failed to load Data');
//   //   }
//   // }
//   static Future<List<Event>> getListEvent () async {
//     List listNewEvent =[];
//     String token = "&token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJCa2F2Q29ycG9yYXRpb24iLCJpYXQiOjE2NDU3MTc2NjgsImV4cCI6MTkwNDkxNzY2OCwidXNlciI6ImFkbWluIiwidHlwZSI6ImFjY2VzcyIsInNlY3VyZSI6ImV5SnBkaUk2SWt0dWNtTjFOaXR3UnpaUFVscFJPSEo1UVVRM1NYYzlQU0lzSW5aaGJIVmxJam9pTml0UmQyUm5kVEZvVWtoclMxUm1iM1Z3TWtJMGNYbE9UbXd2V1hJMWFrOVBjR1J4WlRoWmRsZFllVlF2T0doV05pOTVjazlQTkhKNlNWcHNNbEZJTVdGNldYWXhZVmR5VkRkVVFYTjBiSGxvVVd0S1p6VXJOM053TURseFUzZGhLMDV5TVVwMU5YTndSakJ1ZGxoSWFrZERaazVxY3pBeU5VOUZVVll6ZFRjMWRFTndSalpuTWpWUWVYZE1VMVJMVFhKTVozY3lhRGxMY2s5WFZVOVNVMEZVVmpNeGRVSTVNWGhXU2poblZIWlFVVXBhUWtoMlVEVk1ORmxyU21jMEt5dHpiMlowWTFSTE1UVXlURFV3VDJrelRVc3haejA5SWl3aWJXRmpJam9pWWprMVl6UmlPRFprTURaaVl6WXlNbU16WWpNMU1UVTVPV0U1WWpnNVlXVXhaREEwTkRBMVpUWXpOVFUxWldZM1pHSXlPR1kzWldZeE4yVTNPR1ZpWWlKOSJ9.PjU7Hj8QpC9G4wpRkf7YcfZs104q8X2hhT0_fNvUzqE";
//     String url = 'https://vms.hcdt.vn:20003/vms/api/ai/event-newest?' + token;
//     Response response = await get(Uri.parse(url));
//
//     for(var i in json.decode(response.body)){
//       listNewEvent.add(i);
//     }
//     return Event.eventList(listNewEvent);
//   }
// }
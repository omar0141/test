import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:shakosh/new/Data/Remote/MyApi.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Components/snakbars.dart';

class AddressesRemote {
  Future<bool> addAddress({
    required String name,
    String? countryID,
    String? cityID,
    String? areaID,
    String? telephone1,
    String? address1,
    String? coordinates,
  }) async {
    try {
      var url = MyApi.addAddress;
      var data = {
        "SID": MyApi.SID,
        "CID": MyApi.UID,
        "name": name,
        "country_id": countryID,
        "city_id": cityID,
        "area_id": areaID,
        "telephone1": telephone1,
        "address1": address1,
      };
      print(data);
      if (coordinates != null) {
        data["coordinates"] = coordinates;
      }
      var response = await http.post(Uri.parse(url), body: data);
      var responsebody = jsonDecode(response.body);
      log("Add Address Remote");
      if (responsebody == null) {
        MySnackBar()
            .errorSnack(navigatorKey.currentContext, "Server Error", true);
      } else if (responsebody["status"] == 200) {
        log("Add Address Remote Success");
        return true;
      } else {
        MySnackBar().errorSnack(
            navigatorKey.currentContext, responsebody.toString(), true);
      }
    } catch (e) {
      MySnackBar().errorSnack(navigatorKey.currentContext, e.toString(), true);
    }
    return false;
  }

  Future<List<dynamic>> getAddresses() async {
    try {
      var url = MyApi.getAddresses;
      var data = {
        "SID": MyApi.SID,
        "CID": MyApi.UID,
      };
      var response = await http.post(Uri.parse(url), body: data);
      var responsebody = jsonDecode(response.body);
      log("Get Addresses Remote");
      if (responsebody == null) {
        MySnackBar()
            .errorSnack(navigatorKey.currentContext, "Server Error", true);
      } else if (responsebody["status"] == 200) {
        log("Get Addresses Remote Success");
        return responsebody["data"];
      } else {
        MySnackBar().errorSnack(
            navigatorKey.currentContext, responsebody.toString(), true);
      }
    } catch (e) {
      MySnackBar().errorSnack(navigatorKey.currentContext, e.toString(), true);
    }
    return [];
  }
}
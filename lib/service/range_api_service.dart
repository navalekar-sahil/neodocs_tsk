import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../utils/custom_snackbar.dart';

class RangeApiService {
  static const String _url =
      'https://nd-assignment.azurewebsites.net/api/get-ranges';

  static const String _token =
      'eb3dae0a10614a7e719277e07e268b12aeb3af6d7a4655472608451b321f5a95';

  Future<List<dynamic>> fetchRanges(BuildContext context) async {
    try {
      final response = await http.get(
        Uri.parse(_url),
        headers: {'Authorization': 'Bearer $_token'},
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }

      if (response.statusCode == 401) {
        CustomSnackBar.show(
          context,
          message: "Session expired. Please login again.",
          backgroundColor: Colors.red,
          icon: Icons.lock,
        );
        throw Exception("Unauthorized");
      }

      CustomSnackBar.show(
        context,
        message: "Server error. Please try again.",
        backgroundColor: Colors.orange,
        icon: Icons.cloud_off,
      );
      throw Exception("Server error");
    } on SocketException {
      CustomSnackBar.show(
        context,
        message: "No internet connection",
        backgroundColor: Colors.blueGrey,
        icon: Icons.wifi_off,
      );
      throw Exception("No Internet");
    } catch (e) {
      CustomSnackBar.show(
        context,
        message: "Something went wrong",
        backgroundColor: Colors.red,
        icon: Icons.error,
      );
      throw Exception("Unknown error");
    }
  }
}

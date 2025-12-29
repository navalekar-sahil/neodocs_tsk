
import 'package:flutter/material.dart';
import '../model/range_model.dart';
import '../service/range_api_service.dart';

class RangeViewModel extends ChangeNotifier {
  final RangeApiService _service = RangeApiService();

  List<RangeModel> ranges = [];
  bool isLoading = false;
  String? error;
  double inputValue = 0;

  Future<void> loadRanges(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();

      final data = await _service.fetchRanges(context);
      ranges = data.map((e) => RangeModel.fromJson(e)).toList();
      error = null;
    } catch (e) {
      error = 'Unable to load ranges';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void updateValue(double value) {
    inputValue = value;
    notifyListeners();
  }
}

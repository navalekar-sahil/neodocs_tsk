class RangeModel {
  final double start;
  final double end;
  final String label;
  final String color;

  RangeModel({
    required this.start,
    required this.end,
    required this.label,
    required this.color,
  });

  factory RangeModel.fromJson(Map<String, dynamic> json) {
    final parts = json['range'].toString().split('-');

    return RangeModel(
      start: double.parse(parts[0]),
      end: double.parse(parts[1]),
      label: json['meaning'],
      color: json['color'],
    );
  }
}

import 'package:flutter/material.dart';

class RangeCard extends StatelessWidget {
  final String label;
  final double start;
  final double end;
  final String colorHex;

  const RangeCard({
    super.key,
    required this.label,
    required this.start,
    required this.end,
    required this.colorHex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 10,left: 10,right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 3,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Row(
        children: [
          Container(
            height: 30,
            width: 5,
            decoration: BoxDecoration(
              color: Color(int.parse('0xFF${colorHex.substring(1)}')),
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          const SizedBox(width: 10),

          Text(label),

          const Spacer(),

          Text("$start - $end"),
        ],
      ),
    );
  }
}

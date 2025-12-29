import 'package:flutter/material.dart';
import '../model/range_model.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomRangeBar extends StatelessWidget {
  final List<RangeModel> ranges;
  final double value;

  const CustomRangeBar({
    super.key,
    required this.ranges,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final min = ranges.first.start;
    final max = ranges.last.end;
    final total = max - min;

    return LayoutBuilder(
      builder: (context, constraints) {
        final barWidth = constraints.maxWidth;
        final position = ((value - min) / total).clamp(0.0, 1.0) * barWidth;

        return Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Row(
                    children: ranges.map((range) {
                      final flex = (((range.end - range.start) / total) * 1000).toInt();
                      return Expanded(
                        flex: flex,
                        child: Container(
                          height: 42,
                          color: Color(
                            int.parse('0xFF${range.color.substring(1)}'),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                // Indicator
                Positioned(
                  left: position,
                  bottom: -50,
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        "assets/svg/triangle.svg",
                        width: 16,
                        height: 16,
                      ),
                      Text(value.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),)
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/custom_range_bar.dart';
import '../view_model/range_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RangeViewModel()..loadRanges(context),
      child: Consumer<RangeViewModel>(
        builder: (_, vm, __) {
          if (vm.isLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (vm.error != null) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(vm.error!),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        vm.loadRanges(context);
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepPurple,
                title: const Text('Range Visualizer',style: TextStyle(color: Colors.white),)),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  //text field
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Enter value',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8), // Rounded corners
                        borderSide: const BorderSide(
                          color: Colors.black, // Border color
                          width: 1.5, // Border width
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Colors.black, // Border color when not focused
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Colors.black, // Border color when focused
                          width: 2,
                        ),
                      ),
                    ),
                    onChanged: (v) => vm.updateValue(double.tryParse(v) ?? 0),
                  ),


                  const SizedBox(height: 24),

                  //custom bar
                  CustomRangeBar(ranges: vm.ranges, value: vm.inputValue),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

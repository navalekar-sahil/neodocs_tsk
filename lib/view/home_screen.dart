import 'package:flutter/material.dart';
import 'package:neodocs_task/utils/range_card.dart';
import 'package:provider/provider.dart';
import '../utils/custom_range_bar.dart';
import '../view_model/range_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      _loadRanges();
    },);
  }

  void _loadRanges(){
    Provider.of<RangeViewModel>(context,listen: false).loadRanges(context);

  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async{
        _loadRanges();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: const Text(
            'Range Visualizer',
            style: TextStyle(color: Colors.white),
          ),
        ),

        body: Padding(
          padding: const EdgeInsets.all(16),

          child: Consumer<RangeViewModel>(
            builder: (_, vm, __) {

              if (vm.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (vm.error != null) {
                return Center(
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
                );
              }

              return Column(
                children: [

                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Enter value',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: (v) {
                        vm.updateValue(double.tryParse(v) ?? 0);
                    }
                  ),

                  const SizedBox(height: 24),

                  CustomRangeBar(
                    ranges: vm.ranges,
                    value: vm.inputValue,
                  ),

                  const SizedBox(height: 100),

                  Expanded(
                    child: ListView.builder(
                      itemCount: vm.ranges.length,
                      itemBuilder: (context, index) {
                        final range = vm.ranges[index];

                        return RangeCard(
                          label: range.label,
                          start: range.start,
                          end: range.end,
                          colorHex: range.color,
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

}

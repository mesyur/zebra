import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:stacked/stacked.dart';

import '../date_time_picker_view_model.dart';

class TimePickerView extends ViewModelWidget<DateTimePickerViewModel> {
  const TimePickerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, DateTimePickerViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 45,
          alignment: Alignment.center,
          child: viewModel.timeSlots == null
              ? Text(
                  viewModel.timeOutOfRangeError,
                  style: const TextStyle(color: Colors.black87),
                )
              : ScrollablePositionedList.builder(
            itemScrollController: viewModel.timeScrollController,
                  itemPositionsListener: viewModel.timePositionsListener,
                  scrollDirection: Axis.horizontal,
                  itemCount: viewModel.timeSlots!.length,
                  itemBuilder: (context, index) {
                    final date = viewModel.timeSlots![index];
                    return GestureDetector(
                      onTap: () => viewModel.selectedTimeIndex = index,
                      child: Column(
                        children: [
                          Container(
                            height: 25,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            margin: const EdgeInsets.only(left: 2,right: 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: index == viewModel.selectedTimeIndex
                                    ? Colors.black26
                                    : Colors.grey,
                              ),
                              color: index == viewModel.selectedTimeIndex
                                  ? Colors.black54
                                  : Colors.white,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              DateFormat(viewModel.is24h ? 'HH:mm' : 'hh:mm aa')
                                  .format(date),
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: index == viewModel.selectedTimeIndex ? Colors.white : Colors.black38,),
                              // style: TextStyle(
                              //     fontSize: 14,fontWeight: FontWeight.w800,
                              //     color: index == viewModel.selectedTimeIndex
                              //         ? Colors.white
                              //         : Colors.grey),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

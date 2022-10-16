import 'package:crony_interview/color_scheme.dart';
import 'package:crony_interview/constants.dart';
import 'package:flutter/material.dart';
import 'package:chips_choice/chips_choice.dart';

class ChipsGroup extends StatefulWidget {
  const ChipsGroup({Key? key}) : super(key: key);

  @override
  State<ChipsGroup> createState() => _ChipsGroupState();
}

class _ChipsGroupState extends State<ChipsGroup> {
  late String? value = 'All';

  List<Map<String, String>> shoeCategories = [
    {'value': 'All', 'image': 'assets/images/category_1.png'},
    {'value': "Collection'22", 'image': 'assets/images/category_2.png'},
    {'value': "Cyber Neon'22", 'image': 'assets/images/category_3.png'},
    {'value': "Gradient Fade", 'image': 'assets/images/category_4.png'},
    {'value': "Ronaldo's Set", 'image': 'assets/images/category_5.png'},
    {'value': "LeBron's Set", 'image': 'assets/images/category_6.png'},
    {'value': "Messi's Set", 'image': 'assets/images/category_7.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return ChipsChoice<String>.single(
      value: value,
      onChanged: (val) => setState(() => value = val),
      choiceItems: C2Choice.listFrom<String, Map<String, String>>(
        source: shoeCategories,
        value: (index, item) => item['value']!,
        label: (index, item) => item['image']!,
      ),
      choiceBuilder: (choice) {
        return Padding(
          padding: const EdgeInsets.all(Constants.kPaddingS / 2),
          child: GestureDetector(
            onTap: () => choice.select!(true),
            child: choice.selected
                ? _buildFullChip(choice)
                : Container(
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: Image.asset(
                      choice.label,
                      height: 55,
                    ),
                  ),
          ),
        );
      },
    );
  }

  Widget _buildFullChip(C2Choice<String> choice) {
    return Container(
      padding: const EdgeInsets.all(Constants.kPaddingS),
      decoration: BoxDecoration(
        color: AppColors.kSecondaryColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          CircleAvatar(
            child: Image.asset(choice.label),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: Constants.kPaddingS * 1.5,
              right: Constants.kPaddingM * 0.8,
            ),
            child: Text(
              choice.value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

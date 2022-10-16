import 'package:crony_interview/constants.dart';
import 'package:crony_interview/models.dart';
import 'package:crony_interview/simple_shadow.dart';
import 'package:flutter/material.dart';

class ShoeCard extends StatelessWidget {
  final ShoeModel shoe;
  final Color color;
  const ShoeCard({
    Key? key,
    required this.shoe,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 190,
          width: 140,
          margin: const EdgeInsets.all(Constants.kPaddingM),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(Constants.kCardRadius),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.5),
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(Constants.kPaddingS * 1.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      shoe.collectionName!.toUpperCase(),
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      'View All',
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: Constants.kPaddingL,
          child: DropShadow(
            sigma: 7,
            child: Image.asset(
              shoe.image!,
              height: 145,
              width: 140,
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:crony_interview/constants.dart';
import 'package:crony_interview/models.dart';
import 'package:crony_interview/simple_shadow.dart';
import 'package:flutter/material.dart';

import 'color_scheme.dart';

class ShoeCollectionCard extends StatelessWidget {
  final ShoeModel shoe;
  const ShoeCollectionCard({
    Key? key,
    required this.shoe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: const EdgeInsets.all(Constants.kPaddingM),
          decoration: BoxDecoration(
            color: AppColors.kCardBackgroundColor,
            borderRadius: BorderRadius.circular(Constants.kCardRadius),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.all(Constants.kPaddingM),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        shoe.collectionName!.toUpperCase(),
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: AppColors.kTxtSubtitleColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      Text(
                        shoe.name!,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: AppColors.kTxtHeadingColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: Constants.kPaddingS),
                      Text(
                        shoe.price!,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: AppColors.kTxtPriceColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.only(
                    left: Constants.kPaddingM * 1.5,
                    right: Constants.kPaddingM,
                    top: Constants.kPaddingM * 0.8,
                    bottom: Constants.kPaddingM * 0.8,
                  ),
                  decoration: const BoxDecoration(
                    color: AppColors.kPrimaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(33),
                      bottomRight: Radius.circular(Constants.kCardRadius),
                    ),
                  ),
                  child: Image.asset(
                    'assets/icons/plus.png',
                    height: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: -Constants.kPaddingL * 1.3,
          left: Constants.kPaddingL * 1.2,
          child: DropShadow(
            sigma: 5,
            opacity: 0.4,
            child: Image.asset(
              shoe.image!,
              height: 140,
              width: 120,
            ),
          ),
        ),
      ],
    );
  }
}

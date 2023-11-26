import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:m_coffee_v2/src/constants/app_constants.dart';
import 'package:m_coffee_v2/src/features/home/data/home_repository.dart';
import 'package:m_coffee_v2/src/utils/app_utils.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var heightSize = AppUtils.height(context);

    var fontSizeName = 20;
    var fontSizeWelcome = 20;
    var FontWeightWelcome = FontWeight.w700;
    var pTop = 10;

    var gap = 25;

    if (heightSize > 130) {
      pTop = 20;
    } else {
      pTop = 20;
    }

    if (heightSize < 550) {
      gap = 10;
    }

    return Container(
      height: heightSize,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
        image: DecorationImage(
            image: AssetImage("assets/images/biji_kopi.png"),
            fit: BoxFit.cover),
      ),
      // color: Color(0xFFF44336),
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(top: pTop.toDouble(), right: 20, left: 20),
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: AppConstants.primaryColor,
                        ),
                        child: const Icon(
                          Icons.favorite_border,
                          color: AppConstants.primaryText,
                        ),
                      ),
                    ),
                    Text(
                      "Home",
                      style: TextStyle(
                        color: AppConstants.primaryText,
                        fontSize: fontSizeWelcome.toDouble(),
                        fontWeight: FontWeightWelcome,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: AppConstants.primaryColor,
                        ),
                        child: const Icon(
                          CupertinoIcons.bell,
                          color: AppConstants.primaryText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Gap(gap.toDouble()),
              if (heightSize > 500)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Welcome, ${HomeRepository.userName}",
                    softWrap: false,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppConstants.primaryText,
                      fontSize: fontSizeName.toDouble(),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

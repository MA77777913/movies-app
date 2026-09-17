

import 'package:flutter/cupertino.dart';

import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_text_style.dart';

class AdditionalDetails extends StatelessWidget{

  String likeCount;
  String iconPath;

  AdditionalDetails({required this.iconPath,required this.likeCount});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 47,
      width: 122,
      decoration: BoxDecoration(
        color: AppColor.gray,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 6,right: 6),
            child: Container(
              child: Image.asset(
                iconPath,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 6,right: 6),
            child: Text(
              likeCount,
              style: AppTextStyle.titleMovieDetails,
            ),
          ),
        ],
      ),
    );
  }

}
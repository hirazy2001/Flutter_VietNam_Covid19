import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vietnam_covid19/src/constant/constants.dart';
import 'package:flutter_vietnam_covid19/src/constant/theme.dart';

class CenterHomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, top: 20, right: 10),
            alignment: Alignment.topLeft,
            child: Text(
              "Phòng ngừa",
              style: TextStyle(
                  fontFamily: Constants.fontPoppins,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 5, right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                cardContent(
                    title: "Tránh tiếp xúc gần",
                    svgPicture: "assets/svg/avoidclosecontact.svg"),
                cardContent(
                    title: "Làm sạch tay thường xuyên",
                    svgPicture: "assets/svg/cleanhands.svg"),
                cardContent(
                    title: "Luôn mang khẩu trang",
                    svgPicture: "assets/svg/facemask.svg")
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Stack(children: [
              Container(
                  margin: EdgeInsets.only(left: 24),
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * 0.18,
                      right: 16,
                      top: 16,
                      bottom: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                      gradient: LinearGradient(colors: [
                    ThemePrimary.primaryColor,
                    ThemePrimary.primaryColor.withOpacity(0.4)
                  ], begin: Alignment.topRight, end: Alignment.bottomLeft)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bạn đã sẵn sàng?",
                        style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white)
                      ),
                      Text("Chung sức vì cộng đồng vượt qua đại dịch",
                          style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.white))
                    ],
                  )),
              Positioned(
                top: 0,
                bottom: 0,
                left: 15,
                child: SvgPicture.asset(
                  "assets/svg/owntest.svg",
                  fit: BoxFit.fill,
                  alignment: Alignment.center,
                ),
              )
            ]),
          )
        ],
      ),
    );
  }

  Widget cardContent({required String title, required String svgPicture}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(svgPicture, fit: BoxFit.fill),
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: TextStyle(
                fontFamily: Constants.fontPoppins, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

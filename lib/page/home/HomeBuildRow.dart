import 'package:flutter/material.dart';
import 'package:gankflutter/model/DailyResponse.dart';
import 'package:gankflutter/page/home/HomeBanner.dart';

Widget buildHomeBannerRow(context, postData){
   List<PostData> banner = new List();

   if(postData!=null){
     for(var value in postData){
       banner.add(PostData.fromJson(value));
     }
   }
   return HomeBanner(banner, 200.0);
}
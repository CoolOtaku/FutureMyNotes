import 'package:flutter/material.dart';

Dialog ViewRusianFackYouDialog(){
  return Dialog(
      backgroundColor: Colors.transparent,
      child: Column(
        children: [
          Image.asset("src/img/milytary_anime.png", width: 300.0, fit:BoxFit.fill),
          Image.asset("src/img/rusian_fack_you.png", height: 300.0, fit:BoxFit.fill),
        ],
      )
  );
}

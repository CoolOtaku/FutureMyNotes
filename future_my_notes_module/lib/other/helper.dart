import 'package:flutter/material.dart';

void ViewSnack(BuildContext context, String text, bool isOk){
  var icon;
  if(isOk){
    icon = Icon(Icons.library_add_check_outlined, color: Colors.green, size: 35.0);
  }else{
    icon = Icon(Icons.cancel_outlined, color: Colors.red, size: 35.0);
  }

  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Row(
      children: [
        icon,
        SizedBox(width: 5),
        Text(text)
      ],
    ),
  ));
}

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
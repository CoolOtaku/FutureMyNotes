import 'package:contactus/contactus.dart';
import 'package:flutter/material.dart';

import 'package:FutureMyNotes/other/helper.dart';

class Contacts extends StatefulWidget {
  Contacts({Key? key}) : super(key: key);

  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 8),
        child: Column(
          children: [
            ContactUs(
              logo: AssetImage('src/img/dev_image.jpg'),
              email: 'ericspz531@gmail.com',
              companyName: "Федорів Назарій",
              dividerThickness: 2,
              githubUserName: 'CoolOtaku',
              tagLine: 'Full Stack Developer',
              instagram: 'coll_otaku',
              linkedinURL: 'https://www.linkedin.com/in/назар-федорів-331283232/',
              cardColor: Colors.white,
              taglineColor: Colors.white,
              textColor: Colors.black45,
              companyColor: Colors.white,
              dividerColor: Colors.white,
              facebookHandle: 'profile.php?id=100008579443704',
            ),
            IconButton(
              icon: Image.asset("src/img/gerb.png"),
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => ViewRusianFackYouDialog(),
              ),
            )
          ]
        )
      )
    );
  }
}
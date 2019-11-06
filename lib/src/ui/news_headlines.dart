import 'package:flutter/material.dart';
import 'package:division/division.dart';

import 'package:news_app/src/ui/news_view.dart';

class NewsHeadlines extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Parent(
      style: ParentStyle()..padding(all: 0.8),
      gesture: GestureClass()
        ..onTap(() {
          // print('haha');
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NewsView()));
        }),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              child: Align(
                child: Text(''),
                alignment: Alignment.bottomLeft,
              ),
              height: 100.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.blue,
                  image: DecorationImage(
                      image: new NetworkImage(
                          "https://media.hitekno.com/thumbs/2019/03/03/67508-ilustrasi-whatsapp/730x480-img-67508-ilustrasi-whatsapp.jpg"),
                      fit: BoxFit.fill)),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Tawarkan Aneka Diskon, Realme Gelar Mega Sale 11.11 - Selular.ID',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                )),
          )
        ],
      ),
    );
  }
}

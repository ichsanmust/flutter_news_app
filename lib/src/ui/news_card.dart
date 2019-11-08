import 'package:flutter/material.dart';
import 'package:division/division.dart';
import 'package:news_app/src/ui/news_view.dart';
import 'package:transparent_image/transparent_image.dart';

Widget newsCard(context, item) {
  if (item.urlToImage == null) {
    item.urlToImage =
        'https://media.hitekno.com/thumbs/2019/03/03/67508-ilustrasi-whatsapp/730x480-img-67508-ilustrasi-whatsapp.jpg';
  }
  return Parent(
    child: Row(
      children: <Widget>[
        Expanded(
          flex: 4,
          child: Parent(
            style: ParentStyle()
              ..alignmentContent.topCenter()
              ..padding(all: 0),
            child: ClipRRect(
              borderRadius: new BorderRadius.circular(10.0),
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: item.urlToImage,
              ),
            ),
            // child: Container(
            //   child: Align(
            //     child: Text(''),
            //     alignment: Alignment.bottomLeft,
            //   ),
            //   height: 100.0,
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(5),
            //       color: Colors.blue,
            //       image: DecorationImage(
            //           image: new NetworkImage(item.urlToImage),
            //           fit: BoxFit.fill)),
            // )
          ),
        ),
        Expanded(
          flex: 5,
          child: Parent(
            style: ParentStyle()
              // ..background.color(Colors.red)
              ..alignmentContent.center()
              ..minHeight(100),
            child: Column(
              children: <Widget>[
                Parent(
                  style: ParentStyle()
                    // ..background.color(Colors.red)
                    ..minHeight(75)
                    ..padding(right: 10, left: 10),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        item.title,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )),
                ),
                Parent(
                  style: ParentStyle()..padding(right: 10, top: 5),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        item.publishedAt,
                        style: TextStyle(fontSize: 10),
                      )),
                )
              ],
            ),
          ),
        )
      ],
    ),
    style: ParentStyle()
      ..margin(left: 17, right: 17, top: 5, bottom: 0)
      ..background.hex('39424c')
      ..elevation(5)
      ..padding(all: 5)
      ..borderRadius(all: 10)
      ..minHeight(100),
    gesture: GestureClass()
      ..onTap(() {
        // print('haha');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => NewsView(
              item : item
            )));
      }),
  );
}

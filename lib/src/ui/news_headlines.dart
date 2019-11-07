import 'package:flutter/material.dart';
import 'package:division/division.dart';

import 'package:news_app/src/ui/news_view.dart';
// import 'package:transparent_image/transparent_image.dart';

class NewsHeadlines extends StatelessWidget {
  NewsHeadlines({this.item});

  var item;
  

  @override
  Widget build(BuildContext context) {

    if (item.urlToImage == null) {
        item.urlToImage =
            'https://media.hitekno.com/thumbs/2019/03/03/67508-ilustrasi-whatsapp/730x480-img-67508-ilustrasi-whatsapp.jpg';
      }

    return Parent(
      style: ParentStyle()..padding(all: 0.8),
      gesture: GestureClass()
        ..onTap(() {
          // print('haha');
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NewsView(
                item: item,
              )));
        }),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
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
                          item.urlToImage),
                      fit: BoxFit.fill)),
            ),
            // child : Container(
            //   height: 120.0,
            //   child: ClipRRect(
            //     borderRadius: new BorderRadius.circular(10.0),
            //     child: FadeInImage.memoryNetwork(
            //       placeholder: kTransparentImage,
            //       image: urlToImage,
            //     ),
            //   ),
            // )
          ),
          Expanded(
            flex: 2,
            child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    item.title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                )),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:division/division.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsView extends StatefulWidget {
  NewsView({Key key, this.item}) : super(key: key);
  final item;

  @override
  _NewsViewState createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  _launchURL(url) async {
    print(url);
    await launch(url);
    // if (await canLaunch(url)) {
    //   await launch(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.item);
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 15,
              child: ListView(
                children: <Widget>[
                  Parent(
                    style: ParentStyle()
                      // ..background.color(Colors.red)
                      ..padding(left: 10, right: 10, top: 10)
                      ..alignmentContent.center(),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: widget.item.urlToImage,
                      ),
                    ),
                  ),
                  Parent(
                    style: ParentStyle()
                      ..margin(left: 10, right: 10, top: 5)
                      ..background.hex('39424c')
                      ..elevation(5)
                      ..padding(all: 5)
                      ..borderRadius(all: 10)
                      ..minHeight(300),
                    child: Column(
                      children: <Widget>[
                        Container(
                            child: Parent(
                                style: ParentStyle()
                                  ..width(MediaQuery.of(context).size.width)
                                  ..padding(left: 5, right: 5, top: 5),
                                child: Text(
                                  widget.item.title,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ))),
                        Container(
                            child: Parent(
                                style: ParentStyle()
                                  ..width(MediaQuery.of(context).size.width)
                                  ..padding(left: 5, right: 5, top: 5),
                                child: Text(
                                  widget.item.name,
                                  style: TextStyle(fontSize: 14),
                                ))),
                        Container(
                            child: Parent(
                                style: ParentStyle()
                                  ..width(MediaQuery.of(context).size.width)
                                  ..padding(left: 20, right: 5, top: 5),
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      widget.item.publishedAt,
                                      style: TextStyle(fontSize: 12),
                                    )))),
                        Container(
                            child: Parent(
                                style: ParentStyle()
                                  ..width(MediaQuery.of(context).size.width)
                                  ..padding(left: 5, right: 5, top: 15),
                                child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      // 'is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
                                      ' ${widget.item.description}',
                                      textAlign: TextAlign.justify,
                                    )))),
                        Divider(),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Parent(
                  style: ParentStyle()
                    ..background.color(Colors.deepPurple)
                    ..borderRadius(all: 10)
                    ..margin(left: 10, right: 10, bottom: 10)
                    ..width(MediaQuery.of(context).size.width),
                  child: FlatButton(
                    child: Text('Go to Website'),
                    onPressed: () {
                      // Navigator.pop(context, 'cancel');
                      _launchURL(widget.item.url);
                    },
                  )),
            )
          ],
        ),
      ),
    );
  }
}

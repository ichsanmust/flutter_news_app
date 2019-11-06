import 'package:flutter/material.dart';
import 'package:division/division.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:news_app/src/ui/news_view.dart';

class NewsList extends StatefulWidget {
  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList>
    with AutomaticKeepAliveClientMixin<NewsList> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  var refreshKey = GlobalKey<RefreshIndicatorState>();

  refresh() {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () {
        // var returnData = getDataRekanKerja(true);
        // setState(() {
        //   peers = returnData;
        // });
        // return returnData;
        return refresh();
      },
      child: ListView(
        children: <Widget>[
          newsCard(context),
          newsCard(context),
          newsCard(context),
          newsCard(context),
        ],
      ),
    );
  }
}

Widget newsCard(context) {
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
                image:
                    'https://media.hitekno.com/thumbs/2019/03/03/67508-ilustrasi-whatsapp/730x480-img-67508-ilustrasi-whatsapp.jpg',
              ),
            ),
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
                // Txt('Tawarkan Aneka Diskon, Realme Gelar Mega Sale 11.11 - Selular.ID',
                //     style: TxtStyle()
                //       ..alignmentContent.center()
                //       ..textColor(Colors.white)
                //       ..fontWeight(FontWeight.bold)
                //       ..fontSize(16)
                //       ..padding(all: 5)),
                Parent(
                  style: ParentStyle()
                    // ..background.color(Colors.red)
                    ..minHeight(75)
                    ..padding(right: 10, left: 10),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Tawarkan Aneka Diskon, Realme Gelar Mega Sale 11.11 - Selular.ID',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )),
                ),
                Parent(
                  style: ParentStyle()..padding(right: 10, top: 5),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '2019-11-04',
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
            context, MaterialPageRoute(builder: (context) => NewsView()));
      }),
  );
}

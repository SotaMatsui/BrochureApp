import 'package:flutter/material.dart';

class MoreInfoComp extends StatelessWidget {
  final String title;
  final Icon icon;
  final Widget body;
  MoreInfoComp(
    this.title,
    this.icon,
    this.body,
  );
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.5,
        minChildSize: 0.5,
        maxChildSize: 1,
        builder: (context, scrollController) {
          return Material(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            color: Colors.white,
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Material(
                              color: Colors.grey[300],
                              child: SizedBox(
                                width: 24,
                                height: 4,
                              ),
                            ),
                          )
                        ]),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(16.0),
                        child: icon,
                      ),
                      Text(
                        title,
                        style:
                            TextStyle(color: Colors.grey[800], fontSize: 16.0),
                      ),
                    ],
                  ),
                  Divider(
                      height: 10,
                      thickness: 1,
                      color: Colors.grey[250],
                      indent: 16,
                      endIndent: 16),
                  Container(
                    margin: EdgeInsets.all(12.0),
                    child: body,
                  ),
                ],
              ),
            ),
          );
        });
  }
}

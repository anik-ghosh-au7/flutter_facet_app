import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends PreferredSize {
  final Widget child;
  final double height;

  CustomAppBar({@required this.child, this.height = kToolbarHeight});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      // color: Colors.white,
      alignment: Alignment.centerLeft,
      child: child,
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
        color: Colors.white,
      ),
    );
  }
}

class Filters extends StatefulWidget {
  final List aggregationData;
  Filters({Key key, this.aggregationData}) : super(key: key);
  @override
  _MyFiltersState createState() {
    return _MyFiltersState();
  }
}

class _MyFiltersState extends State<Filters> {
  var aggregationData = new Map();

  @override
  void initState() {
    super.initState();
    widget.aggregationData.forEach((element) {
      var key = element["_key"];
      setState(() {
        aggregationData[key] = false;
      });
    });
    print(aggregationData);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 105, 0, 0),
      child: Column(
        children: [
          Container(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                height: 750,
                color: Colors.white,
                child: Scaffold(
                  appBar: CustomAppBar(
                    height: 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                              text: 'Selects Authors',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ],
                    ),
                  ),
                  body: ListView(
                    children: aggregationData.keys.map((key) {
                      return new CheckboxListTile(
                        title: new Text(key),
                        value: aggregationData[key],
                        onChanged: (bool value) {
                          print('value ==>> ${value}');
                          setState(() {
                            aggregationData[key] = value;
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                color: Colors.black,
                height: 70,
                width: 500,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 6,
                        child: RaisedButton(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 23.0),
                          color: Colors.black,
                          child: Text(
                            'Apply',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {},
                          // shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(50.0)),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.center,
                          child: RichText(
                            text: TextSpan(
                              text: '|',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 50,
                                  fontWeight: FontWeight.w100),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: RaisedButton(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 23.0),
                          color: Colors.black,
                          child: Text(
                            'Close',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          // shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(50.0)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

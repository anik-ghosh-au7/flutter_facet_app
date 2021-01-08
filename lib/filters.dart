import 'package:flutter/material.dart';

typedef void MyCallback(String foo);

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
  final List value;
  final MyCallback setValue;
  final bool loading;
  Filters(
      {Key key, this.aggregationData, this.value, this.setValue, this.loading})
      : super(key: key);
  @override
  _MyFiltersState createState() {
    return _MyFiltersState();
  }
}

class _MyFiltersState extends State<Filters> {
  var aggregationData = new Map();
  var value;
  var loading;

  @override
  void initState() {
    super.initState();
    value = widget.value;
    widget.aggregationData.forEach((element) {
      var key = element["_key"];
      setState(() {
        if (value.contains(key)) {
          aggregationData[key] = true;
        } else {
          aggregationData[key] = false;
        }
      });
    });
    loading = widget.loading;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      child: Padding(
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
                    body: loading
                        ? Center(child: CircularProgressIndicator())
                        : ListView(
                            children: aggregationData.keys.map((key) {
                              return Container(
                                child: Column(
                                  children: [
                                    new CheckboxListTile(
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      activeColor: Colors.black54,
                                      dense: true,
                                      title: new Text(key),
                                      value: aggregationData[key],
                                      onChanged: (bool value) {
                                        setState(() {
                                          aggregationData[key] = value;
                                        });
                                        widget.setValue(key);
                                      },
                                    ),
                                    const Divider(
                                      color: Colors.black,
                                      height: 10,
                                      thickness: 0.1,
                                      indent: 25,
                                      endIndent: 20,
                                    )
                                  ],
                                ),
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
      ),
    );
  }
}

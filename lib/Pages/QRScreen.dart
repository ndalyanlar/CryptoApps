import 'package:crypto_dashboard/Icons/my_flutter_app_icons.dart';
import 'package:crypto_dashboard/utils/balances.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:qrscan/qrscan.dart' as scanner;
import 'dart:io';
import 'dart:typed_data';

class QrScreenPage extends StatefulWidget {
  @override
  _QrScreenPageState createState() => _QrScreenPageState();
}

class _QrScreenPageState extends State<QrScreenPage> {
  TextEditingController _inputController = new TextEditingController();
  TextEditingController _outputController = new TextEditingController();
  List<String> titleList = [];
  String dropdownValue = balances(null)[0].title;
  Uint8List ss = Uint8List(0);
  @override
  initState() {
    super.initState();
    this._inputController = new TextEditingController();
    this._outputController = new TextEditingController();
    balances(null).forEach((element) {
      titleList.add(element.title);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        title: Text("Qpay"),
        centerTitle: false,
      ),
      body: Builder(builder: (BuildContext context) {
        return ListView(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.blue, Colors.black],
              )),
              // color: Color.fromRGBO(255, 250, 250, 1),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Card(
                      color: Colors.white10,
                      elevation: 6,
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Icon(Icons.verified_user,
                                    size: 18, color: Colors.green),
                                Text(' QR Code',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white)),
                                Spacer(),
                              ],
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.black87,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(26),
                                  bottomRight: Radius.circular(26)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 20, right: 20, top: 20, bottom: 20),
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 190,
                                  child: ss.isEmpty
                                      ? Center(
                                          child: Text(
                                              'The your address displays here',
                                              style: TextStyle(
                                                  color: Colors.black38)),
                                        )
                                      : Container(
                                          color: Colors.white,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.memory(ss),
                                          )),
                                ),
                                Divider(
                                  height: 20,
                                  color: Colors.black26,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 4, left: 20, right: 25),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      TextButton(
                                          child: Container(
                                            width: 25,

                                            // margin: EdgeInsets.only(right: 25),
                                            child: Text(
                                              'Sil',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          onPressed: () {
                                            _outputController.text = "None";
                                            setState(() {
                                              ss = Uint8List(0);
                                            });
                                          }),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          final success = false;
                                          // await ImageGallerySaver.saveImage(ss);
                                          SnackBar snackBar;
                                          if (success) {
                                            snackBar = new SnackBar(
                                                content: new Text(
                                                    'Successful Preservation!'));
                                            Scaffold.of(context)
                                                .showSnackBar(snackBar);
                                          } else {
                                            snackBar = new SnackBar(
                                                content:
                                                    new Text('Save failed!'));
                                          }
                                        },
                                        child: Text(
                                          '-',
                                          style: TextStyle(
                                              fontSize: 15, color: Colors.blue),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Divider(height: 1, color: Colors.black26),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[500],
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      width: 400,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            dropdownColor: Colors.blue,
                            value: dropdownValue,
                            iconSize: 32,
                            elevation: 30,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),
                            underline: Container(
                              height: 2,
                              width: 200,
                              color: Colors.blue,
                            ),
                            onChanged: (String? newValue) async {
                              setState(() {
                                dropdownValue = newValue!;
                              });

                              Uint8List result =
                                  await scanner.generateBarCode(newValue!);
                              setState(() => ss = result);

                              _outputController.text = "Ready.";
                            },
                            items: titleList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),

                    // ayrı iki widget
                    // child: TextField(
                    //   controller: this._inputController,
                    //   keyboardType: TextInputType.url,
                    //   textInputAction: TextInputAction.go,
                    //   onSubmitted: (value) async {
                    //     Uint8List result = await scanner.generateBarCode(value);
                    //     setState(() => ss = result);
                    //   },
                    //   decoration: InputDecoration(
                    //     filled: true,
                    //     fillColor: Colors.white,
                    //     border: new OutlineInputBorder(
                    //       borderRadius: const BorderRadius.all(
                    //         const Radius.circular(15.0),
                    //       ),
                    //       gapPadding: 5.0,
                    //     ),
                    //     helperText: 'Data for the generation of QRCode',
                    //     helperStyle: TextStyle(color: Colors.white),
                    //     hintText: 'Please Input Your Data for QR Code',
                    //     hintStyle: TextStyle(
                    //       fontSize: 15,
                    //     ),
                    //     contentPadding:
                    //         EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    //   ),
                    // ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: TextField(
                      controller: this._outputController,
                      readOnly: true,
                      //maxLines: 2,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: this._outputController.text != "Ready."
                            ? Colors.red
                            : Colors.green,
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(15.0),
                          ),
                          gapPadding: 5.0,
                        ),
                        helperText: 'The Scanned Result',
                        helperStyle: TextStyle(color: Colors.white),
                        hintText: 'The results after scanning are :',
                        hintStyle: TextStyle(fontSize: 16),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  _buttongroup(_inputController, _outputController, ss),
                  SizedBox(height: 150)
                ],
              ),
            ),
          ],
        );
      }),
    ));
  }

  getElements() {
    balances(null).forEach((element) {
      titleList.add(element.title);
    });
  }
}

Widget _buttongroup(TextEditingController _inputController,
    TextEditingController _outputController, Uint8List ss) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      FloatingActionButton.extended(
        onPressed: () async {
          String barcode = await scanner.scan();
          _outputController.text = barcode;
        },
        label: Text(
          "Scan",
          style: TextStyle(color: Colors.white),
        ),
        icon: Icon(
          Icons.qr_code_sharp,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue[300],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
      ),
      FloatingActionButton.extended(
        onPressed: () async {
          String barcode = await scanner.scanPhoto();
          _outputController.text = barcode;
        },
        label: Text(
          "Payout",
          style: TextStyle(color: Colors.white),
        ),
        icon: Icon(
          Icons.payment_outlined,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue[300],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
      ),
    ],
  );
}

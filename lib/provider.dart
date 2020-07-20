import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

enum ColorEvent { to_red, to_blue }

class ColorBloc {
  Color _color = Colors.red;

  StreamController<ColorEvent> _eventController =
      StreamController<ColorEvent>();
  StreamSink<ColorEvent> get eventSink => _eventController.sink;

  StreamController<Color> _stateController = StreamController<Color>();
  StreamSink<Color> get _stateSink => _stateController.sink;
  Stream<Color> get stateStream => _stateController.stream;

  void _mapEventToState(ColorEvent colorEvent) {
    if (colorEvent == ColorEvent.to_red)
      _color = Colors.red;
    else
      _color = Colors.blue;

    _stateSink.add(_color);
  }

  ColorBloc() {
    _eventController.stream.listen(_mapEventToState);
  }

  void dispose() {
    _eventController.close();
    _stateController.close();
  }
}

class Cart with ChangeNotifier {
  int _quantity = 0;

  int get quantity => _quantity;
  set quantity(int value) {
    _quantity = value;
    notifyListeners();
  }
}

class Money with ChangeNotifier {
  int _balance = 10000;

  int get balance => _balance;
  set balance(int value) {
    _balance = value;
    notifyListeners();
  }
}

class NomorDua extends StatefulWidget {
  @override
  _NomorDuaState createState() => _NomorDuaState();
}

class _NomorDuaState extends State<NomorDua> {
  ColorBloc bloc = ColorBloc();
  @override
  void dispose() {
    bloc.dispose;
    super.dispose();
  }

  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Money>(
          create: (context) => Money(),
        ),
        ChangeNotifierProvider<Cart>(
          create: (context) => Cart(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text("StateManagement"),
        ),
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              StreamBuilder(
                initialData: Colors.white,
                stream: bloc.stateStream,
                builder: (context, snapshot) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(
                                  left: 50,
                                  top: 30,
                                  right: 30,
                                ),
                                color: Colors.white,
                                height: 150,
                                width: 100,
                              ),
                              Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Apple",
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Rp. 500",
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Consumer<Cart>(
                                  builder: (context, cart, _) => Text(
                                    cart.quantity.toString(),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Container(
                                    color: Colors.white,
                                    child: Consumer<Cart>(
                                      builder: (context, cart, _) =>
                                          Consumer<Money>(
                                        builder: (context, money, _) =>
                                            GestureDetector(
                                          onTap: () {
                                            if (money.balance >= 500) {
                                              cart.quantity += 1;
                                              money.balance -= 500;
                                            }
                                          },
                                          child: Icon(Icons.add),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Stack(
                        children: <Widget>[
                          Center(
                            child: Container(
                              margin: EdgeInsets.only(
                                top: 30,
                              ),
                              width: 250,
                              height: 200,
                              decoration: BoxDecoration(
                                color: snapshot.data,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(12),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 10,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Text(
                                          "Balance",
                                        ),
                                        SizedBox(
                                          width: 50,
                                        ),
                                        Consumer<Money>(
                                          builder: (context, money, _) => Text(
                                            money.balance.toString(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 10,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Text(
                                          "Total",
                                        ),
                                        SizedBox(
                                          width: 70,
                                        ),
                                        Consumer<Cart>(
                                          builder: (context, cart, _) => Text(
                                            (500 * cart.quantity).toString(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 20,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        FloatingActionButton(
                                          heroTag: "1",
                                          backgroundColor: Colors.red,
                                          onPressed: () {
                                            bloc.eventSink
                                                .add(ColorEvent.to_red);
                                          },
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        FloatingActionButton(
                                          heroTag: "2",
                                          backgroundColor: Colors.blue,
                                          onPressed: () {
                                            bloc.eventSink
                                                .add(ColorEvent.to_blue);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

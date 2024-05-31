import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _real = "0";
  String _euro = "0";
  String _bitcon = "0";

  void _recuperarPreco() async {

    final url = Uri.parse("https://openexchangerates.org/api/latest.json?app_id=ed1004cb370a41d9a7075caf489560c7");
    http.Response response = await http.get(url);

    Map<String, dynamic> retorno = json.decode(response.body);
    setState(() {
      _real = retorno["rates"]["BRL"].toString();
      _euro = retorno["rates"]["EUR"].toString();
      _bitcon = retorno["rates"]["BTC"].toStringAsFixed(6);
    });
  }

  void _restart(){
    setState(() {
      _real = "0";
      _euro = "0";
      _bitcon = "0";
    });
    _recuperarPreco();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        centerTitle: true,
        title: const Text(
          "Cotação do dólar",
          style: TextStyle(
            color: Colors.white,
            fontSize: 35.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            onPressed: _restart,
            ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(40),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 25, bottom: 25),
                    child: Column(
                      children: [
                        const Text("Real brasileiro (BRL)",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            border: Border.all(
                              color: Colors.blue,
                              width: 4,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text("R\$ $_real",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                            ),
                            ),
                        ),
                      ],
                    ),
                    ),
                    Padding(
                    padding: const EdgeInsets.only(top: 25, bottom: 25),
                    child: Column(
                      children: [
                        const Text("Euro (EUR)",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            border: Border.all(
                              color: Colors.blue,
                              width: 4,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text("€ $_euro",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                            ),
                            ),
                        ),
                      ],
                    ),
                    ),
                    Padding(
                    padding: const EdgeInsets.only(top: 25, bottom: 25),
                    child: Column(
                      children: [
                        const Text("Bitcoin (BTC)",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            border: Border.all(
                              color: Colors.blue,
                              width: 4,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text("₿ $_bitcon",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                            ),
                            ),
                        ),
                      ],
                    ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ElevatedButton(
                        onPressed: _recuperarPreco,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
                        ),
                        child: const Text("Atualizar",
                        style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.black,
                        ),
                        ),
                        ),
                      ),
                ],
              ),
            ),
          ),
        ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.blue[900],
        ),
    );
  }
}

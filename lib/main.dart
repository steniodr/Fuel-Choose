import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  // Criar estado da aplicação
  @override
  _HomeState createState() => _HomeState();
}

// Classe que controla o estado da aplicação (State)
class _HomeState extends State<Home> {
  // Configurando os nossos campos de entrada de valores
  TextEditingController alcoolController = TextEditingController();
  TextEditingController gasolinaController = TextEditingController();
  String _resultado = ''; // Recebe o resultado 'texto' do calculo
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _reset() {
    alcoolController.text = '';
    gasolinaController.text = '';
    setState(() {
      _resultado = '';
      _formKey = GlobalKey<FormState>(); // Resetar estado do Form.
    });
  }

  void _calculaCombustivelIdeal() {
    setState(() {
      double varAlcool =
          double.parse(alcoolController.text.replaceAll(',', '.'));
      double varGasolina =
          double.parse(gasolinaController.text.replaceAll(',', '.'));

      double porporcao = varAlcool / varGasolina;
      _resultado =
          porporcao < 0.7 ? 'Abasteça com Álcool' : 'Abasteça com Gasolina';
    });
  }

  // Inicia criação de Interface
  @override
  Widget build(BuildContext context) {
    // Build é o construtor da interface
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Álcool ou Gasolina?',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue[800],
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                _reset();
              })
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.local_gas_station,
                size: 150.0,
                color: Colors.lightBlue[800],
              ),
              Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text(
                    'Descubra se vale mais a pena abastecer com Álcool ou Gasolina',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(color: Colors.lightBlue[800], fontSize: 15.0),
                  )),
              TextFormField(
                controller: alcoolController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value.isEmpty ? 'Informe o valor do Álcool (L)' : null,
                decoration: InputDecoration(
                    labelText: 'Insira o valor do Álcool (L)',
                    labelStyle: TextStyle(color: Colors.lightBlue[800])),
                style: TextStyle(color: Colors.lightBlue[800], fontSize: 15.0),
              ),
              TextFormField(
                controller: gasolinaController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value.isEmpty ? 'Informe o valor da Gasolina (L)' : null,
                decoration: InputDecoration(
                    labelText: 'Insira o valor da Gasolina (L)',
                    labelStyle: TextStyle(color: Colors.lightBlue[800])),
                style: TextStyle(color: Colors.lightBlue[800], fontSize: 15.0),
              ),
              Padding(
                padding: EdgeInsets.only(top: 50.0, bottom: 50.0),
                child: Container(
                  height: 50.0,
                  child: RawMaterialButton(
                    onPressed: () {
                      if (_formKey.currentState.validate())
                        _calculaCombustivelIdeal();
                    },
                    child: Text(
                      'Verificar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                      ),
                    ),
                    fillColor: Colors.lightBlue[800],
                  ),
                ),
              ),
              Text(
                _resultado,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.lightBlue[800], fontSize: 25.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}

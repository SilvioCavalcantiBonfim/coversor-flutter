import 'package:flutter/material.dart';

void main() {
  runApp(MeuApp());
}

// Define o widget raiz do aplicativo
class MeuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conversor de Moedas',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TelaConversor(), // Define o widget inicial do aplicativo
    );
  }
}

// Widget Stateful para a tela de conversão de moedas
class TelaConversor extends StatefulWidget {
  @override
  _TelaConversorState createState() => _TelaConversorState();
}

class _TelaConversorState extends State<TelaConversor> {
  String _moedaSelecionada = "USD";
  String _resultado = "";
  final TextEditingController _controllerReais = TextEditingController();

  final Map<String, Widget> coins = {
    'USD': Row(
      mainAxisSize: MainAxisSize.min, // Ajusta o tamanho da Row para caber o conteúdo
      children: [
        Icon(Icons.attach_money, size: 24.0), // Tamanho do ícone
        SizedBox(width: 8.0), // Espaço entre o ícone e o texto
        Text("USD", style: TextStyle(fontSize: 16.0)),
      ],
    ),
    'EUR': Row(
      mainAxisSize: MainAxisSize.min, // Ajusta o tamanho da Row para caber o conteúdo
      children: [
        Icon(Icons.euro, size: 24.0), // Tamanho do ícone para Euro
        SizedBox(width: 8.0), // Espaço entre o ícone e o texto
        Text("EUR", style: TextStyle(fontSize: 16.0)),
      ],
    ),
    'GBP': Row(
      mainAxisSize: MainAxisSize.min, // Ajusta o tamanho da Row para caber o conteúdo
      children: [
        Icon(Icons.currency_pound, size: 24.0), // Tamanho do ícone para Libra Esterlina
        SizedBox(width: 8.0), // Espaço entre o ícone e o texto
        Text("GBP", style: TextStyle(fontSize: 16.0)),
      ],
    ),
  };

  void _converter() {
    double valorReais = double.tryParse(_controllerReais.text) ?? 0.0;
    const double taxaDolar = 0.20;
    const double taxaEuro = 0.18;
    const double taxaLibra = 0.16;
    double valorConvertido = 0;
    switch (_moedaSelecionada) {
      case 'USD':
        valorConvertido = taxaDolar * valorReais;
        break;
      case 'EUR':
        valorConvertido = taxaEuro * valorReais;
        break;
      case 'GBP':
        valorConvertido = taxaLibra * valorReais;
        break;
      default:
        setState(() {
          _resultado = 'Opção inválida!';
        });
        return; // Saia da função para evitar sobrescrever o resultado
    }
    setState(() {
      _resultado = 'Resultado: ${valorConvertido.toStringAsFixed(2)} $_moedaSelecionada';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conversor de Moedas', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 137, 0, 116), // Cor de fundo personalizada para a barra de título
        centerTitle: true, // Centraliza o título na barra de título
      ),
      body: Center(
        child: SingleChildScrollView(
          // Permite rolagem se o conteúdo exceder o tamanho da tela
          padding: const EdgeInsets.all(16.0), // Adiciona um padding ao redor do conteúdo principal
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centraliza o conteúdo verticalmente
            children: <Widget>[
              Card(
                elevation: 4.0, // Sombra para destacar o card
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0), // Bordas arredondadas para o card
                  side: BorderSide(color: const Color.fromARGB(255, 150, 0, 77), width: 2), // Adiciona uma borda de cor teal ao redor do card
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0), // Padding interno do card
                  child: Column(
                    children: [
                      TextField(
                        controller: _controllerReais, // Controlador para capturar o valor em reais
                        keyboardType: TextInputType.number, // Tipo de teclado numérico
                        decoration: InputDecoration(
                          labelText: 'Digite o valor em reais (BRL)', // Texto do label dentro do campo de texto
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0), // Bordas arredondadas para o campo de texto
                            borderSide: BorderSide(color: const Color.fromARGB(255, 137, 0, 116), width: 2), // Borda personalizada para o campo de texto
                          ),
                          prefixIcon: Icon(Icons.monetization_on), // Ícone de moeda antes do campo de entrada
                        ),
                      ),
                      SizedBox(height: 16), // Espaço entre os elementos

                      DropdownButtonFormField<String>(
                        value: _moedaSelecionada, // Valor inicial selecionado no dropdown
                        onChanged: (String? novaMoeda) {
                          // Atualiza a moeda selecionada
                          setState(() {
                            _moedaSelecionada = novaMoeda!;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Selecione a Moeda', // Texto do label do dropdown
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0), // Bordas arredondadas para o dropdown
                            borderSide: BorderSide(color: const Color.fromARGB(255, 137, 0, 116), width: 2), // Borda personalizada para o dropdown
                          ),
                        ),
                        items: <String>['USD', 'EUR', 'GBP'] // Opções do dropdown
                            .map<DropdownMenuItem<String>>((String valor) {
                          return DropdownMenuItem<String>(
                            value: valor,
                            child: coins[valor]!,
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 16), // Espaço entre o dropdown e o botão
                      ElevatedButton.icon(
                        onPressed: _converter, // Chama a função de conversão ao ser pressionado
                        icon: Icon(
                          Icons.currency_exchange,
                          color: Colors.white,
                        ), // Ícone de sincronização no botão
                        label: Text('Converter',
                            style: TextStyle(color: Colors.white, fontSize: 20)), // Texto do botão
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 137, 0, 116), // Cor de fundo personalizada para o botão
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0), // Bordas arredondadas para o botão
                          ),
                        ),
                      ),
                      SizedBox(height: 16), // Espaço entre o botão e o resultado
                      Text(
                        _resultado, // Exibe o resultado da conversão
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold), // Estilo de texto para o resultado
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

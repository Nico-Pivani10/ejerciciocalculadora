import 'package:flutter/material.dart';

void main() {
  runApp(const CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  const CalculadoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora del Siglo',
      theme: ThemeData(fontFamily: 'Arial'),
      home: const CalculadoraPage(),
    );
  }
}

class CalculadoraPage extends StatefulWidget {
  const CalculadoraPage({super.key});

  @override
  State<CalculadoraPage> createState() => _CalculadoraPageState();
}

class _CalculadoraPageState extends State<CalculadoraPage> {
  final TextEditingController numero1Controller = TextEditingController();
  final TextEditingController numero2Controller = TextEditingController();

  String resultado = 'Ingrese números para comenzar';
  List<String> historial = [];

  void calcular(String operacion) {
    double? numero1 = double.tryParse(numero1Controller.text);
    double? numero2 = double.tryParse(numero2Controller.text);

    if (numero1 == null || numero2 == null) {
      setState(() {
        resultado = '⚠️ Ingrese números válidos';
      });
      return;
    }

    double calculo = 0;
    String simbolo = operacion;

    if (operacion == '+') {
      calculo = numero1 + numero2;
    } else if (operacion == '-') {
      calculo = numero1 - numero2;
    } else if (operacion == '*') {
      calculo = numero1 * numero2;
      simbolo = '×';
    } else if (operacion == '/') {
      if (numero2 == 0) {
        setState(() {
          resultado = '❌ No se puede dividir entre cero';
        });
        return;
      }
      calculo = numero1 / numero2;
      simbolo = '÷';
    }

    String operacionHistorial =
        '${numero1.toStringAsFixed(2)} $simbolo ${numero2.toStringAsFixed(2)} = ${calculo.toStringAsFixed(2)}';

    setState(() {
      resultado = '✅ Resultado: ${calculo.toStringAsFixed(2)}';
      historial.insert(0, operacionHistorial);
    });
  }

  void limpiar() {
    numero1Controller.clear();
    numero2Controller.clear();

    setState(() {
      resultado = 'Ingrese números para comenzar';
    });
  }

  void borrarHistorial() {
    setState(() {
      historial.clear();
    });
  }

  Widget botonOperacion(String texto, String operacion) {
    return ElevatedButton(
      onPressed: () => calcular(operacion),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff6B4636),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 8,
      ),
      child: Text(
        texto,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget campoNumero(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: const Color(0xff3A3A3A),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xff4A4A4A)),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xffC19A6B), width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1E1E1E),
      appBar: AppBar(
        backgroundColor: const Color(0xff2C2C2C),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          '🧮 Calculadora del Siglo',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Card(
              color: const Color(0xff2B2B2B),
              elevation: 12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: SizedBox(
                  width: 420,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.calculate_rounded,
                        size: 85,
                        color: Color(0xffC19A6B),
                      ),

                      const SizedBox(height: 15),

                      const Text(
                        'Hola 👋',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        'Bienvenido a la Calculadora del Siglo',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 18,
                        ),
                      ),

                      const SizedBox(height: 30),

                      campoNumero('Primer número', numero1Controller),

                      const SizedBox(height: 18),

                      campoNumero('Segundo número', numero2Controller),

                      const SizedBox(height: 28),

                      Wrap(
                        spacing: 15,
                        runSpacing: 15,
                        children: [
                          botonOperacion('+', '+'),
                          botonOperacion('−', '-'),
                          botonOperacion('×', '*'),
                          botonOperacion('÷', '/'),
                        ],
                      ),

                      const SizedBox(height: 30),

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xff1E1E1E),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: const Color(0xffC19A6B),
                            width: 2,
                          ),
                        ),
                        child: Text(
                          resultado,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 22),

                      ElevatedButton.icon(
                        onPressed: limpiar,
                        icon: const Icon(Icons.refresh),
                        label: const Text(
                          'Limpiar',
                          style: TextStyle(fontSize: 17),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),

                      const SizedBox(height: 28),

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: const Color(0xff242424),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: const Color(0xff5C4033),
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'Historial de operaciones',
                              style: TextStyle(
                                color: Color(0xffC19A6B),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 12),

                            if (historial.isEmpty)
                              const Text(
                                'Todavía no hay operaciones realizadas.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 15,
                                ),
                              )
                            else
                              SizedBox(
                                height: 150,
                                child: ListView.builder(
                                  itemCount: historial.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 8),
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: const Color(0xff1E1E1E),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        historial[index],
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),

                            const SizedBox(height: 14),

                            OutlinedButton.icon(
                              onPressed: borrarHistorial,
                              icon: const Icon(Icons.delete_outline),
                              label: const Text('Borrar historial'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: const Color(0xffC19A6B),
                                side: const BorderSide(
                                  color: Color(0xffC19A6B),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        'Desarrollado en Flutter - Atividade 03',
                        style: TextStyle(
                          color: Colors.white38,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
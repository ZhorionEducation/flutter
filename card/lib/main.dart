import 'dart:math';

import 'package:flutter/material.dart';
import 'package:particles_flutter/engine.dart';
import 'package:particles_flutter/interactions.dart';
import 'package:particles_flutter/shapes.dart';

/// Punto de entrada de la aplicación Flutter.
void main() {
  runApp(const MyApp());
}

/// Widget raíz de la aplicación.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hoja de vida',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const PrincipalScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

/// Pantalla principal con la hoja de vida y un fondo de red de puntos.
///
/// Es [StatefulWidget] para crear las partículas una sola vez (en
/// `initState`) y que no se regeneren en cada reconstrucción de la UI.
class PrincipalScreen extends StatefulWidget {
  const PrincipalScreen({super.key});
  

  @override
  State<PrincipalScreen> createState() => _PrincipalScreenState();
}

class _PrincipalScreenState extends State<PrincipalScreen> {
  late final List<CircularParticle> _puntos;

  @override
  void initState() {
    super.initState();
    final rng = Random();
    const colores = [
      Color(0xFF26C6DA), // cian
      Color(0xFF29B6F6), // azul claro
      Color(0xFF1DE9B6), // verde agua
    ];

    _puntos = List.generate(60, (_) {
      return CircularParticle(
        radius: rng.nextDouble() * 2 + 2,
        color: colores[rng.nextInt(colores.length)],
        velocity: Offset(
          (rng.nextDouble() - 0.5) * 50,
          (rng.nextDouble() - 0.5) * 50,
        ),
      );
    });
  }

  /// Tarjeta reutilizable para no repetir el mismo estilo tres veces.
  Widget _tarjeta(List<Widget> children) {
    return Card(
      color: const Color.fromARGB(255, 57, 59, 60),
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: DefaultTextStyle(
          style: const TextStyle(color: Colors.white),
          child: Column(children: children),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const titulo = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
    const texto = TextStyle(fontSize: 18);

    return Scaffold(
      backgroundColor: const Color(0xFF050D12),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 57, 59, 60),
        title: const Text(
          'Hoja de vida',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      // LayoutBuilder da el tamaño real del body (pantalla menos el AppBar).
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              // Capa de fondo: red de puntos conectados.
              Particles(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                boundType: BoundType.Bounce, // rebotan en los bordes
                connectDots: true, // dibuja las líneas entre puntos cercanos
                particles: _puntos,
                interaction: ParticleInteraction(
                  enableHover: true,
                  onTapAnimation: true,
                  awayRadius: 100,
                ),
              ),
              // Capa de contenido: tus tarjetas encima.
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _tarjeta([
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: const Icon(
                              Icons.person,
                              color: Color.fromARGB(255, 57, 59, 60),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text('Información Personal', style: titulo),
                        ],
                      ),
                      const Text('Documento: 1001652760', style: texto),
                      const SizedBox(height: 8),
                      const Text(
                        'Nombre: Cristian Felipe Buitrago Quintero',
                        style: texto,
                      ),
                      const SizedBox(height: 8),
                      const Text('Whatsapp: 3122742536', style: texto),
                      const SizedBox(height: 8),
                      const Text('Dirección: Calle 10 # 10-10', style: texto),
                    ]),
                    _tarjeta([
                      const Text('Formación Académica', style: titulo),
                      const Text('Analisis y desarrollo de software',
                          style: texto),
                      const SizedBox(height: 8),
                      const Text('SENA', style: texto),
                      const SizedBox(height: 8),
                      const Text('2026', style: texto),
                    ]),
                    _tarjeta([
                      const Text('Experiencia Laboral', style: titulo),
                      const Text('Desarrollador de software', style: texto),
                      const SizedBox(height: 8),
                      const Text('Empresa New Stetic', style: texto),
                      const SizedBox(height: 8),
                      const Text('2025', style: texto),
                    ]),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
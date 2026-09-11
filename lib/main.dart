import 'package:flutter/material.dart';

void main() {
  runApp(const AgendaTuDiaApp());
}

class AgendaTuDiaApp extends StatelessWidget {
  const AgendaTuDiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AGENDA TU DÍA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'sans-serif',
        scaffoldBackgroundColor: const Color(0xFFF8F9FE),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedDayIndex = 2; // Día de ejemplo seleccionado

  // Festivos y fechas especiales de Colombia (2026 - 2027)
  final Map<String, String> _festivosColombia = {
    // 2026
    "2026-01-01": "Año Nuevo",
    "2026-01-12": "Día de los Reyes Magos",
    "2026-03-23": "Día de San José",
    "2026-04-02": "Jueves Santo",
    "2026-04-03": "Viernes Santo",
    "2026-05-01": "Día del Trabajo",
    "2026-05-18": "Día de la Ascensión",
    "2026-06-08": "Corpus Christi",
    "2026-06-15": "Sagrado Corazón de Jesús",
    "2026-06-29": "San Pedro y San Pablo",
    "2026-07-20": "Día de la Independencia de Colombia",
    "2026-08-07": "Batalla de Boyacá",
    "2026-08-17": "La Asunción de la Virgen",
    "2026-10-12": "Día de la Raza",
    "2026-11-02": "Día de todos los Santos",
    "2026-11-16": "Independencia de Cartagena",
    "2026-12-08": "Día de la Inmaculada Concepción",
    "2026-12-25": "Navidad",

    // 2027
    "2027-01-01": "Año Nuevo",
    "2027-01-11": "Día de los Reyes Magos",
    "2027-03-22": "Día de San José",
    "2027-03-25": "Jueves Santo",
    "2027-03-26": "Viernes Santo",
    "2027-05-01": "Día del Trabajo",
    "2027-05-10": "Día de la Ascensión",
    "2027-05-31": "Corpus Christi",
    "2027-06-07": "Sagrado Corazón de Jesús",
    "2027-07-05": "San Pedro y San Pablo",
    "2027-07-20": "Día de la Independencia de Colombia",
    "2027-08-07": "Batalla de Boyacá",
    "2027-08-16": "La Asunción de la Virgen",
    "2027-10-18": "Día de la Raza",
    "2027-11-01": "Día de todos los Santos",
    "2027-11-15": "Independencia de Cartagena",
    "2027-12-08": "Día de la Inmaculada Concepción",
    "2027-12-25": "Navidad",
  };

  // Días de la semana
  final List<Map<String, dynamic>> _diasSemana = [
    {'letra': 'L', 'numero': '19', 'fechaCompleta': '2026-04-19'},
    {'letra': 'M', 'numero': '20', 'fechaCompleta': '2026-04-20'},
    {'letra': 'M', 'numero': '21', 'fechaCompleta': '2026-04-21'},
    {'letra': 'J', 'numero': '22', 'fechaCompleta': '2026-04-22'},
    {'letra': 'V', 'numero': '01', 'fechaCompleta': '2026-05-01'},
    {'letra': 'S', 'numero': '24', 'fechaCompleta': '2026-04-24'},
    {'letra': 'D', 'numero': '25', 'fechaCompleta': '2026-04-25'},
  ];

  // Lista de tareas
  final List<Map<String, dynamic>> _eventos = [
    {
      'id': '1',
      'titulo': 'Estudiar',
      'horario': '8:00 a.m. - 10:00 a.m.',
      'icono': Icons.menu_book_rounded,
      'colorFondo': const Color(0xFFEBE4FF),
      'colorBorde': const Color(0xFFC8B3FF),
      'colorTexto': const Color(0xFF5A3DB5),
      'completado': false,
      'recordatorio': true,
    },
    {
      'id': '2',
      'titulo': 'Reunión',
      'horario': '11:00 a.m. - 12:00 p.m.',
      'icono': Icons.people_outline_rounded,
      'colorFondo': const Color(0xFFE2F8F6),
      'colorBorde': const Color(0xFF9EEBE2),
      'colorTexto': const Color(0xFF1B8075),
      'completado': false,
      'recordatorio': true,
    },
    {
      'id': '3',
      'titulo': 'Almuerzo',
      'horario': '1:00 p.m. - 2:00 p.m.',
      'icono': Icons.restaurant_rounded,
      'colorFondo': const Color(0xFFFFE5DE),
      'colorBorde': const Color(0xFFFFC2B3),
      'colorTexto': const Color(0xFFD64D29),
      'completado': false,
      'recordatorio': false,
    },
    {
      'id': '4',
      'titulo': 'Ejercicio',
      'horario': '5:00 p.m. - 6:00 p.m.',
      'icono': Icons.fitness_center_rounded,
      'colorFondo': const Color(0xFFFFF4D4),
      'colorBorde': const Color(0xFFFFE48A),
      'colorTexto': const Color(0xFFB58000),
      'completado': false,
      'recordatorio': true,
    },
    {
      'id': '5',
      'titulo': 'Leer',
      'horario': '8:00 p.m. - 9:00 p.m.',
      'icono': Icons.import_contacts_rounded,
      'colorFondo': const Color(0xFFE1F0FF),
      'colorBorde': const Color(0xFFB5DAFF),
      'colorTexto': const Color(0xFF2A6CB5),
      'completado': false,
      'recordatorio': false,
    },
  ];

  // Colores disponibles
  final List<Map<String, dynamic>> _estilosColor = [
    {
      'nombre': 'Morado',
      'fondo': const Color(0xFFEBE4FF),
      'borde': const Color(0xFFC8B3FF),
      'texto': const Color(0xFF5A3DB5),
      'icono': Icons.menu_book_rounded,
    },
    {
      'nombre': 'Turquesa',
      'fondo': const Color(0xFFE2F8F6),
      'borde': const Color(0xFF9EEBE2),
      'texto': const Color(0xFF1B8075),
      'icono': Icons.people_outline_rounded,
    },
    {
      'nombre': 'Coral',
      'fondo': const Color(0xFFFFE5DE),
      'borde': const Color(0xFFFFC2B3),
      'texto': const Color(0xFFD64D29),
      'icono': Icons.restaurant_rounded,
    },
    {
      'nombre': 'Amarillo',
      'fondo': const Color(0xFFFFF4D4),
      'borde': const Color(0xFFFFE48A),
      'texto': const Color(0xFFB58000),
      'icono': Icons.fitness_center_rounded,
    },
    {
      'nombre': 'Azul',
      'fondo': const Color(0xFFE1F0FF),
      'borde': const Color(0xFFB5DAFF),
      'texto': const Color(0xFF2A6CB5),
      'icono': Icons.import_contacts_rounded,
    },
  ];

  String? _obtenerFestivoActual() {
    String fecha = _diasSemana[_selectedDayIndex]['fechaCompleta'];
    return _festivosColombia[fecha];
  }

  // Ventana emergente para agregar tarea con recordatorio
  void _mostrarModalAgregarEvento(BuildContext context) {
    final TextEditingController tituloController = TextEditingController();
    final TextEditingController inicioController = TextEditingController(text: '09:00 a.m.');
    final TextEditingController finController = TextEditingController(text: '10:00 a.m.');
    int estiloSeleccionado = 0;
    bool conRecordatorio = true;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Nueva Tarea',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F319D),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: tituloController,
                    decoration: InputDecoration(
                      labelText: 'Título de la actividad',
                      hintText: 'Ej. Ir al gimnasio',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.edit_calendar_rounded),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: inicioController,
                          decoration: InputDecoration(
                            labelText: 'Hora inicio',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: const Icon(Icons.access_time_rounded),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: finController,
                          decoration: InputDecoration(
                            labelText: 'Hora fin',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: const Icon(Icons.access_time_filled_rounded),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  // Switch para activar recordatorio
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Activar recordatorio'),
                    subtitle: const Text('Recibir notificación al iniciar'),
                    value: conRecordatorio,
                    activeColor: const Color(0xFF7061C8),
                    onChanged: (bool value) {
                      setModalState(() {
                        conRecordatorio = value;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Categoría / Color:',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(_estilosColor.length, (index) {
                      bool selected = estiloSeleccionado == index;
                      return GestureDetector(
                        onTap: () {
                          setModalState(() {
                            estiloSeleccionado = index;
                          });
                        },
                        child: Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: _estilosColor[index]['fondo'],
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: selected
                                  ? _estilosColor[index]['texto']
                                  : _estilosColor[index]['borde'],
                              width: selected ? 2.5 : 1.5,
                            ),
                          ),
                          child: Icon(
                            _estilosColor[index]['icono'],
                            size: 20,
                            color: _estilosColor[index]['texto'],
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        if (tituloController.text.trim().isNotEmpty) {
                          final nuevoEstilo = _estilosColor[estiloSeleccionado];
                          setState(() {
                            _eventos.add({
                              'id': DateTime.now().millisecondsSinceEpoch.toString(),
                              'titulo': tituloController.text.trim(),
                              'horario': '${inicioController.text} - ${finController.text}',
                              'icono': nuevoEstilo['icono'],
                              'colorFondo': nuevoEstilo['fondo'],
                              'colorBorde': nuevoEstilo['borde'],
                              'colorTexto': nuevoEstilo['texto'],
                              'completado': false,
                              'recordatorio': conRecordatorio,
                            });
                          });
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF7061C8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Guardar evento',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String? festivoActual = _obtenerFestivoActual();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black87),
          onPressed: () {},
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color(0xFF1F319D),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.event_available_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'AGENDA TU DÍA',
              style: TextStyle(
                color: Color(0xFF1F319D),
                fontWeight: FontWeight.bold,
                fontSize: 18,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded, color: Colors.black87),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            // Calendario semanal
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(_diasSemana.length, (index) {
                  bool isSelected = index == _selectedDayIndex;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDayIndex = index;
                      });
                    },
                    child: Column(
                      children: [
                        Text(
                          _diasSemana[index]['letra']!,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFF7061C8) : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            _diasSemana[index]['numero']!,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black87,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),

            // Banner festivo
            if (festivoActual != null)
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3C4),
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: const Color(0xFFFFD54F)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.flag_rounded, color: Color(0xFFD68F00)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        '🇨🇴 Hoy se celebra: $festivoActual',
                        style: const TextStyle(
                          color: Color(0xFF7A5200),
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            else
              const SizedBox(height: 14),

            // Lista con función de deslizar para eliminar
            Expanded(
              child: _eventos.isEmpty
                  ? const Center(
                      child: Text(
                        'No hay tareas agendadas para este día',
                        style: TextStyle(color: Colors.black45),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      itemCount: _eventos.length,
                      itemBuilder: (context, index) {
                        final evento = _eventos[index];
                        return Dismissible(
                          key: Key(evento['id']),
                          background: Container(
                            margin: const EdgeInsets.only(bottom: 14.0),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            decoration: BoxDecoration(
                              color: Colors.redAccent.shade100,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            alignment: Alignment.centerRight,
                            child: const Icon(Icons.delete_outline, color: Colors.white, size: 28),
                          ),
                          onDismissed: (direction) {
                            setState(() {
                              _eventos.removeAt(index);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Tarea "${evento['titulo']}" eliminada'),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 14.0),
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                            decoration: BoxDecoration(
                              color: evento['colorFondo'],
                              borderRadius: BorderRadius.circular(16.0),
                              border: Border.all(
                                color: evento['colorBorde'],
                                width: 1.5,
                              ),
                            ),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      evento['completado'] = !evento['completado'];
                                    });
                                  },
                                  child: Container(
                                    width: 22,
                                    height: 22,
                                    decoration: BoxDecoration(
                                      color: evento['completado'] ? evento['colorTexto'] : Colors.white,
                                      borderRadius: BorderRadius.circular(6.0),
                                      border: Border.all(
                                        color: evento['colorTexto'],
                                        width: 1.8,
                                      ),
                                    ),
                                    child: evento['completado']
                                        ? const Icon(Icons.check, size: 16, color: Colors.white)
                                        : null,
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        evento['titulo'],
                                        style: TextStyle(
                                          color: evento['colorTexto'],
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          decoration: evento['completado']
                                              ? TextDecoration.lineThrough
                                              : null,
                                        ),
                                      ),
                                      const SizedBox(height: 3),
                                      Row(
                                        children: [
                                          Text(
                                            evento['horario'],
                                            style: TextStyle(
                                              color: evento['colorTexto'].withOpacity(0.8),
                                              fontSize: 12,
                                            ),
                                          ),
                                          if (evento['recordatorio'] == true) ...[
                                            const SizedBox(width: 6),
                                            Icon(
                                              Icons.notifications_active_rounded,
                                              size: 13,
                                              color: evento['colorTexto'].withOpacity(0.7),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  evento['icono'],
                                  color: evento['colorTexto'].withOpacity(0.7),
                                  size: 26,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _mostrarModalAgregarEvento(context),
        backgroundColor: const Color(0xFF7061C8),
        elevation: 4,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }
}

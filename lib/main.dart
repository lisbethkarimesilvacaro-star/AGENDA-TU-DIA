import 'package:flutter/material.dart';

void main() {
  runApp(const AgendaApp());
}

class AgendaApp extends StatelessWidget {
  const AgendaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agenda Tu Día',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          // Cambiamos el color base a un tono lila/rosa tierno
          seedColor: const Color(0xFFD946EF), // Fucsia/Rosa suave
          primary: const Color(0xFFC084FC),    // Lila pastel principal
          secondary: const Color(0xFFF472B6),  // Rosa pastel secundario
          primaryContainer: const Color(0xFFF3E8FF), // Lila muy clarito para contenedores
        ),
      ),
      home: const MainScreen(),
    );
  }
}

class Event {
  final String title;
  final String description;
  final String time;
  final String category;
  final Color color;
  final bool isHoliday;

  Event({
    required this.title,
    required this.description,
    required this.time,
    required this.category,
    required this.color,
    this.isHoliday = false,
  });
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  DateTime _focusedDate = DateTime.now();
  DateTime _selectedDate = DateTime.now();
  int _currentViewIndex = 0;

  final Map<String, String> _holidays = {
    // 2026
    "2026-01-01": "Año Nuevo",
    "2026-01-12": "Día de los Reyes Magos",
    "2026-03-23": "Día de San José",
    "2026-04-02": "Jueves Santo",
    "2026-04-03": "Viernes Santo",
    "2026-05-01": "Día del Trabajo",
    "2026-05-18": "Día de la Ascensión",
    "2026-06-08": "Corpus Christi",
    "2026-06-15": "Sagrado Corazón",
    "2026-06-29": "San Pedro y San Pablo",
    "2026-07-20": "Día de la Independencia",
    "2026-08-07": "Batalla de Boyacá",
    "2026-08-17": "La Asunción de la Virgen",
    "2026-10-12": "Día de la Raza",
    "2026-11-02": "Día de todos los Santos",
    "2026-11-16": "Independencia de Cartagena",
    "2026-12-08": "Inmaculada Concepción",
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
    "2027-06-07": "Sagrado Corazón",
    "2027-07-05": "San Pedro y San Pablo",
    "2027-07-20": "Día de la Independencia",
    "2027-08-07": "Batalla de Boyacá",
    "2027-08-16": "La Asunción de la Virgen",
    "2027-10-18": "Día de la Raza",
    "2027-11-01": "Día de todos los Santos",
    "2027-11-15": "Independencia de Cartagena",
    "2027-12-08": "Inmaculada Concepción",
    "2027-12-25": "Navidad",
  };

  final Map<String, List<Event>> _events = {};

  static String _formatDateKey(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  List<Event> _getEventsForDay(DateTime day) {
    final key = _formatDateKey(day);
    List<Event> list = List.from(_events[key] ?? []);

    if (_holidays.containsKey(key)) {
      list.insert(
        0,
        Event(
          title: "🌸 ${_holidays[key]}",
          description: "Día Festivo Oficial",
          time: "Todo el día",
          category: "Festivos",
          color: const Color(0xFFF43F5E),
          isHoliday: true,
        ),
      );
    }
    return list;
  }

  void _addEvent(Event event, DateTime date) {
    final key = _formatDateKey(date);
    setState(() {
      if (_events.containsKey(key)) {
        _events[key]!.add(event);
      } else {
        _events[key] = [event];
      }
    });
  }

  void _deleteEvent(DateTime date, Event eventToDelete) {
    if (eventToDelete.isHoliday) return;
    final key = _formatDateKey(date);
    setState(() {
      _events[key]?.removeWhere((e) => e == eventToDelete);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AGENDA TU DÍA ✨',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.1),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.today),
            tooltip: 'Ir a Hoy',
            onPressed: () {
              setState(() {
                _focusedDate = DateTime.now();
                _selectedDate = DateTime.now();
              });
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFC084FC), Color(0xFFF472B6)], // Degradado lila y rosa tierno
                ),
              ),
              accountName: const Text(
                'Agenda Tu Día',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              accountEmail: const Text('Tu organizador personal 💖'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.favorite,
                  size: 36,
                  color: const Color(0xFFD946EF),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.calendar_month, color: Color(0xFFC084FC)),
              title: const Text('Calendario Completo'),
              selected: _currentViewIndex == 0,
              onTap: () {
                setState(() => _currentViewIndex = 0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.format_list_bulleted, color: Color(0xFFC084FC)),
              title: const Text('Todos los Eventos'),
              selected: _currentViewIndex == 1,
              onTap: () {
                setState(() => _currentViewIndex = 1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.category, color: Color(0xFFC084FC)),
              title: const Text('Categorías'),
              selected: _currentViewIndex == 2,
              onTap: () {
                setState(() => _currentViewIndex = 2);
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.info_outline, color: Color(0xFFF472B6)),
              title: const Text('Acerca de'),
              onTap: () {
                Navigator.pop(context);
                showAboutDialog(
                  context: context,
                  applicationName: 'Agenda Tu Día',
                  applicationVersion: '1.0.0',
                  applicationIcon: const Icon(Icons.favorite, size: 40, color: Color(0xFFD946EF)),
                  children: [
                    const Text('Aplicación tierna diseñada para organizar tus tareas y eventos con amor. 🌷'),
                  ],
                );
              },
            ),
          ],
        ),
      ),
      body: _currentViewIndex == 0
          ? _buildCalendarView()
          : _currentViewIndex == 1
              ? _buildAllEventsView()
              : _buildCategoriesView(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddEventDialog(context),
        icon: const Icon(Icons.add),
        label: const Text('Nuevo Evento'),
        backgroundColor: const Color(0xFFE879F9), // Botón flotante en rosa pastel encendido
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget _buildCalendarView() {
    final months = [
      'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
      'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
    ];

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: const Color(0xFFF3E8FF), // Contenedor muy suave lila
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left, color: Color(0xFF9333EA)),
                  onPressed: () {
                    setState(() {
                      _focusedDate = DateTime(_focusedDate.year, _focusedDate.month - 1, 1);
                    });
                  },
                ),
                Text(
                  "${months[_focusedDate.month - 1]} ${_focusedDate.year}",
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF7E22CE)),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right, color: Color(0xFF9333EA)),
                  onPressed: () {
                    setState(() {
                      _focusedDate = DateTime(_focusedDate.year, _focusedDate.month + 1, 1);
                    });
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Text('Lun', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                Text('Mar', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                Text('Mié', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                Text('Jue', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                Text('Vie', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                Text('Sáb', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFEC4899))), // Sábado rosita
                Text('Dom', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFF43F5E))), // Domingo rojo tierno
              ],
            ),
          ),
          _buildMonthGrid(),
          const Divider(height: 1),
          _buildSelectedDayEventList(),
        ],
      ),
    );
  }

  Widget _buildMonthGrid() {
    final firstDayOfMonth = DateTime(_focusedDate.year, _focusedDate.month, 1);
    final daysInMonth = DateTime(_focusedDate.year, _focusedDate.month + 1, 0).day;
    final startingWeekday = firstDayOfMonth.weekday;

    final List<Widget> dayTiles = [];

    for (int i = 1; i < startingWeekday; i++) {
      dayTiles.add(const SizedBox());
    }

    for (int day = 1; day <= daysInMonth; day++) {
      final date = DateTime(_focusedDate.year, _focusedDate.month, day);
      final key = _formatDateKey(date);
      final isHoliday = _holidays.containsKey(key);

      final isSelected = _selectedDate.year == date.year &&
          _selectedDate.month == date.month &&
          _selectedDate.day == date.day;
      final isToday = DateTime.now().year == date.year &&
          DateTime.now().month == date.month &&
          DateTime.now().day == date.day;

      final dayEvents = _getEventsForDay(date);

      dayTiles.add(
        InkWell(
          onTap: () {
            setState(() {
              _selectedDate = date;
            });
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFFD946EF) // Fucsia/Rosa tierno seleccionado
                  : isHoliday
                      ? const Color(0xFFFFE4E6) // Fondo rosita claro para festivos
                      : isToday
                          ? const Color(0xFFF3E8FF)
                          : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: isToday && !isSelected
                  ? Border.all(color: const Color(0xFFC084FC), width: 2)
                  : isHoliday && !isSelected
                      ? Border.all(color: const Color(0xFFFDA4AF), width: 1)
                      : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$day',
                  style: TextStyle(
                    fontWeight: isSelected || isToday || isHoliday ? FontWeight.bold : FontWeight.normal,
                    color: isSelected
                        ? Colors.white
                        : isHoliday
                            ? const Color(0xFFBE123C)
                            : (date.weekday == 7 ? const Color(0xFFF43F5E) : Colors.black87),
                  ),
                ),
                if (dayEvents.isNotEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: dayEvents.take(3).map((e) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 1),
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected ? Colors.white : e.color,
                        ),
                      );
                    }).toList(),
                  ),
              ],
            ),
          ),
        ),
      );
    }

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 7,
      childAspectRatio: 1.1,
      children: dayTiles,
    );
  }

  Widget _buildSelectedDayEventList() {
    final events = _getEventsForDay(_selectedDate);

    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Eventos del ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF7E22CE)),
              ),
              Text(
                '${events.length} evento(s)',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
          const SizedBox(height: 10),
          events.isEmpty
              ? const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.favorite_border, size: 40, color: Color(0xFFF472B6)),
                        SizedBox(height: 8),
                        Text(
                          'No hay eventos programados para este día 🌸',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final event = events[index];
                    return Card(
                      color: event.isHoliday ? const Color(0xFFFFE4E6) : const Color(0xFFFAF5FF),
                      elevation: 1,
                      margin: const EdgeInsets.only(bottom: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: event.color.withOpacity(0.2),
                          child: Icon(
                            event.isHoliday ? Icons.favorite : Icons.star,
                            color: event.color,
                          ),
                        ),
                        title: Text(
                          event.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: event.isHoliday ? const Color(0xFF9F1239) : const Color(0xFF6B21A8),
                          ),
                        ),
                        subtitle: Text('${event.time} • ${event.description}', style: const TextStyle(color: Colors.black87)),
                        trailing: event.isHoliday
                            ? null
                            : IconButton(
                                icon: const Icon(Icons.delete_outline, color: Color(0xFFF43F5E)),
                                onPressed: () => _deleteEvent(_selectedDate, event),
                              ),
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }

  Widget _buildAllEventsView() {
    final List<MapEntry<String, Event>> allList = [];
    _events.forEach((dateKey, list) {
      for (var event in list) {
        allList.add(MapEntry(dateKey, event));
      }
    });

    if (allList.isEmpty) {
      return const Center(
        child: Text(
          'No hay ningún evento personal registrado. 🌷',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: allList.length,
      itemBuilder: (context, index) {
        final item = allList[index];
        return Card(
          color: const Color(0xFFFAF5FF),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: Icon(Icons.favorite, color: item.value.color),
            title: Text(item.value.title, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF6B21A8))),
            subtitle: Text('Fecha: ${item.key} | Hora: ${item.value.time}\n${item.value.description}'),
          ),
        );
      },
    );
  }

  Widget _buildCategoriesView() {
    // Categorías con colores pasteles súper tiernos
    final categories = [
      {'name': 'Trabajo', 'color': const Color(0xFF60A5FA), 'icon': Icons.work},       // Azul pastel
      {'name': 'Personal', 'color': const Color(0xFF34D399), 'icon': Icons.person},     // Verde menta pastel
      {'name': 'Estudio', 'color': const Color(0xFFFBBF24), 'icon': Icons.school},     // Amarillo pastel
      {'name': 'Salud', 'color': const Color(0xFFF43F5E), 'icon': Icons.favorite},     // Rosa tierno
      {'name': 'Festivos', 'color': const Color(0xFFC084FC), 'icon': Icons.star},      // Lila pastel
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final cat = categories[index];
        final color = cat['color'] as Color;
        return Card(
          elevation: 2,
          color: color.withOpacity(0.15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(cat['icon'] as IconData, size: 48, color: color),
                const SizedBox(height: 8),
                Text(
                  cat['name'] as String,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showAddEventDialog(BuildContext context) {
    final titleController = TextEditingController();
    final descController = TextEditingController();
    TimeOfDay selectedTime = TimeOfDay.now();
    String selectedCat = 'Personal';
    Color selectedColor = const Color(0xFF34D399);

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              title: Text(
                'Nuevo Evento ✨\n(${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year})',
                style: const TextStyle(fontSize: 18, color: Color(0xFF7E22CE)),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        labelText: 'Título del Evento',
                        prefixIcon: const Icon(Icons.edit, color: Color(0xFFC084FC)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: descController,
                      decoration: InputDecoration(
                        labelText: 'Descripción',
                        prefixIcon: const Icon(Icons.notes, color: Color(0xFFC084FC)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: selectedCat,
                      items: ['Trabajo', 'Personal', 'Estudio', 'Salud']
                          .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                          .toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setStateDialog(() {
                            selectedCat = val;
                            if (val == 'Trabajo') selectedColor = const Color(0xFF60A5FA);
                            if (val == 'Personal') selectedColor = const Color(0xFF34D399);
                            if (val == 'Estudio') selectedColor = const Color(0xFFFBBF24);
                            if (val == 'Salud') selectedColor = const Color(0xFFF43F5E);
                          });
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Categoría',
                        prefixIcon: const Icon(Icons.category, color: Color(0xFFC084FC)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Selector de hora interactivo tierno
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        side: const BorderSide(color: Color(0xFFC084FC)),
                      ),
                      icon: const Icon(Icons.access_time, color: Color(0xFF9333EA)),
                      label: Text(
                        'Hora: ${selectedTime.format(context)}',
                        style: const TextStyle(fontSize: 16, color: Color(0xFF7E22CE)),
                      ),
                      onPressed: () async {
                        final TimeOfDay? timePicked = await showTimePicker(
                          context: context,
                          initialTime: selectedTime,
                        );
                        if (timePicked != null) {
                          setStateDialog(() {
                            selectedTime = timePicked;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar', style: TextStyle(color: Colors.grey)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD946EF),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    if (titleController.text.isNotEmpty) {
                      _addEvent(
                        Event(
                          title: titleController.text,
                          description: descController.text,
                          time: selectedTime.format(context),
                          category: selectedCat,
                          color: selectedColor,
                        ),
                        _selectedDate,
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Guardar 💖'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

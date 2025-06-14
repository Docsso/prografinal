import 'package:flutter/material.dart';
import '../data/medicamento_db.dart';
import '../data/medicamento_model.dart';
import 'form_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Medicamento> _medicamentos = [];

  @override
  void initState() {
    super.initState();
    _loadMedicamentos();
  }

  Future<void> _loadMedicamentos() async {
    final datos = await MedicamentoDB().getMedicamentos();
    setState(() {
      _medicamentos = datos;
    });
  }

  void _irFormulario([Medicamento? m]) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FormPage(medicamento: m),
      ),
    );
    _loadMedicamentos(); // recargar lista
  }

  void _eliminar(int id) async {
    await MedicamentoDB().deleteMedicamento(id);
    _loadMedicamentos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mis Medicamentos')),
      body: ListView.builder(
        itemCount: _medicamentos.length,
        itemBuilder: (context, index) {
          final m = _medicamentos[index];
          return ListTile(
            title: Text(m.nombre),
            subtitle: Text('${m.dosis} | ${m.frecuencia} | ${m.hora}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _irFormulario(m),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _eliminar(m.id!),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _irFormulario(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

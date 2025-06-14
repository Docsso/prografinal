import 'package:flutter/material.dart';
import '../data/medicamento_model.dart';
import '../data/medicamento_db.dart';
import '../core/notification_service.dart';

class FormPage extends StatefulWidget {
  final Medicamento? medicamento;
  const FormPage({super.key, this.medicamento});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nombreController;
  late TextEditingController _dosisController;
  late TextEditingController _frecuenciaController;
  late TextEditingController _horaController;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.medicamento?.nombre ?? '');
    _dosisController = TextEditingController(text: widget.medicamento?.dosis ?? '');
    _frecuenciaController = TextEditingController(text: widget.medicamento?.frecuencia ?? '');
    _horaController = TextEditingController(text: widget.medicamento?.hora ?? '');
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _dosisController.dispose();
    _frecuenciaController.dispose();
    _horaController.dispose();
    super.dispose();
  }

  void _guardar() async {
    if (_formKey.currentState!.validate()) {
      final nuevo = Medicamento(
        id: widget.medicamento?.id,
        nombre: _nombreController.text,
        dosis: _dosisController.text,
        frecuencia: _frecuenciaController.text,
        hora: _horaController.text,
      );

      if (widget.medicamento == null) {
        await MedicamentoDB().insertMedicamento(nuevo);
        await NotificationService().showNotification(
          title: 'Medicamento agregado',
          body: 'Se ha registrado ${nuevo.nombre}',
        );
      } else {
        await MedicamentoDB().updateMedicamento(nuevo);
        await NotificationService().showNotification(
          title: 'Medicamento actualizado',
          body: 'Has editado ${nuevo.nombre}',
        );
      }

      if (mounted) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.medicamento == null ? 'Nuevo Medicamento' : 'Editar Medicamento')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
              ),
              TextFormField(
                controller: _dosisController,
                decoration: const InputDecoration(labelText: 'Dosis'),
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
              ),
              TextFormField(
                controller: _frecuenciaController,
                decoration: const InputDecoration(labelText: 'Frecuencia'),
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
              ),
              TextFormField(
                controller: _horaController,
                decoration: const InputDecoration(labelText: 'Hora'),
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _guardar,
                child: const Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

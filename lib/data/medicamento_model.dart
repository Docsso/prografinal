class Medicamento {
  final int? id;
  final String nombre;
  final String dosis;
  final String frecuencia;
  final String hora;

  Medicamento({
    this.id,
    required this.nombre,
    required this.dosis,
    required this.frecuencia,
    required this.hora,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'dosis': dosis,
      'frecuencia': frecuencia,
      'hora': hora,
    };
  }

  factory Medicamento.fromMap(Map<String, dynamic> map) {
    return Medicamento(
      id: map['id'],
      nombre: map['nombre'],
      dosis: map['dosis'],
      frecuencia: map['frecuencia'],
      hora: map['hora'],
    );
  }
}

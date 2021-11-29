import 'dart:convert';

class VisitaDAO {
  VisitaDAO({
    this.visitanteTitular,
    this.numeroPersonas,
    this.calle,
    this.numero,
    this.fecha,
    this.formaLlegada,
    this.status
  });

  String? visitanteTitular;
  int? numeroPersonas;
  String? calle;
  String? numero;
  String? fecha;
  String? formaLlegada;
  int? status;

  Map<String, dynamic> toMap() {
    return {
      'visitanteTitular': visitanteTitular,
      'numeroPersonas': numeroPersonas,
      'calle': calle,
      'numero': numero,
      'fecha': fecha,
      'formaLlegada': formaLlegada,
      'status': status
    };
  }

  factory VisitaDAO.fromJson(String str) => VisitaDAO.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VisitaDAO.fromMap(Map<String, dynamic> json) => VisitaDAO(
    visitanteTitular: json['visitanteTitular'] as String,
    numeroPersonas: json['numeroPersonas'] as int,
    calle: json['calle'] as String,
    numero: json['numero'] as String,
    fecha: json['fecha'] as String,
    formaLlegada: json['formaLlegada'] as String,
    status: json['status'] as int
  );
}

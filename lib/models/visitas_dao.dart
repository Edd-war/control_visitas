class VisitaDAO {
  String? visitanteTitular;
  int? numeroPersonas;
  String? calle;
  String? numero;
  String? fecha;
  String? formaLlegada;
  int? status;

  VisitaDAO(
      {this.visitanteTitular,
      this.numeroPersonas,
      this.calle,
      this.numero,
      this.fecha,
      this.formaLlegada,
      this.status});

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
}

class InputAzioneDto {
  final int? id;
  final int idSegnalazione;
  final int idStato;
  final String nomeAzione;
  final String descrizione;
  final DateTime dataAzione;
  final DateTime? dataModifica;
  final DateTime? dataChiusura;

  const InputAzioneDto({
    this.id,
    required this.idSegnalazione,
    required this.idStato,
    required this.nomeAzione,
    required this.descrizione,
    required this.dataAzione,
    this.dataModifica,
    this.dataChiusura,
  });

  factory InputAzioneDto.fromJson(Map<String, dynamic> json) {
    return InputAzioneDto(
      id: json['id'],
      idSegnalazione: json['idSegnalazione'],
      idStato: json['idStato'],
      nomeAzione: json['nomeAzione'],
      descrizione: json['descrizione'],
      dataAzione: DateTime.parse(json['dataAzione']),
      dataModifica: DateTime.parse(json['dataModifica']),
      dataChiusura: DateTime.parse(json['dataChiusura']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idSegnalazione': idSegnalazione,
      'idStato': idStato,
      'nomeAzione': nomeAzione,
      'descrizione': descrizione,
      'dataAzione': dataAzione.toIso8601String().split('T').first,
      'dataModifica': dataModifica?.toIso8601String().split('T').first,
      'dataChiusura': dataChiusura?.toIso8601String().split('T').first,
    };
  }
}

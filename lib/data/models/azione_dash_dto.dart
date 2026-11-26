class AzioneDashDto {
  final int id;
  final int idSegnalazione;
  final int idStato;

  final String nomeAzione;
  final String descrizioneSegnalazione;
  final String? descrizione;

  final DateTime dataAzione;
  final DateTime? dataModifica;
  final DateTime? dataChiusura;

  const AzioneDashDto({
    required this.id,
    required this.idSegnalazione,
    required this.idStato,
    required this.nomeAzione,
    required this.descrizioneSegnalazione,
    this.descrizione,
    required this.dataAzione,
    this.dataModifica,
    this.dataChiusura,
  });

  factory AzioneDashDto.fromJson(Map<String, dynamic> json) {
    return AzioneDashDto(
      id: json['id'],
      idSegnalazione: json['idSegnalazione'],
      idStato: json['idStato'],
      nomeAzione: json['nomeAzione'],
      descrizioneSegnalazione: json['descrizioneSegnalazione'],
      dataAzione: DateTime.parse(json['dataAzione']),

      descrizione: json['descrizione'],
      dataModifica: DateTime.parse(json['dataModifica']),
      dataChiusura: DateTime.parse(json['dataChiusura']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idStato': idStato,
      'idSegnalazione': idSegnalazione,
      'nomeAzione': nomeAzione,
      'descrizioneSegnalazione': descrizioneSegnalazione,
      'dataAzione': dataAzione.toIso8601String().split('T').first,

      'descrizione': descrizione,
      'dataModifica': dataModifica?.toIso8601String().split('T').first,
      'dataChiusura': dataChiusura?.toIso8601String().split('T').first,
    };
  }
}

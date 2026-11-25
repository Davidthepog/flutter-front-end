class PostAzioneDto {
  final int idSegnalazione;
  final int idStato;
  final String nomeAzione;
  final String? descrizione;
  final DateTime dataAzione;

  const PostAzioneDto({
    required this.idSegnalazione,
    required this.idStato,
    required this.nomeAzione,
    this.descrizione,
    required this.dataAzione,
  });

  factory PostAzioneDto.fromJson(Map<String, dynamic> json) {
    return PostAzioneDto(
      idSegnalazione: json['idSegnalazione'],
      idStato: json['idStato'],
      nomeAzione: json['nomeAzione'],
      dataAzione: DateTime.parse(json['dataAzione']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idSegnalazione': idSegnalazione,
      'idStato': idStato,
      'nomeAzione': nomeAzione,
      'descrizione': descrizione,
      'dataAzione': dataAzione.toIso8601String().split('T').first,
    };
  }
}

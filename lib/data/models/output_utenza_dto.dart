class OutputUtenzaDto {
  final int id;
  final int idRuolo;
  final String cognome;
  final String nome;
  final String codiceFiscale;
  final String email;
  final String ruolo;

  const OutputUtenzaDto({
    required this.id,
    required this.idRuolo,
    required this.cognome,
    required this.nome,
    required this.codiceFiscale,
    required this.email,
    required this.ruolo,
  });

  factory OutputUtenzaDto.fromJson(Map<String, dynamic> json) {
    return OutputUtenzaDto(
      id: json['id'],
      idRuolo: json['idRuolo'],
      cognome: json['cognome'],
      nome: json['nome'],
      codiceFiscale: json['codiceFiscale'],
      email: json['email'],
      ruolo: json['ruolo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idRuolo': idRuolo,
      'cognome': cognome,
      'nome': nome,
      'codiceFiscale': codiceFiscale,
      'email': email,
      'ruolo': ruolo,
    };
  }
}

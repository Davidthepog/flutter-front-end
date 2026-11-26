class InputUtenzaDto {
  final int? id;
  final int idRuolo;
  final String cognome;
  final String nome;
  final String codiceFiscale;
  final String email;

  const InputUtenzaDto({
    this.id,
    required this.idRuolo,
    required this.codiceFiscale,
    required this.cognome,
    required this.email,
    required this.nome,
  });

  factory InputUtenzaDto.fromJson(Map<String, dynamic> json) {
    return InputUtenzaDto(
      id: json['id'],
      idRuolo: json['idRuolo'],
      codiceFiscale: json['codiceFiscale'],
      cognome: json['cognome'],
      email: json['email'],
      nome: json['nome'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idRuolo': idRuolo,
      'codiceFiscale': codiceFiscale,
      'cognome': cognome,
      'email': email,
      'nome': nome,
    };
  }
}

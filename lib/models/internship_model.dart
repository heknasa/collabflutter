class InternshipModel {
  int id;
  String position;
  String company;
  Map<int, String?> role;
  Map<int, String?> qualification;
  String companyProfile;
  String link;

  InternshipModel({
    required this.id,
    required this.position,
    required this.company,
    required this.role,
    required this.qualification,
    required this.companyProfile,
    required this.link
  });

  factory InternshipModel.fromGsheets(Map<String, dynamic> json) {
    return InternshipModel(
      id: int.tryParse(json['id'])!,
      position: json['position'],
      company: json['company'],
      role: {
        1: json['role1'],
        2: json['role2'],
        3: json['role3'],
        4: json['role4'],
        5: json['role5']
      },
      qualification: {
        1: json['qualification1'],
        2: json['qualification2'],
        3: json['qualification3'],
        4: json['qualification4'],
        5: json['qualification5']
      },
      companyProfile: json['companyProfile'],
      link: json['link'],
    );
  }

  Map<String, dynamic> toGsheets() {
    return {
      'id': id,
      'position': position,
      'company': company,
      'role': role,
      'qualification': qualification,
      'companyProfile': companyProfile,
      'link': link,
    };
  }
}
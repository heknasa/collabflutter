class InternshipModel {
  int id;
  String position, company;
  String? role1, role2, role3, role4, role5;
  String? qualification1, qualification2, qualification3, qualification4, qualification5;
  String companyProfile;
  String link;

  InternshipModel({
    required this.id,
    required this.position, required this.company,
    this.role1, this.role2, this.role3, this.role4, this.role5,
    this.qualification1, this.qualification2, this.qualification3, this.qualification4, this.qualification5,
    required this.companyProfile,
    required this.link
  });

  factory InternshipModel.fromGsheets(Map<String, dynamic> json) {
    return InternshipModel(
      id: int.tryParse(json['id'])!,
      position: json['position'],
      company: json['company'],
      role1: json['role1'],
      role2: json['role2'],
      role3: json['role3'],
      role4: json['role4'],
      role5: json['role5'],
      qualification1: json['qualification1'],
      qualification2: json['qualification2'],
      qualification3: json['qualification3'],
      qualification4: json['qualification4'],
      qualification5: json['qualification5'],
      companyProfile: json['companyProfile'],
      link: json['link'],
    );
  }

  Map<String, dynamic> toGsheets() {
    return {
      'id': id,
      'position': position,
      'company': company,
      'role1': role1,
      'role2': role2,
      'role3': role3,
      'role4': role4,
      'role5': role5,
      'qualification1': qualification1,
      'qualification2': qualification2,
      'qualification3': qualification3,
      'qualification4': qualification4,
      'qualification5': qualification5,
      'companyProfile': companyProfile,
      'link': link,
    };
  }
}
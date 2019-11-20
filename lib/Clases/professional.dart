class Professional{
  final int id;
  final int companyid;
  final String cpf;
  final String rg;
  final String cro;
  final String name;
  final String nickname;
  final String birtdate;
  final String sex;
  final String civilstatus;
  final String mission;
  final String salary;
  final bool active;
  final int licenceid;
  final String createdat;
  final String updateat; 
  final bool canuseappointment;
  final String order;
  final String importationid;
  final int userid;
  final String professionaltype;
  final bool professionalhasaccess;
  final String color;
  final String commissionvalue;
  final String commissionpercentage;
  final String commissiontype;
  final String avatar; 
  
  Professional({this.id, this.companyid, this.cpf, this.rg, this.cro, this.name, this.nickname, this.birtdate, this.sex, this.civilstatus, this.mission, this.salary, this.active, this.licenceid, this.createdat, this.updateat, this.canuseappointment, this.order, this.importationid, this.userid, this.professionaltype, this.professionalhasaccess, this.color, this.commissionvalue, this.commissionpercentage, this.commissiontype, this.avatar, });

  factory Professional.fromJson(Map<String, dynamic> json) {
    return Professional(
      id: json["id"] as int,
      companyid: json["company_id"] as int,
      cpf: json['cpf'] as String,
      cro: json['cro'] as String,
      name: json['name'] as String,
      birtdate: json['birt_date'] as String,
      sex: json['sex'] as String,
      civilstatus: json['civil_status'] as String,
      mission: json['mission'] as String,
      salary: json['salary'] as String,
      active: json['active'] as bool,
      licenceid: json['licence_id'] as int,
      createdat: json['created_at'] as String,
      updateat: json['update_at'] as String,
      canuseappointment: json['can_use_appointment'] as bool,
      order: json['order'] as String,
      importationid: json['importation_id'] as String,
      userid: json['user_id'] as int,
      professionaltype: json['professional_type'] as String,
      professionalhasaccess: json['professional_has_access'] as bool,
      color: json['color'] as String,
      commissionvalue: json['commission_value'] as String,
      commissionpercentage: json['commission_percentage'] as String,
      commissiontype: json['commission_type'] as String
    );
  }
}

class User{
  final bool active;
  final int id;
  final String email;
  final String uid;
  final String provider;
  final String name;
  final int licenceid;
  final String createdat;
  final String updateat;
  final int companyid;
  final int accessruleid;
  final String theme;
  final bool root;

  User({this.active, this.id, this.email, this.uid, this.provider, this.name, this.licenceid, this.createdat, this.updateat, this.companyid, this.accessruleid, this.theme, this.root, });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      active: json['active'] as bool,
      id: json['id'] as int,
      email: json['email'] as String,
      uid: json['uid'] as String,
      provider: json['provider'] as String,
      name: json['name'] as String,
      licenceid: json['licence_id'] as int,
      createdat: json['created_at'] as String,
      updateat: json['update_at'] as String,
      companyid: json['company_id'] as int,
      accessruleid: json['access_rule_id'] as int,
      theme: json['theme'] as String,
      root: json['root'] as bool
    );
  }  
}
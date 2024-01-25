// To parse this JSON data, do
//
//     final createResume = createResumeFromJson(jsonString);

import 'dart:convert';

CreateResume createResumeFromJson(String str) => CreateResume.fromJson(json.decode(str));

String createResumeToJson(CreateResume data) => json.encode(data.toJson());

class CreateResume {
  String id;
  String resumeId;
  String resumeName;
  String mail;
  String resumeType;
  String userId;
  List<FullResume> fullResume;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String thumbnail;

  CreateResume({
    required this.id,
    required this.resumeId,
    required this.resumeName,
    required this.mail,
    required this.resumeType,
    required this.userId,
    required this.fullResume,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.thumbnail,
  });

  factory CreateResume.fromJson(Map<String, dynamic> json) => CreateResume(
    id: json["_id"],
    resumeId: json["resumeId"],
    resumeName: json["resume_name"],
    mail: json["mail"],
    resumeType: json["resume_type"],
    userId: json["userId"],
    fullResume: List<FullResume>.from(json["full_resume"].map((x) => FullResume.fromJson(x))),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    thumbnail: json["thumbnail"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "resumeId": resumeId,
    "resume_name": resumeName,
    "mail": mail,
    "resume_type": resumeType,
    "userId": userId,
    "full_resume": List<dynamic>.from(fullResume.map((x) => x.toJson())),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
    "thumbnail": thumbnail,
  };
}

class FullResume {
  String sectionId;
  String sectionName;
  ResumeDetails? resumeDetails;
  dynamic details;

  FullResume({
    required this.sectionId,
    required this.sectionName,
    this.resumeDetails,
    this.details,
  });

  factory FullResume.fromJson(Map<String, dynamic> json) => FullResume(
    sectionId: json["section_id"],
    sectionName: json["section_name"],
    resumeDetails: json["resume_details"] == null ? null : ResumeDetails.fromJson(json["resume_details"]),
    details: json["details"],
  );

  Map<String, dynamic> toJson() => {
    "section_id": sectionId,
    "section_name": sectionName,
    "resume_details": resumeDetails?.toJson(),
    "details": details,
  };
}

class Detail {
  String? jobTitle;
  String? employer;
  String? startDate;
  String? endDate;
  String? city;
  String? description;
  String? school;
  String? degree;
  String? label;
  String? link;
  bool? hideExperience;
  List<Skill>? skills;
  String? course;
  String? institution;
  String? functionTitle;
  String? hobbies;
  bool? hideReference;
  List<Reference>? references;
  String? name;

  Detail({
    this.jobTitle,
    this.employer,
    this.startDate,
    this.endDate,
    this.city,
    this.description,
    this.school,
    this.degree,
    this.label,
    this.link,
    this.hideExperience,
    this.skills,
    this.course,
    this.institution,
    this.functionTitle,
    this.hobbies,
    this.hideReference,
    this.references,
    this.name,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    jobTitle: json["job_title"],
    employer: json["employer"],
    startDate: json["start_date"],
    endDate: json["end_date"],
    city: json["city"],
    description: json["description"],
    school: json["school"],
    degree: json["degree"],
    label: json["label"],
    link: json["link"],
    hideExperience: json["hide_experience"],
    skills: json["skills"] == null ? [] : List<Skill>.from(json["skills"]!.map((x) => Skill.fromJson(x))),
    course: json["course"],
    institution: json["institution"],
    functionTitle: json["function_title"],
    hobbies: json["hobbies"],
    hideReference: json["hide_reference"],
    references: json["references"] == null ? [] : List<Reference>.from(json["references"]!.map((x) => Reference.fromJson(x))),
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "job_title": jobTitle,
    "employer": employer,
    "start_date": startDate,
    "end_date": endDate,
    "city": city,
    "description": description,
    "school": school,
    "degree": degree,
    "label": label,
    "link": link,
    "hide_experience": hideExperience,
    "skills": skills == null ? [] : List<dynamic>.from(skills!.map((x) => x.toJson())),
    "course": course,
    "institution": institution,
    "function_title": functionTitle,
    "hobbies": hobbies,
    "hide_reference": hideReference,
    "references": references == null ? [] : List<dynamic>.from(references!.map((x) => x.toJson())),
    "name": name,
  };
}

class Reference {
  String referentName;
  String company;
  String phone;
  String email;

  Reference({
    required this.referentName,
    required this.company,
    required this.phone,
    required this.email,
  });

  factory Reference.fromJson(Map<String, dynamic> json) => Reference(
    referentName: json["referent_name"],
    company: json["company"],
    phone: json["phone"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "referent_name": referentName,
    "company": company,
    "phone": phone,
    "email": email,
  };
}

class Skill {
  String skill;
  String level;

  Skill({
    required this.skill,
    required this.level,
  });

  factory Skill.fromJson(Map<String, dynamic> json) => Skill(
    skill: json["skill"],
    level: json["level"],
  );

  Map<String, dynamic> toJson() => {
    "skill": skill,
    "level": level,
  };
}

class DetailsClass {
  String? professionalSummary;
  bool? languageLevelShow;
  List<Language>? languages;

  DetailsClass({
    this.professionalSummary,
    this.languageLevelShow,
    this.languages,
  });

  factory DetailsClass.fromJson(Map<String, dynamic> json) => DetailsClass(
    professionalSummary: json["professional_summary"],
    languageLevelShow: json["language_level_show"],
    languages: json["languages"] == null ? [] : List<Language>.from(json["languages"]!.map((x) => Language.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "professional_summary": professionalSummary,
    "language_level_show": languageLevelShow,
    "languages": languages == null ? [] : List<dynamic>.from(languages!.map((x) => x.toJson())),
  };
}

class Language {
  String language;
  String level;

  Language({
    required this.language,
    required this.level,
  });

  factory Language.fromJson(Map<String, dynamic> json) => Language(
    language: json["language"],
    level: json["level"],
  );

  Map<String, dynamic> toJson() => {
    "language": language,
    "level": level,
  };
}

class ResumeDetails {
  String jobTitle;
  String photo;
  String firstName;
  String lastName;
  String email;
  String phone;
  String country;
  String city;
  String address;
  String postalCode;
  String drivingLicense;
  String nationality;
  String placeOfBirth;
  String dateOfBirth;
  String photoId;

  ResumeDetails({
    required this.jobTitle,
    required this.photo,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.country,
    required this.city,
    required this.address,
    required this.postalCode,
    required this.drivingLicense,
    required this.nationality,
    required this.placeOfBirth,
    required this.dateOfBirth,
    required this.photoId,
  });

  factory ResumeDetails.fromJson(Map<String, dynamic> json) => ResumeDetails(
    jobTitle: json["job_title"],
    photo: json["photo"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    phone: json["phone"],
    country: json["country"],
    city: json["city"],
    address: json["address"],
    postalCode: json["postal_code"],
    drivingLicense: json["driving_license"],
    nationality: json["nationality"],
    placeOfBirth: json["place_of_birth"],
    dateOfBirth: json["date_of_birth"],
    photoId: json["photo_id"],
  );

  Map<String, dynamic> toJson() => {
    "job_title": jobTitle,
    "photo": photo,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "phone": phone,
    "country": country,
    "city": city,
    "address": address,
    "postal_code": postalCode,
    "driving_license": drivingLicense,
    "nationality": nationality,
    "place_of_birth": placeOfBirth,
    "date_of_birth": dateOfBirth,
    "photo_id": photoId,
  };
}

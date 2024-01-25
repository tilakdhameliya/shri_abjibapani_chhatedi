class MagazinesModel {
  List<MurtiMagazines>? murtiMagazines;

  MagazinesModel({this.murtiMagazines});

  MagazinesModel.fromJson(Map<String, dynamic> json) {
    if (json['murti_magazines'] != null) {
      murtiMagazines = <MurtiMagazines>[];
      json['murti_magazines'].forEach((v) {
        murtiMagazines!.add(MurtiMagazines.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (murtiMagazines != null) {
      data['murti_magazines'] =
          murtiMagazines!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MurtiMagazines {
  String? name;
  String? url;

  MurtiMagazines({this.name, this.url});

  MurtiMagazines.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    return data;
  }
}

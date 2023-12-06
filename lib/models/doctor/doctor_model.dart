class Doctor {
  final String? id;
  final String? name;
  final String? spec;
  final String? location;

  const Doctor({this.id, this.name, this.spec, this.location});

  factory Doctor.fromJson(Map<String, dynamic>? data) {
    return Doctor(
      id: data?['id'],
      name: data?['name'],
      spec: data?['spec'],
      location: data?['location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "spec": spec,
      "location": location,
    };
  }
}

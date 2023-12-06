class Booking {
  final String? name;
  final String? number;
  final String? date;
  final String? doctor;

  const Booking({
    this.name,
    this.number,
    this.date,
    this.doctor,
  });

  factory Booking.fromJson(Map<String, dynamic>? data) {
    return Booking(
      name: data?['name'],
      number: data?['number'],
      date: data?['date'],
      doctor: data?['doctor'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'number': number,
      'date': date,
      'doctor': doctor,
    };
  }
}

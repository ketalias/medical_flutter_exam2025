class DoctorModel {
  final String id;
  final String fullName;
  final String specialty;
  final String imageUrl;
  final String? location;
  final int likes;

  DoctorModel({
    required this.id,
    required this.fullName,
    required this.specialty,
    required this.imageUrl,
    this.location,
    this.likes = 0,
  });
}

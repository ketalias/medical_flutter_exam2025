import 'doctor_model.dart';

enum SearchItemType { doctor, service, symptom }

/// Interface for anything that can be put into the Search Tree
abstract class SearchableItem {
  String get id;
  String get title;       // Doctor Name or Symptom Name
  String get subtitle;    // Specialty or Description
  SearchItemType get type;
}

/// Wrapper for your existing DoctorModel
class SearchableDoctor implements SearchableItem {
  final DoctorModel doctor;

  SearchableDoctor(this.doctor);

  @override
  String get id => doctor.id;
  
  @override
  String get title => doctor.fullName;
  
  @override
  String get subtitle => doctor.specialty; // e.g. "ЛОР"

  @override
  SearchItemType get type => SearchItemType.doctor;
}

/// New Model for Symptoms (The Routing Logic)
class Symptom implements SearchableItem {
  final String id;
  final String name;           // e.g. "Біль у вусі"
  final String targetCategory; // e.g. "ЛОР" (Must match your category names exactly)

  Symptom({
    required this.id, 
    required this.name, 
    required this.targetCategory
  });

  @override
  String get title => name;

  @override
  String get subtitle => "Рекомендовано: $targetCategory";

  @override
  SearchItemType get type => SearchItemType.symptom;
}

/// (Optional) Services if you still need them
class MedicalService implements SearchableItem {
  final String id;
  final String name;
  final String description;

  MedicalService({required this.id, required this.name, required this.description});

  @override
  String get title => name;

  @override
  String get subtitle => description;

  @override
  SearchItemType get type => SearchItemType.service;
}
import 'doctor_model.dart';

enum SearchItemType { doctor, service, symptom }

/// Interface for anything that can be put into the Search Tree
abstract class SearchableItem {
  String get id;
  String get title;       // Doctor Name or Symptom Name
  String get subtitle;    // Specialty or Description
  SearchItemType get type;
  int get score;          // NEW: Used to sort by "Most Probable"
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
  String get subtitle => doctor.specialty; 

  @override
  SearchItemType get type => SearchItemType.doctor;

  // We use the doctor's 'likes' as their popularity score
  @override
  int get score => doctor.likes; 
}

/// Model for Symptoms (The Routing Logic)
class Symptom implements SearchableItem {
  final String id;
  final String name;           
  final String targetCategory; 
  final int popularity; // NEW: Allows manual ranking of common symptoms

  Symptom({
    required this.id, 
    required this.name, 
    required this.targetCategory,
    this.popularity = 50, // Default mid-range score
  });

  @override
  String get title => name;

  @override
  String get subtitle => "Рекомендовано: $targetCategory";

  @override
  SearchItemType get type => SearchItemType.symptom;

  @override
  int get score => popularity;
}

/// (Optional) Services
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

  @override
  int get score => 10; // Lower priority than doctors or symptoms
}
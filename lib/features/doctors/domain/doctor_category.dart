class DoctorCategory {
  final String id;
  final String name;
  final String iconPath;

  DoctorCategory({
    required this.id,
    required this.name,
    required this.iconPath,
  });
}

final List<DoctorCategory> doctorCategories = [
  DoctorCategory(
    id: '1',
    name: 'Терапевт',
    iconPath: 'assets/icons/Терапевт.svg',
  ),
  DoctorCategory(
    id: '2',
    name: 'Педіатр',
    iconPath: 'assets/icons/Педіатр.svg',
  ),
  DoctorCategory(
    id: '3',
    name: 'Кардіолог',
    iconPath: 'assets/icons/Кардіолог.svg',
  ),
  DoctorCategory(
    id: '4',
    name: 'Невролог',
    iconPath: 'assets/icons/Невролог.svg',
  ),
  DoctorCategory(
    id: '5',
    name: 'Гінеколог',
    iconPath: 'assets/icons/Гінеколог.svg',
  ),
  DoctorCategory(id: '6', name: 'Уролог', iconPath: 'assets/icons/Уролог.svg'),
  DoctorCategory(id: '7', name: 'ЛОР', iconPath: 'assets/icons/ЛОР.svg'),
  DoctorCategory(
    id: '8',
    name: 'Офтальмолог',
    iconPath: 'assets/icons/Офтальмолог.svg',
  ),
  DoctorCategory(
    id: '10',
    name: 'Дерматолог',
    iconPath: 'assets/icons/Дерматолог.svg',
  ),
];

class LanguagesList {
  final String name;
  final String icon;
  final bool isActive;

  LanguagesList({this.name, this.icon, this.isActive});
}

final List<LanguagesList> languagesList = [
  LanguagesList(
    name: 'Spanich',
    icon: 'assets/icons/spain.svg',
    isActive: true,
  ),
  LanguagesList(
    name: 'French',
    icon: 'assets/icons/france.svg',
    isActive: false,
  ),
  LanguagesList(
    name: 'Arabic',
    icon: 'assets/icons/saudi-arabia.svg',
    isActive: false,
  ),
  LanguagesList(
    name: 'Chinese',
    icon: 'assets/icons/china.svg',
    isActive: false,
  ),
];

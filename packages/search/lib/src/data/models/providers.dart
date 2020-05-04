class Provider {
  final String name;

  Provider(this.name);

  Provider.fromJson(Map<String, dynamic> json) : name = json['name'];
}

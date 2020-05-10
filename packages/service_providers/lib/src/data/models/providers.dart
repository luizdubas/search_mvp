class Provider {
  final String name;

  const Provider({this.name});

  Provider.fromJson(Map<String, dynamic> json) : name = json['name'];
}

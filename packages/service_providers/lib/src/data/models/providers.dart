class Provider {
  final String name;

  const Provider({this.name}) : assert(name != null);

  Provider.fromJson(Map<String, dynamic> json) : this(name: json['name']);
}

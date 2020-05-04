class Providers {
  final List<Provider> providers;

  Providers(this.providers);

  Providers.fromJson(Map<String, dynamic> json)
      : providers = json.values
            .map((value) => Provider.fromJson(value as Map<String, dynamic>));
}

class Provider {
  final String name;

  Provider(this.name);

  Provider.fromJson(Map<String, dynamic> json) : name = json['name'];
}

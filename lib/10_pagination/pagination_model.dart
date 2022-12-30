abstract class IModelWithID {
  final String id;

  IModelWithID({
    required this.id,
  });
}

class IPhoneModel implements IModelWithID {
  @override
  final String id;

  final String name;

  IPhoneModel({
    required this.id,
    required this.name,
  });
}

class IPadModel implements IModelWithID {
  @override
  final String id;

  final String name;

  IPadModel({
    required this.id,
    required this.name,
  });
}

class MacModel implements IModelWithID {
  @override
  final String id;

  final String name;

  MacModel({
    required this.id,
    required this.name,
  });
}

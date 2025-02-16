class AssociatedObject {
  final String? id;
  final String? type;

  AssociatedObject({this.id, this.type});

  factory AssociatedObject.fromJson(Map<String, dynamic> json) =>
      AssociatedObject(
        id: json['id'] as String?,
        type: json['type'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
      };
}

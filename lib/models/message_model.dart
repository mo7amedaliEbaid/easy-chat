  class Message{
  String? message;

  Message();

  Map<String, dynamic> toJson() => {
    "message": message,
  };

  Message.fromSnapshot(snapShot)
      : message = snapShot.data()["message"];
}

class Method {
  String title;
  String description;
  int time;

  Method({required this.title, required this.description, required this.time});

  // takes an array of map data and converts it to a list of Method objects
  static List<Method> convertToMethod(List<dynamic> data) {
    List<Method> methodList = [];

    data.forEach((methodData) {
      String title = methodData['title'];
      String description = methodData['description'];
      int time = methodData['time'];

      Method method =
          Method(title: title, description: description, time: time);

      methodList.add(method);
    });

    return methodList;
  }
}

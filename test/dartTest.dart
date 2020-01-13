void main() {
  List<String> lists = ['a', 'b', 'c'];
  lists.forEach((item) {
    print(item);
  });
  ///或者
  lists.forEach((item) => print(item));
}

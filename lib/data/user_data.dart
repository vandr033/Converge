import 'package:faker/faker.dart';

class User {
  final String name;
  final String imageUrl;

  const User({
    required this.name,
    required this.imageUrl,
  });
}

class UserData {
  static final faker = Faker();
  static final List<User> users = List.generate(
    //generates a list of fake users
    //TODO: Change this and pull data from firebase
    50,
    (index) => User(
      name: faker.person.name(), //fake name
      imageUrl:
          'https://source.unsplash.com/random?user+face&sig=$index', //fake image
    ),
  );

  static List<User> getSuggestions(
          String
              query) => //our query is what we type, sent to the getSuggestions method - returns a list of users.
      List.of(users).where((user) {
        final userLower = user.name.toLowerCase();
        final queryLower = query.toLowerCase();

        return userLower.contains(queryLower);
      }).toList();
}

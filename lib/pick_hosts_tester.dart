import 'package:flutter/material.dart';
import 'package:flutter_application/data/user_data.dart';
import 'package:flutter_application/data/user_detail_page.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class LocalTypeAheadPage extends StatelessWidget {
  @override
  static String tag = 'type-ahead';
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Container(
            color: Color(0xffD7D9D7),
            padding: EdgeInsets.all(10),
            child: TypeAheadField<User?>(
              hideOnEmpty: true,
              //TypeAheadField - A TextField that displays a list of suggestions as the user types.
              //hideSuggestionsOnKeyboardHide: false,
              textFieldConfiguration: TextFieldConfiguration(
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.search, color: Color(0xff828382)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(width: 0, style: BorderStyle.none),
                  ),
                  hintText:
                      'Add hosts: ', //i think i actually want to make this a label.
                  hintStyle: TextStyle(
                      fontSize: 16.0,
                      color: Color(0xff828382),
                      fontWeight: FontWeight.w700),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
              suggestionsBoxDecoration: const SuggestionsBoxDecoration(
                color: Color(0xffD7D9D7),
              ),
              suggestionsCallback: UserData.getSuggestions,
              itemBuilder: (context, User? suggestion) {
                final user = suggestion!;

                return ListTile(
                  leading: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(user.imageUrl),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  title: Text(user.name),
                );
              },
              noItemsFoundBuilder: (context) => Container(
                height: 50,
                child: Center(
                  child: Text(
                    'No Users Found.',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
              onSuggestionSelected: (User? suggestion) {
                final user = suggestion!;

                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => UserDetailPage(user: user),
                ));
              },
            ),
          ),
        ),
      );
}

import 'package:flutter/material.dart';
import 'package:responsive_forms/widgets/formTile.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeProvider>(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeProvider.appTheme,
          home: MyHomePage(
            title: 'Responsive Form',
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var checkBoxValue = true;
  var billingVisible = false;
  var formKey = GlobalKey<FormState>();
  var company = FormTile(
    prefixIcon: Icon(Icons.apartment),
    labelText: "Company name",
    hintText: "Your Company",
  );
  var name = FormTile(
      prefixIcon: Icon(Icons.person_outline),
      labelText: "Client name",
      hintText: "Your Name");
  var phoneNumber = FormTile(
      prefixIcon: Icon(Icons.call),
      labelText: "Phone number",
      hintText: "(999) 999-9999");
  var email = FormTile(
    prefixIcon: Icon(Icons.mail_outline),
    labelText: "Email Address",
    hintText: "Email address",
    validator: (value) {
      if (value == null ||
          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value)) {
        return 'Enter a valid email';
      } else {
        return null;
      }
    },
  );
  var pincode = FormTile(
    prefixIcon: Icon(Icons.pin_drop),
    labelText: "Pincode",
    hintText: "Pincode",
    validator: (String? value) {
      value?.length == 6 || value == null ? null : 'enter valid pincode';
    },
  );
  var address = FormTile(
      prefixIcon: null,
      labelText: "Address",
      hintText: "Your Address (Area and Street)",
      minLines: 6);
  var city = FormTile(
      prefixIcon: Icon(Icons.location_city),
      labelText: "City",
      hintText: "Your City/Town");

  var state = FormTile(
      prefixIcon: Icon(Icons.flag), labelText: "State", hintText: "Your State");

  var billingAddress = FormTile(
      prefixIcon: null,
      labelText: "Billing Address",
      hintText: "Enter billing address",
      minLines: 6);

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    var isWide = deviceSize.width > 640;
    var checkBox = Container(
        width: isWide ? deviceSize.width * 0.30 : deviceSize.width * 0.2,
        child: CheckboxListTile(
          title: Text('Same as billing address'),
          value: checkBoxValue,
          onChanged: (onChanged) {
            setState(() {
              checkBoxValue = !checkBoxValue;
              billingVisible = !billingVisible;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ));
    var textButton = TextButton(
      onPressed: () {
        setState(() {
          checkBoxValue = !checkBoxValue;
          billingVisible = !billingVisible;
        });
      },
      child: Text(
        'Add Billing Address',
        style: TextStyle(decoration: TextDecoration.underline),
      ),
    );
    var submitButton = ElevatedButton(
        onPressed: () {
          formKey.currentState!.validate();
        },
        child: Text('Submit'));
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, value, child) {
              return IconButton(
                  onPressed: () {
                    Provider.of<ThemeProvider>(context, listen: false)
                        .changeThemeColor();
                  },
                  icon: value.isDark
                      ? Icon(Icons.light_mode_outlined)
                      : Icon(Icons.dark_mode_outlined));
            },
          )
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Card(
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Form(
                  key: formKey,
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      if (isWide)
                        Column(
                          children: [
                            company,
                            Row(
                              children: [
                                Flexible(
                                  child: name,
                                ),
                                Flexible(child: phoneNumber)
                              ],
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: email,
                                  flex: 3,
                                ),
                                Flexible(
                                  child: pincode,
                                  flex: 1,
                                )
                              ],
                            ),
                            address,
                            Row(
                              children: [
                                Flexible(
                                  child: city,
                                ),
                                Flexible(child: state)
                              ],
                            ),
                            Row(
                              children: [checkBox, textButton],
                            ),
                            Visibility(
                              child: billingAddress,
                              visible: billingVisible,
                            ),
                            submitButton
                          ],
                        ),
                      if (!isWide)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            company,
                            name,
                            phoneNumber,
                            email,
                            pincode,
                            address,
                            city,
                            state,
                            checkBox,
                            textButton,
                            Visibility(
                              child: billingAddress,
                              visible: billingVisible,
                            ),
                            submitButton
                          ],
                        )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

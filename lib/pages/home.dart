import 'package:example/helper/http_helper.dart';
import 'package:example/pages/checkoutpage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  late HttpHelper helper;
  late String _phone, _amount, _email = '';
  late bool _isSubmitted = false;
  late String result = '';

  @override
  void initState() {
    helper = HttpHelper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('PKG'),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Phone number',
                            hintText: 'Enter Phone number'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        onSaved: (value) => _phone = value!),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                            hintText: 'Enter email'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email';
                          }
                          return null;
                        },
                        onSaved: (value) => _email = value!),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: TextFormField(
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: false,
                        signed: true,
                      ),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Amount',
                        hintText: 'Enter amount',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      onSaved: (value) => _amount = value!,
                    ),
                  ),
                  _isSubmitted
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          child: const Text('Checkout'),
                          style: ElevatedButton.styleFrom(
                              primary: const Color(0xff124999),
                              elevation: 5.0,
                              minimumSize: const Size(250.0, 40.0),
                              textStyle: const TextStyle(
                                fontSize: 20.0,
                                color: Colors.black,
                              )),
                          onPressed: _buttonSubmitted,
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<String> makepayement(String phone, String email, String amount) async {
    var response = (await helper.generateUrl(phone, email, amount));
    //print(resultData);
    return response;
  }

  Future _buttonSubmitted() async {
    setState(() {
      _isSubmitted = true;
    });
    final form = _formKey.currentState!;
    if (form.validate()) {
      form.save();

      result = (await makepayement(_phone, _email, _amount));

      if (result.isNotEmpty) {
        MaterialPageRoute route = MaterialPageRoute(
            builder: (BuildContext context) => CheckoutPage(result));
        Navigator.of(context).push(route);

        setState(() {
          _isSubmitted = false;
        });
      }
    }
  }
}

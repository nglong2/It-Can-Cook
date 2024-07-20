import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:it_can_cook/generated/l10n.dart';
import 'package:it_can_cook/src/bloc/account_bloc/account_bloc.dart';
import 'package:it_can_cook/src/bloc/system_bloc/system_bloc.dart';
import 'package:it_can_cook/src/controller/geometry.dart';
import 'package:it_can_cook/src/controller/order.dart';
import 'package:it_can_cook/src/models/weekly/weekly.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uuid/uuid.dart'; // Import the geolocator package

class CheckoutStep1 extends StatefulWidget {
  final WeeklyPlan weeklyPlan;

  const CheckoutStep1({super.key, required this.weeklyPlan});
  @override
  _CheckoutStep1State createState() => _CheckoutStep1State();
}

class _CheckoutStep1State extends State<CheckoutStep1> {
  String name = '';
  String address = '';
  String note = '';
  String phone = '';
  String lat = '';
  String long = '';

  final _formKey = GlobalKey<FormState>();
  final TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    addressController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var accountBloc = context.read<AccountBloc>().state;
    var systemBloc = context.read<SystemBloc>().state;
    double pice = 0;

    for (var recipe in widget.weeklyPlan.recipePlans) {
      var numberPerson = recipe.numberPerson ?? systemBloc.numberPersonInHouse;
      pice += recipe.price! * numberPerson;
    }
    setState(() {
      name = accountBloc?.userName ?? accountBloc?.lastName ?? '';
      // address = accountBloc?.address ?? '';
      phone = accountBloc?.phone ?? '';
    });
    return Scaffold(
        appBar: AppBar(
          title: Text('Checkout Step 1'),
        ),
        body: Container(
          padding: const EdgeInsets.all(18),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        style: ButtonStyle(
                          //borderadius
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: const BorderSide(
                                          color: Color(0xFF02335A)))),
                        ),
                        onPressed: () async {
                          LocationPermission permission;
                          permission = await Geolocator.checkPermission();
                          if (permission == LocationPermission.denied) {
                            permission = await Geolocator.requestPermission();
                            if (permission == LocationPermission.denied) {
                              return Future.error(
                                  'Location permissions are denied');
                            }
                          }

                          var data = await getLocation();

                          if (data.latitude != 0 && data.longitude != 0) {
                            var resdata = await GeometryController()
                                .getAddressFromLatLng(
                                    data.latitude, data.longitude);
                            if (resdata?.results.firstOrNull != null) {
                              setState(() {
                                addressController.text = resdata?.results
                                        .firstOrNull?.formattedAddress ??
                                    '';
                              });
                            }
                          }
                          setState(() {
                            lat = data.latitude.toString();
                            long = data.longitude.toString();
                          });
                          // Call the getLocation method
                        },
                        child: Text(
                          "Get current location",
                        ))
                  ],
                ),
                TextFormField(
                  initialValue: name,
                  decoration: InputDecoration(labelText: S.current.first_name),
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                ),
                TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(labelText: S.current.address),
                  onChanged: (value) {
                    setState(() {
                      address = value;
                    });
                  },
                ),
                TextFormField(
                  initialValue: phone,
                  decoration:
                      InputDecoration(labelText: S.current.phone_number),
                  validator: (value) {
                    if (value == null) {
                      return 'Please enter phone';
                    }
                    //validate phone
                    if (value!.isEmpty) {
                      return 'Please enter phone';
                    }
                    //math regex phone
                    if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                      return 'Please enter valid phone';
                    }
                  },
                  onChanged: (value) {
                    setState(() {
                      phone = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Note'),
                  onChanged: (value) {
                    setState(() {
                      note = value;
                    });
                  },
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: Container(
          margin: EdgeInsets.only(bottom: 30),
          child: Text(
            "Total price: ${pice.toStringAsFixed(0).replaceAllMapped(
                  RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                  (Match m) => '${m[1]}.',
                )} vnđ",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        bottomSheet: Container(
          alignment: Alignment.bottomCenter,
          height: 50,
          child: ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                for (var reipe in widget.weeklyPlan.recipePlans) {
                  reipe.quantity =
                      reipe.numberPerson ?? systemBloc.numberPersonInHouse;

                  reipe.standardWeeklyPlanId = widget.weeklyPlan.id;
                  reipe.recipeId = reipe.recipe?.id ?? '';
                }
                widget.weeklyPlan.totalPrice = pice;
                var data = await OrderController().CreateOrder(
                  accountBloc?.id ?? '',
                  note,
                  addressController.text,
                  pice,
                  widget.weeklyPlan,
                );
                if (data != "") {
                  //scafod data
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(data),
                    ),
                  );
                }
              }
              // If the form is valid, display a Snackbar}
            },
            child: const Center(
              child: Text("Continue"),
            ),
          ),
        ));
  }

  Future<Position> getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    return position;
  }
}

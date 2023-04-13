import 'package:dob_input_field/dob_input_field.dart';
import 'package:flutter/material.dart';
import 'package:sed/presentation/resources/assets_manager.dart';
import 'package:sed/presentation/resources/color_manager.dart';
import 'package:sed/presentation/resources/strings_manager.dart';

class MyAccountScreenView extends StatefulWidget {
  const MyAccountScreenView({super.key});

  @override
  MyAccountScreenViewState createState() => MyAccountScreenViewState();
}

class MyAccountScreenViewState extends State<MyAccountScreenView> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _dobController = TextEditingController();
    _addressController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    _addressController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.background,
      appBar: AppBar(
        backgroundColor: ColorsManager.background,
        elevation: 0,
        iconTheme: IconThemeData(color: ColorsManager.secondaryText),
        title: Text('My Account',
            style: TextStyle(color: ColorsManager.secondaryText)),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Profile Picture',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              SizedBox(height: 16.0),
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  CircleAvatar(
                    radius: 52,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: CircleAvatar(
                        backgroundColor: ColorsManager.primaryBackground,
                        radius: 50,
                        backgroundImage: AssetImage(ImageAssets.noImage)),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const CircleAvatar(
                      radius: 16,
                      child: Icon(
                        Icons.edit,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              SizedBox(height: 16.0),
              Text('Personal Information',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              SizedBox(height: 16.0),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
              ),
              SizedBox(height: 8.0),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                ),
              ),
              SizedBox(height: 8.0),
              TextField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: 'Address',
                ),
              ),
              SizedBox(height: 8.0),
              DOBInputField(
                inputDecoration: InputDecoration(
                  fillColor: ColorsManager.textFormFieldBackGroundColorDark,
                ),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
                showLabel: true,
                dateFormatType: DateFormatType.DDMMYYYY,
                autovalidateMode: AutovalidateMode.disabled,
              ),
              SizedBox(height: 8.0),
              Text('Change Password',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Old Password',
                ),
              ),
              SizedBox(height: 8.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'New Password',
                ),
              ),
              SizedBox(height: 8.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Rewrite New Password',
                ),
              ),
              SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Save Changes'),
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Log out'),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Delete Account',
                      style: TextStyle(color: ColorsManager.error),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

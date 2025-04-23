import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Form Validation',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        inputDecorationTheme: const InputDecorationTheme(
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.purple),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.purple),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.purple, width: 2),
          ),
        ),
      ),
      home: const FormValidationScreen(),
    );
  }
}

class FormValidationScreen extends StatefulWidget {
  const FormValidationScreen({super.key});

  @override
  State<FormValidationScreen> createState() => _FormValidationScreenState();
}

class _FormValidationScreenState extends State<FormValidationScreen> {
  final _formKey = GlobalKey<FormState>();
  String _fullName = '';
  String _dateOfBirth = '';
  String? _gender;
  String _age = '';
  double _familyMembers = 5.0;
  int _rating = 0;
  int _stepper = 10;
  final List<String> _languages = [];
  bool _termsAccepted = false;
  final List<List<Offset>> _signaturePoints = [];
  bool _hasSignature = false;

  final List<String> _genderOptions = [
    'Male',
    'Female',
    'Other',
    'Prefer not to say',
  ];

  void _incrementStepper() {
    setState(() {
      _stepper++;
    });
  }

  void _decrementStepper() {
    setState(() {
      if (_stepper > 0) _stepper--;
    });
  }

  void _clearSignature() {
    setState(() {
      _signaturePoints.clear();
      _hasSignature = false;
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _termsAccepted && _hasSignature) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Form submitted successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete all required fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Form Validation'),
        backgroundColor: Colors.purple,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Full Name',
                errorStyle: TextStyle(color: Colors.red),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field cannot be empty';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _fullName = value;
                });
              },
            ),
            const SizedBox(height: 16),

            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Date of Birth',
                errorStyle: TextStyle(color: Colors.red),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field cannot be empty';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _dateOfBirth = value;
                });
              },
            ),
            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Gender',
                errorStyle: TextStyle(color: Colors.red),
              ),
              hint: const Text('Select Gender'),
              value: _gender,
              items:
                  _genderOptions.map((String gender) {
                    return DropdownMenuItem<String>(
                      value: gender,
                      child: Text(gender),
                    );
                  }).toList(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field cannot be empty';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _gender = value;
                });
              },
            ),
            const SizedBox(height: 16),

            TextFormField(
              decoration: const InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _age = value;
                });
              },
            ),
            const SizedBox(height: 24),

            const Text('Number of Family Members'),
            Slider(
              value: _familyMembers,
              min: 0.0,
              max: 10.0,
              divisions: 10,
              activeColor: Colors.purple,
              inactiveColor: Colors.purple.withAlpha(50),
              onChanged: (value) {
                setState(() {
                  _familyMembers = value;
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [Text('0.0'), Text('8.0'), Text('10.0')],
            ),
            const SizedBox(height: 24),

            const Text('Rating'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(5, (index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      _rating = index + 1;
                    });
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.purple),
                      color:
                          _rating >= index + 1
                              ? Colors.purple.withAlpha(50)
                              : Colors.transparent,
                    ),
                    child: Text('${index + 1}'),
                  ),
                );
              }),
            ),
            const SizedBox(height: 24),

            Row(
              children: [
                const Text('Stepper'),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: _decrementStepper,
                ),
                Text('$_stepper'),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _incrementStepper,
                ),
              ],
            ),
            const SizedBox(height: 16),

            const Text('Languages you know'),
            CheckboxListTile(
              title: const Text('English'),
              value: _languages.contains('English'),
              activeColor: Colors.purple,
              controlAffinity: ListTileControlAffinity.trailing,
              onChanged: (value) {
                setState(() {
                  if (value == true) {
                    _languages.add('English');
                  } else {
                    _languages.remove('English');
                  }
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Hindi'),
              value: _languages.contains('Hindi'),
              activeColor: Colors.purple,
              controlAffinity: ListTileControlAffinity.trailing,
              onChanged: (value) {
                setState(() {
                  if (value == true) {
                    _languages.add('Hindi');
                  } else {
                    _languages.remove('Hindi');
                  }
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Other'),
              value: _languages.contains('Other'),
              activeColor: Colors.purple,
              controlAffinity: ListTileControlAffinity.trailing,
              onChanged: (value) {
                setState(() {
                  if (value == true) {
                    _languages.add('Other');
                  } else {
                    _languages.remove('Other');
                  }
                });
              },
            ),
            const SizedBox(height: 24),

            const Text('Signature'),
            Container(
              height: 100,
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: GestureDetector(
                onPanStart: (details) {
                  setState(() {
                    _signaturePoints.add([
                      Offset(
                        details.localPosition.dx,
                        details.localPosition.dy,
                      ),
                    ]);
                    _hasSignature = true;
                  });
                },
                onPanUpdate: (details) {
                  setState(() {
                    if (_signaturePoints.isNotEmpty) {
                      _signaturePoints.last.add(
                        Offset(
                          details.localPosition.dx,
                          details.localPosition.dy,
                        ),
                      );
                    }
                  });
                },
                onPanEnd: (_) {
                  setState(() {
                    if (_signaturePoints.isNotEmpty &&
                        _signaturePoints.last.length < 2) {
                      // Ensure at least two points in the signature
                      _signaturePoints.removeLast();
                      if (_signaturePoints.isEmpty) {
                        _hasSignature = false;
                      }
                    }
                  });
                },
                child: CustomPaint(
                  painter: SignaturePainter(_signaturePoints),
                  size: Size.infinite,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                icon: const Icon(Icons.clear, color: Colors.red),
                label: const Text('Clear', style: TextStyle(color: Colors.red)),
                onPressed: _clearSignature,
              ),
            ),
            const SizedBox(height: 16),

            const Text('Rate this site'),
            Row(
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    Icons.star,
                    color: _rating > index ? Colors.purple : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _rating = index + 1;
                    });
                  },
                );
              }),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Checkbox(
                  value: _termsAccepted,
                  activeColor: Colors.purple,
                  onChanged: (value) {
                    setState(() {
                      _termsAccepted = value ?? false;
                    });
                  },
                ),
                const Expanded(
                  child: Text(
                    'I have read and agree to the terms and conditions',
                  ),
                ),
              ],
            ),
            if (!_termsAccepted)
              const Text(
                'You must accept terms and conditions to continue',
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Submit'),
                ),
                OutlinedButton(
                  onPressed: () {
                    _formKey.currentState?.reset();
                    setState(() {
                      _fullName = '';
                      _dateOfBirth = '';
                      _gender = null;
                      _age = '';
                      _familyMembers = 5.0;
                      _rating = 0;
                      _stepper = 10;
                      _languages.clear();
                      _termsAccepted = false;
                      _signaturePoints.clear();
                      _hasSignature = false;
                    });
                  },
                  child: const Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SignaturePainter extends CustomPainter {
  final List<List<Offset>> points;

  SignaturePainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint =
        Paint()
          ..color = Colors.black
          ..strokeWidth = 2.0
          ..strokeCap = StrokeCap.round;

    for (List<Offset> path in points) {
      if (path.length < 2) continue;

      for (int i = 0; i < path.length - 1; i++) {
        canvas.drawLine(path[i], path[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(SignaturePainter oldDelegate) => true;
}
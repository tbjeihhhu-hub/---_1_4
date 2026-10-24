
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const DeliveryIraqApp());
}

const Color yellow = Color(0xFFFFD600);
const Color black = Color(0xFF111111);
const Color dark = Color(0xFF202020);

const List<String> governorates = [
  'بغداد',
  'البصرة',
  'نينوى',
  'أربيل',
  'النجف',
  'كربلاء',
  'الديوانية',
  'ذي قار',
  'ميسان',
  'واسط',
  'بابل',
  'كركوك',
  'ديالى',
  'الأنبار',
  'صلاح الدين',
  'المثنى',
  'دهوك',
  'السليمانية',
];

class DeliveryIraqApp extends StatelessWidget {
  const DeliveryIraqApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'دلفري العراق',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: black,
        colorScheme: ColorScheme.fromSeed(
          seedColor: yellow,
          brightness: Brightness.dark,
        ),
        fontFamily: 'Arial',
        useMaterial3: true,
      ),
      home: const WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  String accountType = 'زبون';
  String? selectedGovernorate;
  bool isRegister = true;
  bool hidePassword = true;

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void submit() {
    if (phoneController.text.trim().isEmpty ||
        passwordController.text.isEmpty ||
        (isRegister && nameController.text.trim().isEmpty) ||
        selectedGovernorate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يرجى إكمال جميع المعلومات'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (phoneController.text.trim().length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('رقم الهاتف غير مكتمل')),
      );
      return;
    }

    if (passwordController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('كلمة المرور يجب أن تكون 6 أحرف على الأقل')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'تم إدخال البيانات بنجاح كتجربة. ربط الحسابات قادم.',
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 22,
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),

                Center(
                  child: Container(
                    width: 105,
                    height: 105,
                    decoration: BoxDecoration(
                      color: yellow,
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: const Center(
                      child: Text(
                        'دلفري\nالعراق',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: black,
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                          height: 1.2,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 22),

                const Text(
                  'دلفري العراق',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: yellow,
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'خدمة توصيل تجمع العراق كله',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 35),

                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: dark,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: yellow.withOpacity(0.35),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        isRegister ? 'إنشاء حساب جديد' : 'تسجيل الدخول',
                        style: const TextStyle(
                          fontSize: 23,
                          color: yellow,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 22),

                      const Text(
                        'نوع الحساب',
                        style: TextStyle(fontSize: 15),
                      ),

                      const SizedBox(height: 10),

                      Row(
                        children: [
                          Expanded(
                            child: roleButton(
                              'زبون',
                              Icons.person,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: roleButton(
                              'دلفري',
                              Icons.delivery_dining,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      if (isRegister) ...[
                        field(
                          controller: nameController,
                          label: 'الاسم الكامل',
                          icon: Icons.person_outline,
                        ),
                        const SizedBox(height: 15),
                      ],

                      field(
                        controller: phoneController,
                        label: 'رقم الهاتف',
                        icon: Icons.phone_android,
                        type: TextInputType.phone,
                      ),

                      const SizedBox(height: 15),

                      TextField(
                        controller: passwordController,
                        obscureText: hidePassword,
                        decoration: inputDecoration(
                          'كلمة المرور',
                          Icons.lock_outline,
                        ).copyWith(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            },
                            icon: Icon(
                              hidePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: yellow,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        'المحافظة',
                        style: TextStyle(fontSize: 15),
                      ),

                      const SizedBox(height: 10),

                      DropdownButtonFormField<String>(
                        value: selectedGovernorate,
                        isExpanded: true,
                        dropdownColor: dark,
                        decoration: inputDecoration(
                          'اختر محافظتك',
                          Icons.location_on_outlined,
                        ),
                        items: governorates.map((city) {
                          return DropdownMenuItem(
                            value: city,
                            child: Text(city),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedGovernorate = value;
                          });
                        },
                      ),

                      const SizedBox(height: 25),

                      SizedBox(
                        height: 55,
                        child: ElevatedButton(
                          onPressed: submit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: yellow,
                            foregroundColor: black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Text(
                            isRegister ? 'إنشاء الحساب' : 'دخول',
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      TextButton(
                        onPressed: () {
                          setState(() {
                            isRegister = !isRegister;
                          });
                        },
                        child: Text(
                          isRegister
                              ? 'عندك حساب؟ سجل دخول'
                              : 'ما عندك حساب؟ أنشئ حساب',
                          style: const TextStyle(
                            color: yellow,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                const Text(
                  'دلفري العراق - جميع المحافظات',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white38,
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget roleButton(String title, IconData icon) {
    final selected = accountType == title;

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () {
        setState(() {
          accountType = title;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: selected ? yellow : black,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? yellow : Colors.white24,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: selected ? black : yellow,
              size: 27,
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style: TextStyle(
                color: selected ? black : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget field({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType type = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: type,
      decoration: inputDecoration(label, icon),
    );
  }

  InputDecoration inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: yellow),
      filled: true,
      fillColor: black,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.white12),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: yellow, width: 1.5),
      ),
    );
  }
}
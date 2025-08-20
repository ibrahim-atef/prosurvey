import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/institute.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/institutes/institutes_bloc.dart';
import '../blocs/institutes/institutes_event.dart';
import '../blocs/institutes/institutes_state.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import 'dashboard_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _whatsappController = TextEditingController();
  
  Institute? _selectedInstitute;
  AcademicProgram? _selectedProgram;
  String? _profileImagePath;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  List<Institute> _institutes = [];
  List<AcademicProgram> _academicPrograms = [];

  @override
  void initState() {
    super.initState();
    // تحميل المعاهد عند فتح الشاشة
    context.read<InstitutesBloc>().add(const LoadInstitutes());
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _whatsappController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    
    if (image != null) {
      setState(() {
        _profileImagePath = image.path;
      });
    }
  }

  void _register() {
    if (_formKey.currentState!.validate() && 
        _selectedInstitute != null && 
        _selectedProgram != null) {
      context.read<AuthBloc>().add(RegisterRequested(
        fullName: _fullNameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
        passwordConfirmation: _confirmPasswordController.text,
        instituteId: _selectedInstitute!.id,
        academicProgramId: _selectedProgram!.id,
        whatsappNumber: _whatsappController.text.trim(),
        profileImage: _profileImagePath,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('إنشاء حساب جديد',style: TextStyle(color: Colors.black) ,),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ) ,
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const DashboardScreen()),
              (route) => false,
            );
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppTheme.errorColor,
              ),
            );
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Institutes Loading
                  BlocBuilder<InstitutesBloc, InstitutesState>(
                    builder: (context, state) {
                      if (state is InstitutesLoaded) {
                        _institutes = state.institutes;
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  
                  // Full Name Field
                  CustomTextField(
                    controller: _fullNameController,
                    labelText: 'الاسم الكامل',
                    hintText: 'أدخل اسمك الكامل',
                    prefixIcon: Icons.person,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الاسم الكامل مطلوب';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Email Field
                  CustomTextField(
                    controller: _emailController,
                    labelText: 'البريد الإلكتروني',
                    hintText: 'أدخل بريدك الإلكتروني',
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icons.email,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'البريد الإلكتروني مطلوب';
                      }
                      if (!value.endsWith('@gmail.com')) {
                        return 'يجب أن ينتهي البريد الإلكتروني بـ @gmail.com';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Password Field
                  CustomTextField(
                    controller: _passwordController,
                    labelText: 'كلمة المرور',
                    hintText: 'أدخل كلمة المرور',
                    obscureText: !_isPasswordVisible,
                    prefixIcon: Icons.lock,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'كلمة المرور مطلوبة';
                      }
                      if (value.length < 6) {
                        return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Confirm Password Field
                  CustomTextField(
                    controller: _confirmPasswordController,
                    labelText: 'تأكيد كلمة المرور',
                    hintText: 'أعد إدخال كلمة المرور',
                    obscureText: !_isConfirmPasswordVisible,
                    prefixIcon: Icons.lock,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                        });
                      },
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'تأكيد كلمة المرور مطلوب';
                      }
                      if (value != _passwordController.text) {
                        return 'كلمة المرور غير متطابقة';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // WhatsApp Field
                  CustomTextField(
                    controller: _whatsappController,
                    labelText: 'رقم الواتساب',
                    hintText: 'أدخل رقم الواتساب',
                    keyboardType: TextInputType.phone,
                    prefixIcon: Icons.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'رقم الواتساب مطلوب';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Institute Dropdown
                  BlocBuilder<InstitutesBloc, InstitutesState>(
                    builder: (context, state) {
                      if (state is InstitutesLoading) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      
                      return DropdownButtonFormField<Institute>(
                        value: _selectedInstitute,
                        decoration: const InputDecoration(
                          labelText: 'المعهد',
                          prefixIcon: Icon(Icons.school),
                          border: OutlineInputBorder(),
                        ),
                        items: _institutes.map((institute) {
                          return DropdownMenuItem(
                            value: institute,
                            child: Text(institute.name),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedInstitute = value;
                            _selectedProgram = null; // Reset program when institute changes
                          });
                          // Load academic programs for selected institute
                          if (value != null) {
                            context.read<InstitutesBloc>().add(LoadAcademicPrograms(instituteId: value.id));
                          }
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'يرجى اختيار المعهد';
                          }
                          return null;
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  // Academic Program Dropdown
                  BlocBuilder<InstitutesBloc, InstitutesState>(
                    builder: (context, state) {
                      if (state is AcademicProgramsLoaded) {
                        _academicPrograms = state.programs;
                      }
                      
                      return DropdownButtonFormField<AcademicProgram>(
                        value: _selectedProgram,
                        decoration: const InputDecoration(
                          labelText: 'البرنامج الأكاديمي',
                          prefixIcon: Icon(Icons.grade),
                          border: OutlineInputBorder(),
                        ),
                        items: _academicPrograms.map((program) {
                          return DropdownMenuItem(
                            value: program,
                            child: Text(program.nameArabic),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedProgram = value;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'يرجى اختيار البرنامج الأكاديمي';
                          }
                          return null;
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 20),



                  // Register Button
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return CustomButton(
                        text: 'إنشاء حساب',
                        onPressed: state is AuthLoading ? null : _register,
                        isLoading: state is AuthLoading,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

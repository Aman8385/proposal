import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:mine/proposal_controller.dart';
import 'package:mine/video_background.dart';

class ProposalPage extends StatefulWidget {
  const ProposalPage({super.key});

  @override
  State<ProposalPage> createState() => _ProposalPageState();
}

class _ProposalPageState extends State<ProposalPage> with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  late AnimationController _floatingController;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // ❤️ Heartbeat for YES button
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // ☁️ Floating Animation for Elements (Burger/Dog)
    _floatingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _floatingController.dispose();
    _nameController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProposalController());
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF5E6), // Old Paper / Dairy Page Color
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          /// 🌸 1. Background Video (Softly blended)
          Positioned.fill(
            child: Opacity(
              opacity: 0.6, // Thoda transparent taki text clear dikhe
              child: const VideoBackground(),
            ),
          ),

          /// 📜 2. Aesthetic Overlay (Diary Feel)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.1),
                    const Color(0xFFFDF5E6).withOpacity(0.8), // Warm beige fade
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          /// 🐶 3. Floating Cute Elements (Personal Touch)
          Positioned(
            top: size.height * 0.15,
            right: 20,
            child: FloatingWidget(
              controller: _floatingController,
              child: const Text("🐶", style: TextStyle(fontSize: 40)), // Replace with Image.asset if you have
            ),
          ),
          Positioned(
            top: size.height * 0.20,
            left: 20,
            child: FloatingWidget(
              controller: _floatingController,
              delay: 500,
              child: const Text("🍔", style: TextStyle(fontSize: 40)), // Replace with Image.asset if you have
            ),
          ),

          /// ✨ 4. Main Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),

                  /// 👑 HER NAME (Royal Style)
                  Text(
                    "Dearest Anchal,",
                    style: GoogleFonts.greatVibes(
                      fontSize: 45,
                      color: const Color(0xFF8B4513), // Saddle Brown (Ink color)
                      fontWeight: FontWeight.w500,
                      shadows: [
                        const Shadow(blurRadius: 2, color: Colors.white, offset: Offset(1, 1))
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// 📝 The Diary Note (Typewriter)
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: const Color(0xFFD2B48C), width: 1), // Tan border
                      boxShadow: [
                        BoxShadow(color: Colors.brown.withOpacity(0.1), blurRadius: 10, spreadRadius: 2)
                      ],
                    ),
                    child: DefaultTextStyle(
                      style: GoogleFonts.raleway( // Clean Aesthetic Font
                        fontSize: 18,
                        color: const Color(0xFF5D4037),
                        height: 1.5,
                        fontWeight: FontWeight.w600,
                      ),
                      child: AnimatedTextKit(
                        isRepeatingAnimation: false,
                        displayFullTextOnTap: true,
                        animatedTexts: [
                          TypewriterAnimatedText(
                            "Life tere saath sorted hai.\nLadaai ho ya ignorance, bas tu chahiye.\nEk spiritual, aesthetic, aur burger-loving partner dhoondhna mushkil hai...\nPar mujhe mil gayi. ❤️",
                            speed: const Duration(milliseconds: 60),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  /// 💍 The Big Question
                  Text(
                    "Will you be mine forever?",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF880E4F), // Deep Pink/Maroon
                      letterSpacing: 1.0,
                    ),
                  ),

                  const Spacer(),

                  /// 🔘 Buttons Area
                  SizedBox(
                    height: 180,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        /// ✅ YES BUTTON (Aesthetic Rose)
                        Align(
                          alignment: Alignment.topCenter,
                          child: GestureDetector(
                            onTap: () => _askNameDialog(context, controller),
                            child: ScaleTransition(
                              scale: _pulseAnimation,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Color(0xFFFF80AB), Color(0xFFF06292)],
                                  ),
                                  borderRadius: BorderRadius.circular(50),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFFF06292).withOpacity(0.6),
                                      blurRadius: 20,
                                      spreadRadius: 2,
                                      offset: const Offset(0, 5),
                                    )
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text("YES 💍", style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold)),
                                    const SizedBox(width: 10),
                                    const Icon(Icons.favorite, color: Colors.white),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        /// 🏷️ Subtext
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 70),
                            child: Text(
                              "(Includes free Kinder Joys lifetime)",
                              style: GoogleFonts.dancingScript(color: Colors.brown, fontSize: 16),
                            ),
                          ),
                        ),

                        /// 😈 NO BUTTON (Runaway)
                        Obx(() => AnimatedPositioned(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOutBack,
                          left: controller.noBtnX.value == 0 ? size.width * 0.75 : controller.noBtnX.value,
                          top: controller.noBtnY.value == 0 ? 100 : controller.noBtnY.value,
                          child: GestureDetector(
                            onPanDown: (_) => controller.moveNoButton(size),
                            child: MouseRegion(
                              onHover: (_) => controller.moveNoButton(size),
                              child: Transform.rotate(
                                angle: -0.1, // Thoda crooked style
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.grey.shade400),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
                                  ),
                                  child: Text("🥺No!🥺", style: GoogleFonts.signikaNegative(fontSize: 30, color: Colors.grey)),
                                ),
                              ),
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔐 STEP 1: Dialog
  void _askNameDialog(BuildContext context, ProposalController controller) {
    // Auto-fill her name because you know it's her!
    _nameController.text = "Anchal Agarwal";

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF0F5), // Lavender Blush
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.pinkAccent.shade100, width: 2),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Just one step, Anchal! ✨", style: GoogleFonts.greatVibes(fontSize: 28, color: Colors.pink.shade700)),
              const SizedBox(height: 15),
              Text("Lock this moment with a message for me? 💌", textAlign: TextAlign.center, style: GoogleFonts.raleway(fontSize: 14, color: Colors.brown)),
              const SizedBox(height: 20),

              // Name Field (Read Only - Personal Touch)
              TextField(
                controller: _nameController,
                readOnly: true, // She doesn't need to type her name
                decoration: InputDecoration(
                  labelText: "Name",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                  prefixIcon: const Icon(Icons.person, color: Colors.pinkAccent),
                ),
              ),
              const SizedBox(height: 15),

              // Message Field
              TextField(
                controller: _messageController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "Write your feelings here...",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                  contentPadding: const EdgeInsets.all(15),
                ),
              ),
              const SizedBox(height: 20),

              Obx(() => controller.isLoading.value
                  ? const CircularProgressIndicator(color: Colors.pinkAccent)
                  : ElevatedButton(
                onPressed: () async {
                  if (_messageController.text.trim().isNotEmpty) {
                    bool success = await controller.sendEmail(_nameController.text, _messageController.text.trim());
                    if (!context.mounted) return;
                    Navigator.pop(context);
                    if (success) _showSuccessDialog(context);
                    else Get.snackbar("Oops", "Net check kar lo ji!", backgroundColor: Colors.white);
                  } else {
                    Get.snackbar("Wait!", "Kuch toh likho mere liye 🥺", backgroundColor: Colors.white, colorText: Colors.pink);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF80AB),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text("Lock It Forever 🔒", style: TextStyle(color: Colors.white)),
              )
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🎉 STEP 2: Celebration
  void _showSuccessDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Love",
      pageBuilder: (context, a1, a2) => ScaleTransition(
        scale: CurvedAnimation(parent: a1, curve: Curves.elasticOut),
        child: Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [BoxShadow(color: Colors.pinkAccent, blurRadius: 20)],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("🎉 Yayyyy! 🎉", style: TextStyle(fontSize: 28)),
                const SizedBox(height: 10),
                Text(
                  "Finally! ❤️",
                  style: GoogleFonts.greatVibes(fontSize: 30, color: Colors.pinkAccent),
                ),
                const SizedBox(height: 15),
                const Text("🐶 + 🍔 + You & Me = Perfect!", style: TextStyle(fontSize: 16)),
                const SizedBox(height: 20),
                const Icon(Icons.favorite, color: Colors.red, size: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Helper Widget for Floating Animation
class FloatingWidget extends StatelessWidget {
  final Widget child;
  final AnimationController controller;
  final int delay;

  const FloatingWidget({super.key, required this.child, required this.controller, this.delay = 0});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, childWidget) {
        return Transform.translate(
          offset: Offset(0, 10 * (controller.value - 0.5)), // Moves up and down
          child: childWidget,
        );
      },
      child: child,
    );
  }
}
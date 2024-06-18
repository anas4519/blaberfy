import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blaberfy', style: GoogleFonts.playfairDisplay(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 35),),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: const Center(
        child: Text('Loading...'),
        
      ),
    );
  }
}
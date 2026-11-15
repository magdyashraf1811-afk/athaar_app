import 'package:athaar_app/home/tabs/home_tab/home_tab.dart';
import 'package:athaar_app/home/tabs/home_tab/horas_bottom_bar.dart';
import 'package:athaar_app/home/tabs/horus_tab/horus_tab.dart';
import 'package:athaar_app/home/tabs/profile_tab/profile_tab.dart';
import 'package:athaar_app/home/tabs/tickets_tab/tickets_tab.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  bool showBar = true;

  void hide() {
    if (!showBar) return;

    setState(() {
      showBar = false;
    });
  }

  void show() {
    if (showBar) return;

    setState(() {
      showBar = true;
    });
  }

  late final List<Widget> tabsList = [
    HomeTab(onScrollDown: hide, onScrollUp: show),
    const TicketsTab(),
    const HorusTab(),
    const ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(index: selectedIndex, children: tabsList),

      bottomNavigationBar: AnimatedSlide(
        offset: showBar ? Offset.zero : const Offset(0, 1),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
            child: Stack(
              children: [
                LiquidGlassLayer(
                  settings: LiquidGlassSettings(
                    glassColor: Colors.white.withOpacity(0.1),
                    thickness: 20,
                    blur: 10,
                    lightIntensity: 0.5,
                    saturation: 1.5,
                  ),
                  child: LiquidGlass(
                    shape: LiquidRoundedSuperellipse(borderRadius: 28),
                    child: HorusBottomNavBar(
                      selectedIndex: selectedIndex,
                      onItemSelected: (index) {
                        setState(() {
                          selectedIndex = index;
                          showBar = true;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
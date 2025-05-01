import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:health_app/core/constants/assets.dart';
import 'package:health_app/features/home/data/models/home_card.dart';
import '../../../../core/constants/colors.dart';
import '../blocs/home_bloc.dart';
import '../blocs/home_event.dart';
import '../blocs/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(LoadHomeDataEvent());
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        context.go('/dashboard');
        break;
      case 1:
        context.go('/notifications');
        break;
      case 2:
        context.go('/messages');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.textColor),
                );
              } else if (state is HomeLoaded) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: screenHeight * 0.015),
                        _buildHeader(screenWidth),
                        SizedBox(height: screenHeight * 0.02),
                        _buildOverviewSection(
                          screenWidth,
                          screenHeight,
                          state.stats,
                        ),
                        SizedBox(height: screenHeight * 0.03),
                        _buildCardsSection(
                          screenWidth,
                          screenHeight,
                          state.cards,
                        ),
                        SizedBox(height: screenHeight * 0.03),
                      ],
                    ),
                  ),
                );
              } else if (state is HomeError) {
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(color: AppColors.textColor),
                  ),
                );
              }
              return const Center(
                child: Text(
                  'No Data',
                  style: TextStyle(color: AppColors.textColor),
                ),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.backgroundGradientEnd,
        selectedItemColor: AppColors.textColor,
        unselectedItemColor: AppColors.secondaryTextColor,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: ''),
        ],
      ),
    );
  }

  Widget _buildHeader(double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(
            Icons.person,
            color: AppColors.secondaryTextColor,
            size: 28,
          ),
          onPressed: () {},
        ),
        Image.asset(AppAssets.logo, width: screenWidth * 0.12),
        IconButton(
          icon: const Icon(
            Icons.settings,
            color: AppColors.secondaryTextColor,
            size: 28,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildOverviewSection(
    double screenWidth,
    double screenHeight,
    Map<String, Map<String, dynamic>> stats,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Overview', style: Theme.of(context).textTheme.headlineLarge),
        SizedBox(height: screenHeight * 0.015),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Pie Chart
            SizedBox(
              width: screenWidth * 0.35,
              height: screenWidth * 0.35,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      color: AppColors.optimalColor,
                      value: stats['Optimal']!['percentage'].toDouble(),
                      title: '',
                      radius: screenWidth * 0.12,
                      badgeWidget: null,
                    ),
                    PieChartSectionData(
                      color: AppColors.atRiskColor,
                      value: stats['At Risk']!['percentage'].toDouble(),
                      title: '',
                      radius: screenWidth * 0.12,
                      badgeWidget: null,
                    ),
                    PieChartSectionData(
                      color: AppColors.underperformingColor,
                      value: stats['Underperforming']!['percentage'].toDouble(),
                      title: '',
                      radius: screenWidth * 0.12,
                      badgeWidget: null,
                    ),
                    PieChartSectionData(
                      color: AppColors.recoveringColor,
                      value: stats['Recovering']!['percentage'].toDouble(),
                      title: '',
                      radius: screenWidth * 0.12,
                      badgeWidget: null,
                    ),
                  ],
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 2,
                  centerSpaceRadius: screenWidth * 0.08,
                ),
              ),
            ),
            SizedBox(width: screenWidth * 0.04),
            // Stats List
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStatItem(
                    'Optimal',
                    stats['Optimal']!['percentage'],
                    stats['Optimal']!['count'],
                    AppColors.optimalColor,
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  _buildStatItem(
                    'At Risk',
                    stats['At Risk']!['percentage'],
                    stats['At Risk']!['count'],
                    AppColors.atRiskColor,
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  _buildStatItem(
                    'Underperforming',
                    stats['Underperforming']!['percentage'],
                    stats['Underperforming']!['count'],
                    AppColors.underperformingColor,
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  _buildStatItem(
                    'Recovering',
                    stats['Recovering']!['percentage'],
                    stats['Recovering']!['count'],
                    AppColors.recoveringColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatItem(String label, int percentage, int count, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            '$label ($percentage%) $count',
            style: const TextStyle(
              color: AppColors.secondaryTextColor,
              fontSize: 12,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildCardsSection(
    double screenWidth,
    double screenHeight,
    List<HomeCard> cards,
  ) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: screenWidth * 0.04,
        mainAxisSpacing: screenHeight * 0.02,
        childAspectRatio: 0.75,
      ),
      itemCount: cards.length,
      itemBuilder: (context, index) {
        final card = cards[index];
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.backgroundGradientEnd,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Center(
                  child: Image.asset(
                    card.image,
                    fit: BoxFit.contain,
                    width: screenWidth * 0.25,
                    height: screenWidth * 0.25,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                card.title,
                style: const TextStyle(
                  color: AppColors.textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: screenHeight * 0.005),
              Text(
                card.subtitle,
                style: const TextStyle(
                  color: AppColors.secondaryTextColor,
                  fontSize: 12,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinema_app/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class BannerCarousel extends StatefulWidget {
  const BannerCarousel({super.key});

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  int _currentIndex = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  final List<String> moviePosters = [
    'https://c8.alamy.com/comp/PF5W2N/cinema-and-movie-banner-PF5W2N.jpg',
    'https://www.nicepng.com/png/detail/965-9651929_movies-banner.png',
    'https://img.freepik.com/free-photo/assortment-cinema-elements-red-background-with-copy-space_23-2148457848.jpg?semt=ais_hybrid&w=740&q=80',
    'https://img.freepik.com/free-vector/cinema-cartoon-web-banner-loving-couple-movie-theater-man-woman-look-each-other-sitting-empty-hall-front-glowing-screen_107791-6906.jpg',
    'https://cdn.vectorstock.com/i/500p/37/73/movie-premiere-celebration-banner-vector-51243773.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_buildSlider(), const SizedBox(height: 12), _buildIndicator()],
    );
  }

  Widget _buildSlider() {
    return CarouselSlider(
      items: moviePosters
          .map(
            (url) =>
                Image.network(url, fit: BoxFit.cover, width: double.infinity),
          )
          .toList(),
      carouselController: _controller,
      options: CarouselOptions(
        height: 250,
        viewportFraction: 1.0,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        onPageChanged: (index, reason) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        moviePosters.length,
        (index) => GestureDetector(
          onTap: () => _controller.animateToPage(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            height: 8,
            width: _currentIndex == index ? 24 : 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: _currentIndex == index
                  ? AppColors.electricBlue
                  : Colors.grey.shade400,
            ),
          ),
        ),
      ),
    );
  }
}

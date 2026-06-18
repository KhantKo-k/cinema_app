import 'package:cinema_app/core/di/service_locator.dart';
import 'package:cinema_app/core/navigation/app_router.dart';
import 'package:cinema_app/core/theme/app_color.dart';
import 'package:cinema_app/features/booking/presentation/providers/booking_notifier.dart';
import 'package:cinema_app/features/cinemas/domain/entities/cinema_entity.dart';
import 'package:cinema_app/features/cinemas/presentation/providers/showtime_provider.dart';
import 'package:cinema_app/features/movies/domain/entities/movie_entity.dart';
import 'package:cinema_app/features/movies/routes.dart';
import 'package:cinema_app/features/seating/domain/entities/seat_entity.dart';
import 'package:cinema_app/features/seating/domain/usecases/get_seat_type_use_case.dart';
import 'package:cinema_app/features/seating/domain/usecases/get_theater_use_case.dart';
import 'package:cinema_app/features/seating/domain/usecases/watch_seat_use_case.dart';
import 'package:cinema_app/features/seating/presentation/bloc/theater_bloc.dart';
import 'package:cinema_app/features/seating/presentation/bloc/theater_event.dart';
import 'package:cinema_app/features/seating/presentation/bloc/theater_state.dart';
import 'package:cinema_app/features/seating/presentation/pages/seating_grid.dart';
import 'package:cinema_app/shared/common_widgets/common_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CinemaPage extends ConsumerWidget {
  final MovieEntity movie;
  final CinemaEntity cinema;
  final bool isBooking;
  const CinemaPage({
    super.key,
    required this.movie,
    required this.cinema,
    required this.isBooking,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BlocProvider(
      create: (_) => TheaterBloc(
        getTheaterUseCase: serviceLocator<GetTheaterUseCase>(),
        getSeatTypeUseCase: serviceLocator<GetSeatTypeUseCase>(),
        watchSeatUseCase: serviceLocator<WatchSeatUseCase>(),
      ),
      child: _CinemaView(movie: movie, cinema: cinema, isBooking: isBooking),
    );
  }
}

class _CinemaView extends HookConsumerWidget {
  final MovieEntity movie;
  final CinemaEntity cinema;
  final bool isBooking;

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  _CinemaView({
    required this.movie,
    required this.cinema,
    required this.isBooking,
  });

  String _formatDate(DateTime d) {
    final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return '${d.day} ${weekdays[d.weekday - 1]}';
  }

  String _timeLabel(DateTime t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

  bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final movieId = movie.id!;
    final cinemaId = cinema.id!;

    final daysAsync = ref.watch(
      selectableDaysProvider(movieId: movieId, cinemaId: cinemaId),
    );
    final selectedDay = ref
        .watch(selectedDayProvider(movieId: movieId, cinemaId: cinemaId))
        .value;
    final showtimesAsync = ref.watch(
      showtimesForSelectedDayProvider(movieId: movieId, cinemaId: cinemaId),
    );

    ref.listen<BookingState>(bookingNotifierProvider, (prev, next) {
      if (next.error != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.error.toString())));
      }
      if (next.orderId != null) {
        _showSuccessDialog(context);
      }
    });

    return Scaffold(
      backgroundColor: cs.surface,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCustomAppBar(context, cs),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      _buildMovieHeader(cs),
                      const SizedBox(height: 30),
                      _buildSectionHeader(
                        "Pick a date you want to checkout for ticket",
                        cs,
                      ),
                      const SizedBox(height: 16),
                      daysAsync.when(
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        error: (e, _) => Text(
                          'Error: $e',
                          style: TextStyle(color: cs.error),
                        ),
                        data: (days) => days.isEmpty
                            ? _buildSectionHeader('No available dates', cs)
                            : _buildDaySelector(
                                days,
                                selectedDay,
                                ref,
                                movieId,
                                cinemaId,
                                cs,
                                context,
                              ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                selectedDay != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: _buildSectionHeader(
                              "Please select the showtime",
                              cs,
                            ),
                          ),
                          //const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            child: showtimesAsync.when(
                              loading: () => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              error: (e, _) => Center(child: Text('Error: $e')),
                              data: (items) =>
                                  _buildShowtimeHorizontalList(items, cs, ref),
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildSeatingSection(cs),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: _buildSummarySection(
                              context.watch<TheaterBloc>().state,
                              cs,
                              ref,
                              context,
                            ),
                          ),
                        ],
                      )
                    : _buildEmptyState(cs),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCinemaScreen(ColorScheme cs) {
    return Column(
      children: [
        Container(
          height: 4,
          width: 200,
          decoration: BoxDecoration(
            color: cs.primary.withOpacity(0.5),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: cs.primary.withOpacity(0.3),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'SCREEN',
          style: TextStyle(
            color: cs.onSurfaceVariant.withOpacity(0.6),
            letterSpacing: 5,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildSeatingSection(ColorScheme cs) {
    return BlocConsumer<TheaterBloc, TheaterState>(
      listenWhen: (previous, current) => current.toastMessage != null,
      listener: (context, state) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.toastMessage!),
            backgroundColor: AppColors.error,
            duration: const Duration(seconds: 2),
          ),
        );
      },
      builder: (context, state) {
        if (state.status == TheaterStatus.loading) {
          return const SizedBox(
            height: 300,
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (state.failure is TheaterSeatsFailed) {
          return SizedBox(
            height: 300,
            child: Center(
              child: Text(
                state.failure!.interpretation.message,

                style: TextStyle(color: cs.error),
              ),
            ),
          );
        }
        if (state.status == TheaterStatus.loaded && state.theater != null) {
          return Column(
            children: [
              _buildSectionHeader(
                "Select the seat you want to book or buy",
                cs,
              ),
              SizedBox(height: 18),
              _buildCinemaScreen(cs),
              InteractiveViewer(
                maxScale: 2.0,
                minScale: 1.0,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                    vertical: 24,
                    horizontal: 20,
                  ),
                  child: SeatingGrid(
                    theater: state.theater!,
                    selectedSeats: state.selectedSeats,
                    seatTypes: state.seatTypes ?? [],
                    seats: state.seats,
                    onSeatTap: (seatId) {
                      final seat = state.seats[seatId];
                      if (seat != null && seat.status != SeatStatus.available) {
                        return;
                      }
                      context.read<TheaterBloc>().add(
                        TheaterSeatToggled(seatId: seatId),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildShowtimeHorizontalList(
    List<dynamic> items,
    ColorScheme cs,
    WidgetRef ref,
  ) {
    final selectedShowtimeId = ref.watch(
      selectedShowtimeProvider(movieId: movie.id!, cinemaId: cinema.id!),
    );

    final Map<String, List<dynamic>> groupedShowtimes = {};
    for (var s in items) {
      final name = s.theaterName ?? "Theater";
      groupedShowtimes.putIfAbsent(name, () => []).add(s);
    }

    return BlocBuilder<TheaterBloc, TheaterState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: groupedShowtimes.entries.map((entry) {
            final theaterName = entry.key;
            final showtimes = entry.value;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 12),
                Text(
                  theaterName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: cs.onSurface.withOpacity(0.7),
                  ),
                ),

                const SizedBox(height: 6),

                Wrap(
                  spacing: 12.0,
                  runSpacing: 12.0,
                  children: showtimes.map((s) {
                    final isSelected = selectedShowtimeId == s.id;

                    return GestureDetector(
                      onTap: () {
                        ref
                            .read(
                              selectedShowtimeProvider(
                                movieId: movie.id!,
                                cinemaId: cinema.id!,
                              ).notifier,
                            )
                            .set(s.id);

                        context.read<TheaterBloc>().add(TheaterReset());
                        context.read<TheaterBloc>().add(
                          TheaterLoadedRequested(
                            theaterId: s.theaterId,
                            showtimeId: s.id,
                          ),
                        );
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 75,
                        height: 45,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? cs.primary
                              : cs.surfaceVariant.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isSelected ? cs.primary : cs.outlineVariant,
                            width: 1.5,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            _timeLabel(s.startTime),
                            style: TextStyle(
                              color: isSelected ? cs.onPrimary : cs.onSurface,
                              fontSize: 13,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 8),
              ],
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildEmptyState(ColorScheme cs) {
    return SizedBox.shrink();
  }

  Widget _buildCustomAppBar(BuildContext context, ColorScheme cs) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios_new, color: cs.onSurface, size: 20),
          ),
          SizedBox(width: 20),
          Text(
            cinema.name,
            style: TextStyle(
              color: cs.primary,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMovieHeader(ColorScheme cs) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        // Using a slightly more premium "glassy" background
        color: cs.onSurface.withOpacity(0.04),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: cs.onSurface.withOpacity(0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              movie.posterUrl,
              width: 70,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.broken_image_outlined, size: 20),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title.toUpperCase(),
                  style: TextStyle(
                    color: cs.onSurface,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                _buildGenreScroll(cs),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      size: 14,
                      color: cs.primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "${movie.duration} min",
                      style: TextStyle(
                        color: cs.onSurface.withOpacity(0.7),
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.location_on_rounded,
                      size: 14,
                      color: cs.primary,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        cinema.name,
                        style: TextStyle(
                          color: cs.onSurface.withOpacity(0.7),
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                // Text(
                //   cinema.name,
                //   style: TextStyle(
                //     color: cs.onSurface,
                //     fontWeight: FontWeight.w600,
                //     fontSize: 14,
                //   ),
                // ),
                const SizedBox(height: 10),
                Text(
                  cinema.location,
                  style: TextStyle(
                    color: cs.onSurface.withOpacity(0.5),
                    fontSize: 12,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenreScroll(ColorScheme cs) {
    const accentBlue = Color(0xFF478ED1);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: movie.genre.map((g) {
          return Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              // Modern "Soft Chip" look
              color: accentBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: accentBlue.withOpacity(0.3)),
            ),
            child: Text(
              g,
              style: const TextStyle(
                color: accentBlue,
                fontWeight: FontWeight.w800,
                fontSize: 10,
                letterSpacing: 0.5,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDaySelector(
    List<DateTime> days,
    DateTime? selectedDay,
    WidgetRef ref,
    String mId,
    String cId,
    ColorScheme cs,
    BuildContext context,
  ) {
    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 12.0,
        runSpacing: 12.0,
        children: days.map((day) {
          final isSelected = selectedDay != null && _sameDay(day, selectedDay);
          final dateParts = _formatDate(day).split(' ');

          return GestureDetector(
            onTap: () {
              ref
                  .read(
                    selectedDayProvider(movieId: mId, cinemaId: cId).notifier,
                  )
                  .set(day);
              context.read<TheaterBloc>().add(TheaterReset());
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: isSelected ? cs.primary : cs.onSurface.withOpacity(0.05),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isSelected
                      ? Colors.transparent
                      : cs.onSurface.withOpacity(0.1),
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: cs.primary.withOpacity(0.4),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : [],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    dateParts[0],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? cs.onPrimary : cs.onSurface,
                    ),
                  ),
                  Text(
                    dateParts[1],
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected
                          ? cs.onPrimary.withOpacity(0.8)
                          : cs.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSectionHeader(String title, ColorScheme cs) {
    return Text(
      title,
      style: TextStyle(
        color: cs.onSurface.withOpacity(0.5),
        fontWeight: FontWeight.bold,
        letterSpacing: 1,
        fontSize: 14,
      ),
    );
  }

  Widget _buildSummarySection(
    TheaterState state,
    ColorScheme cs,
    WidgetRef ref,
    BuildContext context,
  ) {
    if (state.selectedSeats.isEmpty) return const SizedBox.shrink();
    final bookingState = ref.watch(bookingNotifierProvider);
    return ListenableBuilder(
      listenable: Listenable.merge([_nameController, _phoneController]),
      builder: (context, child) {
        final isFormFilled =
            _nameController.text.trim().isNotEmpty &&
            _phoneController.text.trim().isNotEmpty;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildSectionHeader("Ticket Summary", cs),
            const SizedBox(height: 12),

            ...state.selectedSeats.map((seatId) {
              final remaining = state.seatTimers[seatId] ?? 0;
              final price = state.getPriceForSeat(seatId);
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(seatId, style: const TextStyle(fontSize: 14)),
                    Text(
                      " : ${price.toStringAsFixed(0)}Ks",
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '- $remaining sec',
                      // _formatTime(remaining),
                      style: TextStyle(
                        fontSize: 11,
                        color: remaining < 20
                            ? Colors.red
                            : cs.onSurfaceVariant,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 22),
            const Divider(),
            const SizedBox(height: 12),
            _buildSectionHeader("Contact Information", cs),
            const SizedBox(height: 16),
            CommonTextField(
              controller: _nameController,
              label: "Your name",
              prefixIcon: Icons.person_outline_rounded,
              validator: (value) => (value == null || value.isEmpty)
                  ? "Please enter your name"
                  : null,
            ),
            const SizedBox(height: 12),
            CommonTextField(
              controller: _phoneController,
              label: "Phone Number",
              prefixIcon: Icons.phone_android,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Phone number is required";
                }
                if (value.length < 7) return "Please enter a valid number";
                return null;
              },
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: cs.primary,
                  foregroundColor: cs.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  // Visual feedback for disabled state
                  disabledBackgroundColor: cs.onSurface.withOpacity(0.1),
                  disabledForegroundColor: cs.onSurface.withOpacity(0.3),
                ),
                onPressed: (isFormFilled && !bookingState.loading)
                    ? () {
                        if (_formKey.currentState!.validate()) {
                          _showConfirmDialog(
                            context,
                            ref,
                            state,
                            isBooking,
                            _nameController.text,
                            _phoneController.text,
                          );
                        }
                      }
                    : null,
                child: bookingState.loading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        isBooking ? "Confirm Booking" : "Proceed to Purchase",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
              ),
            ),
          ],
        );
      },
    );
  }
}

void _showConfirmDialog(
  BuildContext context,
  WidgetRef ref,
  TheaterState state,
  bool isBooking,
  String userName, // Pass these from your controllers
  String userPhone,
) {
  final cs = Theme.of(context).colorScheme;
  final bookingNotifier = ref.read(bookingNotifierProvider.notifier);
  final bookedSeats = state.selectedSeats.toList();

  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: '',
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, anim1, anim2) => const SizedBox.shrink(),
    transitionBuilder: (context, anim1, anim2, child) {
      return Transform.scale(
        scale: anim1.value,
        child: Opacity(
          opacity: anim1.value,
          child: AlertDialog(
            backgroundColor: cs.surface.withOpacity(0.9),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
              side: BorderSide(color: cs.primary.withOpacity(0.2)),
            ),
            title: Column(
              children: [
                Icon(
                  isBooking
                      ? Icons.bookmark_added_outlined
                      : Icons.confirmation_number_outlined,
                  color: cs.primary,
                  size: 40,
                ),
                const SizedBox(height: 12),
                Text(
                  isBooking ? "Confirm Reservation" : "Confirm Purchase",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildInfoRow(
                  Icons.event_seat,
                  "Seats",
                  state.selectedSeatsLabel,
                  cs,
                ),
                const Divider(height: 24),
                _buildInfoRow(
                  Icons.payments_outlined,
                  "Total",
                  "${state.totalPrice.toStringAsFixed(0)} Ks",
                  cs,
                ),
                const Divider(height: 24),
                _buildInfoRow(Icons.person_outline, "Name", userName, cs),
                const SizedBox(height: 20),
                _buildInfoRow(
                  Icons.phone_android_outlined,
                  "Phone",
                  userPhone,
                  cs,
                ),
                const SizedBox(height: 20),
                Text(
                  "By clicking confirm, you agree to our cinema terms and conditions.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    color: cs.onSurfaceVariant.withOpacity(0.7),
                  ),
                ),
              ],
            ),
            actionsAlignment: MainAxisAlignment.spaceEvenly,
            actionsPadding: const EdgeInsets.only(
              bottom: 20,
              left: 10,
              right: 10,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Cancel",
                  style: TextStyle(color: cs.onSurfaceVariant),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: cs.primary,
                  foregroundColor: cs.onPrimary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  if (isBooking) {
                    bookingNotifier.bookSeats(state.showtimeId!, bookedSeats);
                  } else {
                    bookingNotifier.buySeats(state.showtimeId!, bookedSeats);
                  }
                },
                child: Text(isBooking ? "Confirm" : "Pay Now"),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _buildInfoRow(
  IconData icon,
  String label,
  String value,
  ColorScheme cs,
) {
  return Row(
    children: [
      Icon(icon, size: 18, color: cs.primary.withOpacity(0.7)),
      const SizedBox(width: 12),
      Text(label, style: TextStyle(color: cs.onSurfaceVariant, fontSize: 13)),
      const Spacer(),
      Text(
        value,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
    ],
  );
}

void _showSuccessDialog(BuildContext context) {
  final cs = Theme.of(context).colorScheme;

  showGeneralDialog(
    context: context,
    barrierDismissible: false, // Force them to click 'Go Home'
    barrierColor: Colors.black87,
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (context, anim1, anim2) => const SizedBox.shrink(),
    transitionBuilder: (context, anim1, anim2, child) {
      return ScaleTransition(
        scale: CurvedAnimation(parent: anim1, curve: Curves.elasticOut),
        child: AlertDialog(
          backgroundColor: cs.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 80,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "Enjoy Your Movie!",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text(
                "Your seats have been successfully reserved. You can find your digital ticket in your profile.",
                textAlign: TextAlign.center,
                style: TextStyle(color: cs.onSurfaceVariant, fontSize: 14),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: cs.primary,
                    foregroundColor: cs.onPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    _navigateToHome();
                  },
                  child: const Text(
                    "Back to Home",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void _navigateToHome() {
  serviceLocator.get<AppRouter>().navigateToMovies();
}


import 'package:cinema_app/core/theme/app_color.dart';
import 'package:cinema_app/features/seating/domain/entities/seat_entity.dart';
import 'package:cinema_app/features/seating/domain/entities/seat_type_entity.dart';
import 'package:cinema_app/features/seating/domain/entities/theater_entity.dart';
import 'package:flutter/material.dart';

class SeatingGrid extends StatelessWidget {
  final TheaterEntity theater;
  final List<SeatTypeEntity> seatTypes;
  final Set<String> selectedSeats;
  final Map<String, SeatEntity>? seats; // NEW: map of all seats with status
  final void Function(String seatId)? onSeatTap;

  const SeatingGrid({
    super.key,
    required this.theater,
    required this.seatTypes,
    required this.selectedSeats,
    this.seats,
    required this.onSeatTap,
  });

  int get _totalRows =>
      theater.seatTypeRows.fold(0, (sum, item) => sum + item.count);

  Color _parseColorName(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'orange':
        return Colors.orange;
      case 'pink':
        return Colors.pink;
      case 'blue':
        return Colors.blue;
      case 'purple':
        return Colors.purple;
      case 'red':
        return Colors.red;
      case 'green':
        return Colors.green;
      case 'amber':
        return Colors.amber;
      case 'grey':
        return Colors.grey;
      default:
        return Colors.blueGrey;
    }
  }

  SeatTypeEntity? _getTypeForIndex(int rowIndex) {
    int currentRowCount = 0;
    final List<SeatTypeEntity> types = seatTypes.cast<SeatTypeEntity>();

    for (var typeRow in theater.seatTypeRows) {
      currentRowCount += typeRow.count;
      if (rowIndex < currentRowCount) {
        return types.firstWhere(
          (type) => type.id == typeRow.type,
          orElse: () => types.first,
        );
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPriceLegend(context),
        const SizedBox(height: 20),
        ...List.generate(_totalRows, (rowIndex) {
          final rowLetter = String.fromCharCode('A'.codeUnitAt(0) + rowIndex);
          final typeData = _getTypeForIndex(rowIndex);
          final seatColor = _parseColorName(typeData?.color ?? 'grey');
          final isCouple = typeData?.id.toLowerCase() == 'couple';

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildRowLabel(rowLetter),
                const SizedBox(width: 12),
                _buildRowLayout(cs, rowLetter, seatColor, isCouple),
                const SizedBox(width: 12),
                _buildRowLabel(rowLetter),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildPriceLegend(BuildContext context) {
    final sortedTypes = [...seatTypes]
      ..sort((a, b) => a.price.compareTo(b.price));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: sortedTypes.map((type) {
        final color = _parseColorName(type.color);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  border: Border.all(color: color, width: 1.5),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 6),
              Text(
                "${type.price.toStringAsFixed(0)} Ks",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildRowLayout(
    ColorScheme cs,
    String rowLetter,
    Color seatColor,
    bool isCouple,
  ) {
    final int effectiveSeats = isCouple
        ? (theater.seatsPerRow / 2).floor()
        : theater.seatsPerRow;

    if (theater.hasPath && effectiveSeats > 2) {
      int sideSeats = isCouple ? 1 : 2;
      return Row(
        children: [
          _buildSeatRange(cs, rowLetter, seatColor, 1, sideSeats, isCouple),
          _buildAisle(),
          _buildSeatRange(
            cs,
            rowLetter,
            seatColor,
            sideSeats + 1,
            effectiveSeats - sideSeats,
            isCouple,
          ),
          _buildAisle(),
          _buildSeatRange(
            cs,
            rowLetter,
            seatColor,
            effectiveSeats - sideSeats + 1,
            effectiveSeats,
            isCouple,
          ),
        ],
      );
    }

    return _buildSeatRange(
      cs,
      rowLetter,
      seatColor,
      1,
      effectiveSeats,
      isCouple,
    );
  }

  Widget _buildSeatRange(
    ColorScheme cs,
    String rowLetter,
    Color seatColor,
    int start,
    int end,
    bool isCouple,
  ) {
    return Row(
      children: List.generate(end - start + 1, (index) {
        final seatNumber = start + index;
        final seatId = '$rowLetter$seatNumber';
        final isSelected = selectedSeats.contains(seatId);
        final seatEntity = seats?[seatId];

        bool isBooked = seatEntity?.status == SeatStatus.booked;
        bool isLocked = seatEntity?.status == SeatStatus.locked;
        bool isTappable = !isBooked && !isLocked;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: GestureDetector(
            onTap: (isTappable && onSeatTap != null)
              ? () => onSeatTap!(seatId)
              : null,
            child: isCouple
                ? _buildCoupleSeat(seatColor, seatId, isSelected, seatEntity)
                : _buildStandardSeat(seatColor, seatId, isSelected, seatEntity),
          ),
        );
      }),
    );
  }

  Widget _buildStandardSeat(
    Color typeColor,
    String id,
    bool isSelected,
    SeatEntity? seat,
  ) {
    Color displayColor = typeColor;
    bool disabled = false;

    if (seat == null) {
    displayColor = typeColor; // Default color for available seats not in map
  } else {
    switch (seat.status) {
      case SeatStatus.booked:
        displayColor = Colors.orange;
        disabled = true;
        break;
      case SeatStatus.locked:
        displayColor = Colors.red;
        disabled = true;
        break;
      default:
        displayColor = typeColor;
    }
  }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.electricBlue : disabled ? displayColor.withOpacity(0.9) : displayColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: isSelected ? AppColors.electricBlue : displayColor,
          width: 1.5,
        ),
      ),
      child: Center(
        child: Text(
          id,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: isSelected || disabled ? Colors.white : displayColor,
          ),
        ),
      ),
    );
  }

  Widget _buildCoupleSeat(
    Color typeColor,
    String id,
    bool isSelected,
    SeatEntity? seat,
  ) {
     Color displayColor = typeColor;
    bool disabled = false;

    if (seat == null) {
    displayColor = typeColor; // Default color for available seats not in map
  } else {
    switch (seat.status) {
      case SeatStatus.booked:
        displayColor = Colors.orange;
        disabled = true;
        break;
      case SeatStatus.locked:
        displayColor = Colors.red;
        disabled = true;
        break;
      default:
        displayColor = typeColor;
    }
  }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 88,
      height: 40,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.electricBlue : disabled ? displayColor.withOpacity(0.9) : displayColor.withOpacity(0.2),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
          bottomLeft: Radius.circular(6),
          bottomRight: Radius.circular(6),
        ),
        border: Border.all(
          color: isSelected ? AppColors.electricBlue : displayColor,
          width: 1.5,
        ),
      ),
      child: Center(
        child: Text(
          id,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: isSelected || disabled ? Colors.white : displayColor,
          ),
        ),
      ),
    );
  }

  Widget _buildRowLabel(String label) {
    return SizedBox(
      width: 20,
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.grey.shade500,
          fontSize: 16,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildAisle() => const SizedBox(width: 24);
}

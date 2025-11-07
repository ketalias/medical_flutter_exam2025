import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/../../features/doctors/domain/doctor_category.dart';

class CategoryItem extends StatelessWidget {
  final DoctorCategory category;
  final VoidCallback onTap;

  const CategoryItem({Key? key, required this.category, required this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _HoverableIconContainer(category: category),
            const SizedBox(height: 6),
            _HoverableText(text: category.name),
          ],
        ),
      ),
    );
  }
}

class _HoverableIconContainer extends StatefulWidget {
  final DoctorCategory category;

  const _HoverableIconContainer({required this.category});

  @override
  State<_HoverableIconContainer> createState() =>
      _HoverableIconContainerState();
}

class _HoverableIconContainerState extends State<_HoverableIconContainer> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(_isHovered ? 0.12 : 0.05),
              blurRadius: _isHovered ? 16 : 10,
              offset: Offset(0, _isHovered ? 6 : 4),
            ),
          ],
        ),
        child: SvgPicture.asset(
          widget.category.iconPath,
          width: 48,
          height: 48,
          colorFilter: ColorFilter.mode(
            Theme.of(context).primaryColor,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}

class _HoverableText extends StatefulWidget {
  final String text;

  const _HoverableText({required this.text});

  @override
  State<_HoverableText> createState() => _HoverableTextState();
}

class _HoverableTextState extends State<_HoverableText> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 200),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: _isHovered ? Colors.grey[700] : Colors.grey,
        ),
        child: Text(
          widget.text,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

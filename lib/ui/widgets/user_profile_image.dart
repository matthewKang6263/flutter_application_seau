import 'package:flutter/material.dart';

// class UserProfileImage extends StatelessWidget {
//   final double dimension;
//   final String? imgUrl;
//   final VoidCallback? onEdit;

//   const UserProfileImage({
//     super.key,
//     required this.dimension,
//     this.imgUrl,
//     this.onEdit,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: dimension,
//       width: dimension,
//       child: Stack(
//         children: [
//           // 프로필 이미지
//           CircleAvatar(
//             radius: dimension / 2,
//             backgroundColor: Colors.blue[100],
//             backgroundImage:
//                 imgUrl != null && imgUrl!.isNotEmpty // 이미지 url 유무 판별
//                     ? NetworkImage(imgUrl!)
//                     : null,
//             child: imgUrl == null || imgUrl!.isEmpty
//                 ? const Icon(Icons.person, size: 60, color: Colors.white)
//                 : null,
//           ),
//           // 수정 아이콘
//           if (onEdit != null)
//             Positioned(
//               bottom: 0,
//               right: 0,
//               child: GestureDetector(
//                 onTap: onEdit,
//                 child: Container(
//                   width: 30,
//                   height: 30,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     shape: BoxShape.circle,
//                     border: Border.all(
//                       color: Colors.grey[400]!, // 테두리 색상
//                       width: 1, // 테두리 두께
//                     ),
//                   ),
//                   // 연필 아이콘
//                   child: Center(
//                     child: Icon(
//                       Icons.edit,
//                       size: 18,
//                       color: Colors.grey,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

//승현 수정코드 241214

class UserProfileImage extends StatelessWidget {
  final double dimension;
  final String? imgUrl;
  final VoidCallback? onEdit;

  const UserProfileImage({
    super.key,
    required this.dimension,
    this.imgUrl,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: dimension,
      width: dimension,
      child: Stack(
        children: [
          // 프로필 이미지
          // CircleAvatar(
          //   radius: dimension / 2,
          //   backgroundImage: imgUrl != null && imgUrl!.isNotEmpty
          //       // URL이 있으면 네트워크 이미지 사용
          //       ? NetworkImage(imgUrl!) as ImageProvider
          //       // URL이 없으면 로컬 기본 이미지 사용
          //       : AssetImage('assets/images/default_profile_image.png'),
          // ),
          CircleAvatar(
            radius: dimension / 2,
            backgroundImage: imgUrl != null && imgUrl!.startsWith('http')
                ? NetworkImage(imgUrl!) // 네트워크 이미지인 경우
                : AssetImage('assets/images/default_profile_image.png')
                    as ImageProvider, // 로컬 이미지인 경우
          ),
          //
          // 수정 아이콘
          if (onEdit != null)
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: onEdit,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.grey[400]!, // 테두리 색상
                      width: 1, // 테두리 두께
                    ),
                  ),
                  // 연필 아이콘
                  child: Center(
                    child: Icon(
                      Icons.edit,
                      size: 18,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

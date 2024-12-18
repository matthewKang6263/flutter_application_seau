import 'package:flutter/material.dart';
import 'package:flutter_application_seau/data/repository/chat_repository.dart';
import 'package:flutter_application_seau/ui/pages/chat/chat_detail/chat_detail_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_seau/data/model/app_user.dart';
import 'package:flutter_application_seau/data/repository/user_repository.dart';
import 'package:flutter_application_seau/core/auth_service.dart';

// 사용자 리스트를 표시하는 ConsumerStatefulWidget
class HomeTabUserList extends ConsumerStatefulWidget {
  final String searchQuery; // 검색어를 받기 위한 변수

  const HomeTabUserList({Key? key, required this.searchQuery})
      : super(key: key);

  @override
  _HomeTabUserListState createState() => _HomeTabUserListState();
}

class _HomeTabUserListState extends ConsumerState<HomeTabUserList> {
  List<AppUser> allUsers = []; // 전체 사용자 리스트
  List<AppUser> filteredUsers = []; // 필터링된 사용자 리스트
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  // 검색어가 변경될 때마다 필터링
  @override
  void didUpdateWidget(HomeTabUserList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.searchQuery != oldWidget.searchQuery) {
      _filterUsers();
    }
  }

  // 사용자 필터링 메서드
  void _filterUsers() {
    setState(() {
      if (widget.searchQuery.isEmpty) {
        filteredUsers = allUsers;
      } else {
        filteredUsers = allUsers
            .where((user) => user.nickname
                .toLowerCase()
                .contains(widget.searchQuery.toLowerCase()))
            .toList();
      }
    });
  }

  // 사용자 데이터를 로드하는 메서드
  Future<void> _loadUsers() async {
    try {
      setState(() {
        isLoading = true;
        error = null;
      });

      final currentUser = await ref.read(authServiceProvider).getCurrentUser();

      if (currentUser == null) {
        throw Exception('사용자 정보를 찾을 수 없습니다.');
      }

      final userRepository = UserRepository();
      final users = await userRepository.getUsersWithSameCertification(
        currentUser.certificationType,
        currentUser.certificationLevel,
      );

      final filteredList =
          users.where((user) => user.id != currentUser.id).toList();

      setState(() {
        allUsers = filteredList;
        filteredUsers = filteredList;
        isLoading = false;
      });

      _filterUsers(); // 초기 필터링 수행
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (error != null) {
      return Center(child: Text(error!));
    }

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 메인 타이틀
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
            child: Text(
              '원하는 버디를 찾아보세요',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          // 추천 버디 수 표시
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10), // 간격을 좁힘
            child: Text.rich(
              TextSpan(
                text: '총 ',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: '${filteredUsers.length}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  TextSpan(text: '명의 추천 버디'),
                ],
              ),
            ),
          ),
          Divider(height: 1, color: Colors.grey[300]), // 구분선 추가

          // 사용자 리스트
          Expanded(
            child: RefreshIndicator(
              onRefresh: _loadUsers,
              child: ListView.separated(
                padding: EdgeInsets.only(top: 0),
                itemCount: filteredUsers.length,
                separatorBuilder: (context, index) => Divider(
                  height: 1,
                  color: Colors.grey[300], // 리스트 항목 사이 구분선
                ),
                itemBuilder: (context, index) {
                  final user = filteredUsers[index];
                  return ListTile(
                    key: ValueKey(user.id),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    leading: CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.grey[200],
                      backgroundImage: user.profileImageUrl != null &&
                              user.profileImageUrl!.startsWith('http')
                          ? NetworkImage(user.profileImageUrl!)
                          : AssetImage(
                              'assets/images/default_profile_image.png'),
                      // as ImageProvider, 12/17 삭제
                    ),
                    title: Text(
                      user.nickname,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.certificationType,
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          user.certificationLevel,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    trailing: OutlinedButton.icon(
                      onPressed: () async {
                        try {
                          // 현재 로그인한 사용자 ID 가져오기 (방금 수정한 부분)
                          final currentUser = await ref
                              .read(authServiceProvider)
                              .getCurrentUser();
                          if (currentUser == null) {
                            throw Exception('로그인이 필요합니다.');
                          }

                          // ChatRepository 인스턴스 생성 (방금 수정한 부분)
                          final chatRepository = ChatRepository();

                          // 채팅방 생성 또는 가져오기 (방금 수정한 부분)
                          final chatId =
                              await chatRepository.createOrGetChatRoom(
                            currentUser.id,
                            user.id,
                          );

                          // 채팅 상세 페이지로 이동 (방금 수정한 부분)
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ChatDetailPage(
                                  userName: user.nickname,
                                  userImg: user.profileImageUrl,
                                  chatId: chatId, // (방금 수정한 부분)
                                );
                              },
                            ),
                          );
                        } catch (e) {
                          // 에러 처리 추가 (방금 수정한 부분)
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('채팅방 생성 중 오류가 발생했습니다: $e')),
                          );
                        }
                      },
                      icon: Icon(
                        Icons.chat_bubble_outline,
                        size: 16,
                        color: Colors.grey[400],
                      ),
                      label: Text(
                        '채팅하기',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black87,
                        side: BorderSide(color: Colors.grey[300]!),
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

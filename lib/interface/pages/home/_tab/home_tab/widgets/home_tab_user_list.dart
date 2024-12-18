import 'package:flutter/material.dart';
import 'package:flutter_application_seau/data/repository/chat_repository.dart';
import 'package:flutter_application_seau/interface/pages/chat_detail/chat_detail_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_seau/data/model/app_user.dart';
import 'package:flutter_application_seau/data/repository/user_repository.dart';
import 'package:flutter_application_seau/core/auth_service.dart';

class HomeTabUserList extends ConsumerStatefulWidget {
  final String searchQuery;
  const HomeTabUserList({Key? key, required this.searchQuery})
      : super(key: key);

  @override
  _HomeTabUserListState createState() => _HomeTabUserListState();
}

class _HomeTabUserListState extends ConsumerState<HomeTabUserList> {
  List<AppUser> allUsers = [];
  List<AppUser> filteredUsers = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

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

  // 자격증 타입을 한글로 변환하는 함수
  String _getCertificationTypeInKorean(String certificationType) {
    switch (certificationType.toLowerCase()) {
      case 'scuba':
        return '스쿠버다이버';
      case 'freediving':
        return '프리다이버';
      default:
        return certificationType;
    }
  }

  // 자격증 레벨을 원하는 형식으로 변환하는 함수
  String _formatCertificationLevel(String certificationLevel) {
    switch (certificationLevel.toLowerCase()) {
      case 'lv1':
        return 'Lv.1';
      case 'lv2':
        return 'Lv.2';
      default:
        return certificationLevel;
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

    // RefreshIndicator를 최상위 레벨로 이동하고 CustomScrollView를 사용
    return RefreshIndicator(
      onRefresh: _loadUsers,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 메인 타이틀
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
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
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
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
                Divider(height: 1, color: Colors.grey[200]),
              ],
            ),
          ),
          // 사용자 리스트
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final user = filteredUsers[index];
                return Column(
                  children: [
                    ListTile(
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
                                    'assets/images/default_profile_image.png')
                                as ImageProvider,
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
                            _getCertificationTypeInKorean(
                                user.certificationType),
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            _formatCertificationLevel(user.certificationLevel),
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      trailing: OutlinedButton.icon(
                        onPressed: () async {
                          try {
                            // 현재 로그인한 사용자 ID 가져오기
                            final currentUser = await ref
                                .read(authServiceProvider)
                                .getCurrentUser();
                            if (currentUser == null) {
                              throw Exception('로그인이 필요합니다.');
                            }
                            // ChatRepository 인스턴스 생성
                            final chatRepository = ChatRepository();
                            // 채팅방 생성 또는 가져오기
                            final chatId =
                                await chatRepository.createOrGetChatRoom(
                              currentUser.id,
                              user.id,
                            );
                            // 채팅 상세 페이지로 이동
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ChatDetailPage(
                                    userName: user.nickname,
                                    userImg: user.profileImageUrl,
                                    chatId: chatId,
                                  );
                                },
                              ),
                            );
                          } catch (e) {
                            // 에러 처리
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('채팅방 생성 중 오류가 발생했습니다: $e')),
                            );
                          }
                        },
                        icon: Icon(
                          Icons.chat_bubble_outline_rounded,
                          size: 15,
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
                    ),
                    if (index < filteredUsers.length - 1)
                      Divider(height: 1, color: Colors.grey[200]),
                  ],
                );
              },
              childCount: filteredUsers.length,
            ),
          ),
        ],
      ),
    );
  }
}

//  {
//     "roomId": 1,
//     "product":
//     "sender": User
//     "messages": [ ChatMessage
//     ],
//     "createdAt": "2024-11-13T16:48:35.131Z"
//   }



// class ChatRoom {
//   int roomId;
//   ChatProduct product;
//   User sender;
//   List<ChatMessage> messages;
//   DateTime createdAt;
//   ChatRoom({
//     required this.roomId,
//     required this.product,
//     required this.sender,
//     required this.messages,
//     required this.createdAt,
//   });

//   ChatRoom.fromJson(Map<String, dynamic> map)
//       : this(
//           roomId: map['roomId'],
//           product: ChatProduct.fromJson(map['product']),
//           sender: User.fromJson(map['sender']),
//           messages: List.from(map['messages'])
//               .map((e) => ChatMessage.fromJson(e))
//               .toList(),
//           createdAt: DateTime.parse(map['createdAt']),
//         );

//   Map<String, dynamic> toJson() {
//     return {
//       'roomId': roomId,
//       'product': product.toJson(),
//       'sender': sender.toJson(),
//       'messages': messages.map((e) => e.toJson()).toList(),
//       'createdAt': createdAt.toIso8601String(),
//     };
//   }
// }

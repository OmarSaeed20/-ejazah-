// class User {
//   int? id;
//   String? email;
//   String? password;
//   String? accountId;

//   User(
//       {
//         this.id,
//       this.email,
//       this.password,
//         this.accountId,
//       });

//   String table() {
//     return 'user';
//   }

//   String database() {
//     return 'user_db';
//   }

//   Map<String, dynamic> tomap() {
//     return {
//       'id': this.id,
//       'email': this.email,
//       'password': this.password,
//       'accountId': this.accountId,

//     };
//   }

//   int? getId() {
//     return this.id;
//   }

//   User.fromMap(Map<String, dynamic> data) {
//     id = data['id'];
//     email = data['email'];
//     password = data['password'];
//     accountId = data['accountId'];
//   }
// }

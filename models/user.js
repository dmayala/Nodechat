function UserDAO(db) {

  // Schemas
  var UserSchema = new db.Schema({
    'name': String  
  });

  // Models
  var UserModel = db.model('User', UserSchema);

  this.getUsers = function(callback) {
    UserModel.find().exec(callback);
  };

}

module.exports.MessageDAO = MessageDAO;
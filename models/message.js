function MessageDAO(db) {

  // Schemas
  var MessageSchema = new db.Schema({
    'username': String,
    'content': String
  });

  // Models
  var MessageModel = db.model('Message', MessageSchema);

  this.getMessages = function(callback) {
    MessageModel.find().exec(callback);
  };

  this.getMessage = function(id, callback) {
    MessageModel.findById(id, callback);
  };

}

module.exports.MessageDAO = MessageDAO;
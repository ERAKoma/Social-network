import firebase_admin
from firebase_admin import firestore
from flask import Flask, jsonify, request
from flask_cors import CORS, cross_origin
# from waitress import serve


default_app = firebase_admin.initialize_app()
db = firestore.client()

app = Flask(__name__)
cors = CORS(app, resources=r'/*', allow_headers='*', origins='*')

users_ref = db.collection('users')
posts_ref = db.collection('posts')

# Display users
@app.route("/users", methods=["GET"])
def get_users():
    users = [doc.to_dict() for doc in users_ref.stream()]
    return jsonify(users)

# Create users
@app.route("/users", methods=["POST"])
def create_user():
  req_json = request.get_json()
  user_dict = {
    "name": req_json["user"],
    "dob": req_json["dob"],
    "email": req_json["email"],
    "major": req_json["major"],
    "year": req_json["year"],
    "residence": req_json["residence"],
    "best_food": req_json["best_food"],
    "best_movie": req_json["best_movie"]
  }
  user_ref = users_ref.document(req_json["user"])
  if user_ref.get().exists:
    return jsonify({"message": "User already exists."}), 400
  else:
    user_ref.set(user_dict)
    return jsonify({"message": "User created successfully"}), 201

# Update users
@app.route("/users/<user>", methods=["PUT"])
def update_user(user):
  req_json = request.get_json()
  user_ref = users_ref.document(user)
  if user_ref.get().exists:
    user_dict = user_ref.get().to_dict()
    user_dict["major"] = req_json["new_major"]
    user_dict["year"] = req_json["new_year"]
    user_dict["residence"] = req_json["new_residence"]
    user_dict["best_food"] = req_json["new_food"]
    user_dict["best_movie"] = req_json["new_movie"]
    user_ref.set(user_dict)
    return jsonify({"message": "User updated successfully."}), 200
  else:
    return jsonify({"message": "User not found."}), 404

# Delete users
@app.route("/users/<user>", methods=["DELETE"])
def delete_user(user):
  user_ref = users_ref.document(user)
  if user_ref.get().exists:
    user_ref.delete()
    return jsonify({"message": "User deleted successfully."}), 200
  else:
    return jsonify({"message": "User not found."}), 404

# Create post
@app.route("/posts", methods=["POST"])
@cross_origin(origin='*', headers=['Content-Type'])
def create_post():
    data = request.get_json()
    email = data["email"]
    content = data["content"]
    # Access posts collection:
    for doc in posts_ref.stream():
        if doc.to_dict().get("email") == email:
            break
    else:
    # Add new document to posts collection:
        posts_ref.add({"email":email, "content": content})
        return jsonify({"message": "Post created successfully"}), 201

    return jsonify({"success": True}), 200
    

# Get posts
@app.route("/posts", methods=["GET"])
def display_post():
  posts = [doc.to_dict() for doc in posts_ref.stream()]
  return jsonify(posts)

# Delete post
@app.route("/posts/<string:name>", methods=["DELETE"])
def delete_post(name):
  query = posts_ref.where("name", "==", name)
  docs = query.get()
  if len(docs) == 0:
    return jsonify({"message": "Post not found."}), 404
  else:
    for doc in docs:
      doc.reference.delete()
    return jsonify({"message": "Post deleted successfully."}), 200

if __name__ == "__main__":
    app.run()

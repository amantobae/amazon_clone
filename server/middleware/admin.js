const jwt = require("jsonwebtoken");
const user = require("../models/user");
const User = require("../models/user");

const admin = async (req, res, next) => {
  try {
    const token = req.header("x-auth-token");
    if (!token)
      return res.status(401).json({ msg: "No auth token, access denied" });
    const isVerified = jwt.verify(token, "passwordKey");
    if (!isVerified) {
      return res
        .status(401)
        .json({ msg: "Token verification failed, authorization denied." });
    }
    const user = await User.findById(isVerified.id);
    if (user.type == "User" || user.type == "Seller") {
      return res.status(401).json({ msg: "Ypu are not an admin" });
    }
    req.user = isVerified.id;
    req.token = token;
    next();
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

module.exports = admin;

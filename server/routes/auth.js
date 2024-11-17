const express = require("express");
const User = require("../models/user");
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");
const auth = require("../middleware/auth");

const authRouter = express.Router();

authRouter.post("/api/signup", async (req, res) => {
  try {
    const { name, email, password } = req.body;

    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res
        .status(400)
        .json({ msg: "User with the same email already exists" });
    }

    const hashPassword = await bcryptjs.hash(password, 8);

    let user = new User({
      email,
      password: hashPassword,
      name,
    });

    user = await user.save();
    res.json(user);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

authRouter.post("/api/signin", async (req, res) => {
  try {
    const { email, password } = req.body;
    const user = await User.findOne({ email: email });

    if (!user) {
      return res.status(400).json({ msg: "You have to sign up" });
    }

    const isMatch = await bcryptjs.compare(password, user.password);

    if (!isMatch) {
      return res.status(400).json({ msg: "Incorrect password" });
    }

    const token = jwt.sign({ id: user._id }, "passwordKey");
    res.json({ token, ...user._doc });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

authRouter.post("/isTokenValid", async (req, res) => {
  try {
    const token = req.header("x-auth-token");
    if (!token) return res.json(false);

    const isVerfied = jwt.verify(token, "passwordKey");
    if (!isVerfied) return res.json(false);

    const user = await User.findById(isVerfied.id);
    if (!user) return res.json(false);

    res.json(true);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

authRouter.get("/", auth, async (req, res) => {
  try {
    const user = await User.findById(req.user); // Дожидаемся загрузки данных пользователя
    if (!user) {
      return res.status(404).json({ error: "User not found" });
    }
    res.json({ ...user._doc, token: req.token }); // Возвращаем все данные пользователя и токен
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = authRouter;

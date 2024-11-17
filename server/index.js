const express = require("express");
const mongoose = require("mongoose");

const authRouter = require("./routes/auth");
const adminRouter = require("./routes/admin");
const productRouter = require("./routes/product");
const userRouter = require("./routes/user");

// init
const PORT = 3000;
const app = express();
const DB = "your_link";

// middleware
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);

// connections
mongoose
  .connect(DB)
  .then(() => {
    console.log("Connection to MongoDB is Successful");
  })
  .catch((e) => {
    console.log(e);
  });

app.listen(PORT, "0.0.0.0", () => {
  console.log("Listening on the port " + PORT);
});

const express = require("express");
const productRouter = express.Router();
const auth = require("../middleware/auth");
const { Product } = require("../models/product");

productRouter.get("/api/products/", auth, async (req, res) => {
  try {
    const products = await Product.find({ category: req.query.category });
    res.json(products);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});
// get products func
productRouter.get("/api/products/search/:name", auth, async (req, res) => {
  try {
    const products = await Product.find({
      name: { $regex: req.params.name, $options: "i" },
    });
    res.json(products);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

productRouter.post("/api/product/rate-product", auth, async (req, res) => {
  try {
    const { id, rating } = req.body;
    let product = await Product.findById(id);

    if (!product) {
      return res.status(404).json({ error: "Product not found" });
    }

    // delete existing user's rating
    for (let i = 0; i < product.ratings.length; i++) {
      if (product.ratings[i].userId === req.user.toString()) {
        product.ratings.splice(i, 1);
        break;
      }
    }

    // add new rating
    const ratingSchema = { userId: req.user.toString(), rating };
    product.ratings.push(ratingSchema);

    product = await product.save();
    res.json(product);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

productRouter.get("/api/deal-of-day", auth, async (req, res) => {
  try {
    let products = await Product.find({});
    products = products.sort((a, b) => {
      let aSum = 0;
      let bSum = 0;

      for (let i = 0; i < a.ratings.length; i++) {
        aSum += a.ratings[i].rating;
      }

      for (let i = 0; i < b.ratings.length; i++) {
        bSum += b.ratings[i].rating;
      }

      return aSum < bSum ? 1 : -1;
    });

    res.json(products[0]);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = productRouter;

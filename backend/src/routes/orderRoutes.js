// backend/src/routes/orderRoutes.js

import express from "express";
const router = express.Router();
import Order from "../models/Order.js";

router.post("/place", async (req, res) => {
  try {
    const { userId, items, totalAmount } = req.body;

    const newOrder = new Order({
      userId,
      items,
      totalAmount
    });

    await newOrder.save();
    res.json({ success: true, message: "Order placed", order: newOrder });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
});

router.get("/:userId", async (req, res) => {
  try {
    const orders = await Order.find({ userId: req.params.userId }).populate("items.itemId");
    res.json({ success: true, orders });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
});

export default router;

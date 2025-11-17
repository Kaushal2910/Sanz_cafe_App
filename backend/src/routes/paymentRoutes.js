// backend/src/routes/paymentRoutes.js

import express from "express";
const router = express.Router();

router.post("/pay", async (req, res) => {
  try {
    const { orderId, amount } = req.body;

    if (!orderId || !amount) {
      return res.status(400).json({ success: false, message: "Missing fields" });
    }

    res.json({
      success: true,
      message: "Payment successful",
      paymentId: "PAY-" + Math.random().toString(36).substring(2, 10)
    });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
});

export default router;

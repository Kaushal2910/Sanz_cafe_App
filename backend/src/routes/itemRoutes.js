import express from "express";
import authMiddleware from "../middleware/authMiddleware.js";
import {
  createItem,
  getItems,
  updateItem,
  deleteItem
} from "../controllers/itemController.js";

const router = express.Router();

router.get("/", getItems);
router.post("/", authMiddleware, createItem);
router.put("/:id", authMiddleware, updateItem);
router.delete("/:id", authMiddleware, deleteItem);

export default router;

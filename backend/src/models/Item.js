import mongoose from "mongoose";

const itemSchema = new mongoose.Schema({
  name: String,
  price: Number,
  image: String,
  available: { type: Boolean, default: true }
});

export default mongoose.model("Item", itemSchema);

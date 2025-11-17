
import Item from "../models/Item.js";

export const createItem = async (req, res) => {
  const item = await Item.create(req.body);
  res.json({ message: "Item added", item });
};

export const getItems = async (req, res) => {
  const items = await Item.find();
  res.json(items);
};

export const updateItem = async (req, res) => {
  const item = await Item.findByIdAndUpdate(req.params.id, req.body, { new: true });
  res.json({ message: "Updated", item });
};

export const deleteItem = async (req, res) => {
  await Item.findByIdAndDelete(req.params.id);
  res.json({ message: "Deleted" });
};

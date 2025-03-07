import express from "express";
import {
  createTattoo,
  deleteTattoo,
  getTattoo,
  getTattoos,
  updateTattoo,
} from "../controllers/tattooController.js";
import { adminGuard, authGuard } from "../middlewares/authMiddleware.js";

const router = express.Router();

router.get("/", getTattoos);
router.get("/single/:id", getTattoo);
router.post("/create-tattoo", authGuard, adminGuard, createTattoo);
router.put("/update-tattoo", authGuard, adminGuard, updateTattoo);
router.delete("/:id", authGuard, adminGuard, deleteTattoo);

export default router;

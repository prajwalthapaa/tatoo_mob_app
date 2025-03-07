import path from "path";
import fs from "fs";
import { fileURLToPath } from "url";
import { TattooModel } from "../models/Tattoo.js";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
export const createTattoo = async (req, res) => {
  const {
    name,
    type,
    city,
    address,
    description,
    rating,
    rooms,
    cheapestPrice,
  } = req.body;



  // Assuming req.user is set by authentication middleware
  const user = req.user._id;
  console.log(req.files);

  if (!req.files || !req.files.productImage) {
    return res.status(400).json({
      success: false,
      message: "Image not found",
    });
  }
  const { productImage } = req.files;
  const imageName = `${Date.now()}-${productImage.name}`;
  const imageUploadPath = path.join(
    __dirname,
    `../public/${imageName}`
  );
  try {
    
    
    
        // Check if the directory exists, if not, create it
        const directoryPath = path.join(__dirname, "../public");
        if (!fs.existsSync(directoryPath)) {
          fs.mkdirSync(directoryPath, { recursive: true });
        }
    
        await productImage.mv(imageUploadPath);
    

        // Create new tattoo document
        const newTattoo = new TattooModel({
          name,
          type,
          city,
          address,
          description,
          rating,
          rooms,
          cheapestPrice,
          photos: imageName, 
          user,
        });

        const savedTattoo = await newTattoo.save();
        return res
          .status(201)
          .json({ message: "Tattoo place created!", data: savedTattoo });


  } catch (error) {
    console.error(error);
    return res.status(500).json({ message: error.message });
  }
};

export const updateTattoo = async (req, res, next) => {
  try {
    const {
      name,
      type,
      city,
      address,
      description,
      rating,
      rooms,
      cheapestPrice,
    } = req.body;
    if (
      !name ||
      !type ||
      !city ||
      !address ||
      !description ||
      !rating ||
      !rooms ||
      !cheapestPrice
    ) {
      return res.status(400).json({ message: "Missing required fields" });
    }

    const updatedTattoo = await TattooModel.findByIdAndUpdate(
      req.params.id,
      { $set: req.body },
      { new: true }
    );
    res.status(200).json(updatedTattoo);
  } catch (error) {
    next(error);
  }
};

export const deleteTattoo = async (req, res, next) => {
  try {
    await TattooModel.findByIdAndDelete(req.params.id);
    res.status(200).json({ message: "Tattoo has been deleted." });
  } catch (error) {
    next(error);
  }
};

export const getTattoo = async (req, res, next) => {
  try {
    const tattoo = await TattooModel.findById(req.params.id);
    res.status(200).json(tattoo);
  } catch (error) {
    next(error);
  }
};

// Get all tattoos with filters
export const getTattoos = async (req, res, next) => {
  try {
    const { min, max, ...others } = req.query;
    const tattoos = await TattooModel.find({
      ...others,
      cheapestPrice: { $gt: min || 1, $lt: max || 999999 },
    }).limit(req.query.limit);
    res.status(200).json(tattoos);
  } catch (error) {
    next(error);
  }
};

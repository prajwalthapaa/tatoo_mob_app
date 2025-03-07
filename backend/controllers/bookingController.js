import { BookingModel } from "../models/Booking.js";
import { TattooModel } from "../models/Tattoo.js";

export const createBooking = async (req, res, next) => {
  try {
    const { tattooId, appointmentDate, guests, room } = req.body;

    console.log(tattooId)

    if (!tattooId || !appointmentDate || !guests || !room) {
      return res.status(400).json({ message: "All fields are required!" });
    }

    const tattoo = await TattooModel.findById(tattooId);
    if (!tattoo) {
      return res.status(404).json({ message: "Tattoo not found" });
    }

    const totalPrice = tattoo.cheapestPrice; // Simplified since no nights calculation needed

    const newBooking = new BookingModel({
      tattoo: tattooId,
      user: req.user._id,
      room,
      appointmentDate,
      totalPrice,
      guests,
      status: "confirmed",
    });

    await TattooModel.findByIdAndUpdate(tattooId, {
      reservationStatus: "confirmed",
    });

    const savedBooking = await newBooking.save();
    res.status(201).json({
      message: "Booking created successfully",
      booking: savedBooking,
    });
  } catch (error) {
    next(error);
  }
};

// Cancel a booking
export const cancelBooking = async (req, res, next) => {
  try {
    const { tattooId } = req.body;

    const booking = await BookingModel.findById(req.params.id);
    if (!booking) {
      return res.status(404).json({ message: "Booking not found" });
    }

    const tattoo = await TattooModel.findById(tattooId);
    if (!tattoo) {
      return res.status(404).json({ message: "Tattoo not found!" });
    }

    if (booking.user.toString() !== req.user._id.toString()) {
      return res.status(403).json({ message: "You can only cancel your own bookings" });
    }
    

    await TattooModel.findByIdAndUpdate(tattooId, {
      reservationStatus: "available",
    });

    booking.status = "cancelled";
    await booking.save();

    res.status(200).json({ message: "Booking cancelled successfully" });
  } catch (error) {
    next(error);
  }
};

export const getUserBookings = async (req, res, next) => {
  try {
    const bookings = await BookingModel.find({ user: req.user.id })
      .populate("tattoo", "name address photos")
      .sort({ createdAt: -1 });
    res.status(200).json(bookings);
  } catch (error) {
    next(error);
  }
};

export const getAllBookings = async (req, res, next) => {
  try {
    const bookings = await BookingModel.find()
      .populate("tattoo", "name")
      .populate("user", "name email");
    res.status(200).json(bookings);
  } catch (error) {
    next(error);
  }
};

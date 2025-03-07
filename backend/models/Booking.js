import mongoose from "mongoose";

const bookingSchema = new mongoose.Schema(
  {
    tattoo: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Tattoo",
      required: true,
    },
    user: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
    room: {
      type: String,
      required: true,
    },
    appointmentDate: {  
      type: Date,
      required: true,
    },
    // checkOutDate: {  
    //   type: Date,
    //   required: true,
    // },
    totalPrice: {
      type: Number,
      required: true,
    },
    status: {
      type: String,
      enum: ["confirmed", "cancelled"],
      default: "confirmed",
    },
    guests: {
      type: Number,
      required: true,
    },
  },
  { timestamps: true }
);

export const BookingModel = mongoose.model("Booking", bookingSchema);
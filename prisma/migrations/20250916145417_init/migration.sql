-- CreateEnum
CREATE TYPE "public"."Role" AS ENUM ('DOCTOR', 'PATIENT', 'MANAGER');

-- CreateEnum
CREATE TYPE "public"."Shift" AS ENUM ('MORNING', 'AFTERNOON', 'OVERTIME');

-- CreateEnum
CREATE TYPE "public"."QueueStatus" AS ENUM ('WAITING', 'CALLED', 'IN_PROGRESS', 'DONE', 'CANCELLED');

-- CreateEnum
CREATE TYPE "public"."StatusRequest" AS ENUM ('PENDING', 'CONFIRMED', 'REJECTED', 'CANCELLED');

-- CreateTable
CREATE TABLE "public"."Account" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "role" "public"."Role" NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Account_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Patient" (
    "user_id" TEXT NOT NULL,
    "full_name" TEXT,
    "gender" TEXT,
    "date_of_birth" TIMESTAMP(3),
    "medical_history" TEXT,
    "address" TEXT,
    "phone_number" TEXT,
    "blood_type" TEXT,
    "emergency_contact" TEXT,
    "insurance_number" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL
);

-- CreateTable
CREATE TABLE "public"."Doctor" (
    "user_id" TEXT NOT NULL,
    "full_name" TEXT,
    "gender" TEXT,
    "phone_number" TEXT,
    "specialty" TEXT,
    "rating" INTEGER,
    "bio" TEXT,
    "avatar_url" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL
);

-- CreateTable
CREATE TABLE "public"."DoctorSchedule" (
    "id" TEXT NOT NULL,
    "doctor_id" TEXT NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "shift" "public"."Shift" NOT NULL,
    "start_time" TIMESTAMP(3) NOT NULL,
    "end_time" TIMESTAMP(3) NOT NULL,
    "is_available" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "DoctorSchedule_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."ClinicService" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "price" DECIMAL(10,2) NOT NULL,
    "duration_minutes" INTEGER,
    "image_url" TEXT,
    "requires_doctor" BOOLEAN,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ClinicService_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."AppointmentRequest" (
    "id" TEXT NOT NULL,
    "full_name" TEXT NOT NULL,
    "phone_number" TEXT NOT NULL,
    "patient_id" TEXT NOT NULL,
    "service_id" TEXT NOT NULL,
    "appointment_time" TIMESTAMP(3) NOT NULL,
    "status" "public"."StatusRequest" NOT NULL DEFAULT 'PENDING',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "AppointmentRequest_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."AppointmentQueue" (
    "id" TEXT NOT NULL,
    "patient_id" TEXT NOT NULL,
    "doctor_id" TEXT NOT NULL,
    "appointment_request_id" TEXT NOT NULL,
    "queue_number" INTEGER NOT NULL,
    "status" "public"."QueueStatus" NOT NULL DEFAULT 'WAITING',
    "scheduled_at" TIMESTAMP(3) NOT NULL,
    "checked_in_at" TIMESTAMP(3),
    "finished_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "AppointmentQueue_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Account_email_key" ON "public"."Account"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Patient_user_id_key" ON "public"."Patient"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "Doctor_user_id_key" ON "public"."Doctor"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "ClinicService_name_key" ON "public"."ClinicService"("name");

-- AddForeignKey
ALTER TABLE "public"."Patient" ADD CONSTRAINT "Patient_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."Account"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."DoctorSchedule" ADD CONSTRAINT "DoctorSchedule_doctor_id_fkey" FOREIGN KEY ("doctor_id") REFERENCES "public"."Doctor"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."AppointmentRequest" ADD CONSTRAINT "AppointmentRequest_patient_id_fkey" FOREIGN KEY ("patient_id") REFERENCES "public"."Patient"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."AppointmentRequest" ADD CONSTRAINT "AppointmentRequest_service_id_fkey" FOREIGN KEY ("service_id") REFERENCES "public"."ClinicService"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."AppointmentQueue" ADD CONSTRAINT "AppointmentQueue_patient_id_fkey" FOREIGN KEY ("patient_id") REFERENCES "public"."Patient"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."AppointmentQueue" ADD CONSTRAINT "AppointmentQueue_doctor_id_fkey" FOREIGN KEY ("doctor_id") REFERENCES "public"."Doctor"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."AppointmentQueue" ADD CONSTRAINT "AppointmentQueue_appointment_request_id_fkey" FOREIGN KEY ("appointment_request_id") REFERENCES "public"."AppointmentRequest"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

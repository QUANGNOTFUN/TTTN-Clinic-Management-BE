-- CreateEnum
CREATE TYPE "public"."Role" AS ENUM ('DOCTOR', 'PATIENT', 'MANAGER');

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

-- CreateIndex
CREATE UNIQUE INDEX "Account_email_key" ON "public"."Account"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Patient_user_id_key" ON "public"."Patient"("user_id");

-- AddForeignKey
ALTER TABLE "public"."Patient" ADD CONSTRAINT "Patient_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."Account"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

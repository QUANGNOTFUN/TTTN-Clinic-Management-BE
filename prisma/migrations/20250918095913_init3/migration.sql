/*
  Warnings:

  - Added the required column `gender` to the `Patient` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "public"."Patient" DROP COLUMN "gender",
ADD COLUMN     "gender" "public"."Gender" NOT NULL;

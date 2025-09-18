
ALTER TABLE "public"."Doctor" ADD COLUMN     "id" TEXT NOT NULL,
ADD CONSTRAINT "Doctor_pkey" PRIMARY KEY ("id");

CREATE TABLE "public"."_DoctorToService" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL,

    CONSTRAINT "_DoctorToService_AB_pkey" PRIMARY KEY ("A","B")
);

CREATE INDEX "_DoctorToService_B_index" ON "public"."_DoctorToService"("B");

ALTER TABLE "public"."_DoctorToService" ADD CONSTRAINT "_DoctorToService_A_fkey" FOREIGN KEY ("A") REFERENCES "public"."ClinicService"("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "public"."_DoctorToService" ADD CONSTRAINT "_DoctorToService_B_fkey" FOREIGN KEY ("B") REFERENCES "public"."Doctor"("id") ON DELETE CASCADE ON UPDATE CASCADE;


import { BadRequestException, Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import * as bcrypt from 'bcryptjs';
import { CreateDoctorDto } from './dto/create-doctor.dto';
import { Role } from '../auth/entities/account.dto';

@Injectable()
export class DoctorsService {
  constructor(private readonly prisma: PrismaService) {}

  async findAll() {
    return this.prisma.doctor.findMany({
      where: {
        user: {
          role: 'DOCTOR',
        },
      },
      include: {
        user: {
          select: {
            email: true,
          },
        },
      },
    });
  }

  async findOne(id: string) {
    return this.prisma.doctor.findUnique({
      where: { user_id: id },
      include: {
        user: {
          select: {
            email: true,
          },
        },
      },
    });
  }

  remove(id: number) {
    return `This action removes a #${id} doctor`;
  }

  async create(payload: CreateDoctorDto) {
    const existingUser = await this.prisma.account.findUnique({
      where: { email: payload.email },
    });
    if (existingUser) {
      throw new BadRequestException('Email đã tồn tại');
    }

    const hashedPassword = await bcrypt.hash(payload.password, 10);

    const user = await this.prisma.account.create({
      data: {
        email: payload.email,
        password: hashedPassword,
        role: Role.DOCTOR,
      },
    });
    await this.prisma.doctor.create({
      data: {
        user_id: user.id,
        full_name: payload.full_name,
      },
    });

    return { message: 'Tạo bác sĩ thành công' };
  }
}


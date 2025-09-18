
import { Body, Controller, Get, Post, Req, UseGuards } from '@nestjs/common';
import { DoctorsService } from './doctors.service';
import { JwtAuthGuard } from '../auth/jwt/jwt-auth.guard';
import { RolesGuard } from '../auth/jwt/roles.guard';
import { Roles } from '../auth/jwt/roles.decorate';
import { Role } from '../auth/entities/account.dto';
import { RequestSessionDto } from '../auth/dto/request-session.dto';
import { CreateDoctorDto } from './dto/create-doctor.dto';

@Controller('doctors')
export class DoctorsController {
  constructor(private readonly doctorsService: DoctorsService) {}

  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles(Role.MANAGER)
  @Get('findAll')
  findAll() {
    return this.doctorsService.findAll();
  }

  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles(Role.DOCTOR)
  @Get('findOne')
  async findOne(@Req() req: RequestSessionDto) {
    return this.doctorsService.findOne(req.user.id);
  }

  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles(Role.MANAGER)
  @Post('create')
  async create(@Body() payload: CreateDoctorDto) {
    return this.doctorsService.create(payload);
  }
}

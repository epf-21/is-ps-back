-- CreateEnum
CREATE TYPE "Genero" AS ENUM ('MASCULINO', 'FEMENINO', 'OTRO');

-- CreateEnum
CREATE TYPE "Roles" AS ENUM ('HOST', 'RENTER', 'DRIVER');

-- CreateTable
CREATE TABLE "Usuario" (
    "id" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,
    "correo" TEXT NOT NULL,
    "fecha_nacimiento" TIMESTAMP(3) NOT NULL,
    "genero" "Genero" NOT NULL,
    "id_ciudad" INTEGER NOT NULL,
    "contraseña" TEXT,
    "google_id" TEXT,
    "foto" TEXT,
    "telefono" TEXT NOT NULL,

    CONSTRAINT "Usuario_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UsuarioRol" (
    "id" SERIAL NOT NULL,
    "id_rol" INTEGER NOT NULL,
    "id_usuario" INTEGER NOT NULL,

    CONSTRAINT "UsuarioRol_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Rol" (
    "id" SERIAL NOT NULL,
    "rol" TEXT NOT NULL,

    CONSTRAINT "Rol_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Favorito" (
    "id" SERIAL NOT NULL,
    "id_usuario_rol" INTEGER NOT NULL,
    "id_carro" INTEGER NOT NULL,
    "id_usuario" INTEGER,

    CONSTRAINT "Favorito_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Notificacion" (
    "id" SERIAL NOT NULL,
    "id_usuario_rol" INTEGER NOT NULL,
    "mensaje" TEXT NOT NULL,

    CONSTRAINT "Notificacion_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Carro" (
    "id" SERIAL NOT NULL,
    "vim" TEXT NOT NULL,
    "año" INTEGER NOT NULL,
    "marca" TEXT NOT NULL,
    "modelo" TEXT NOT NULL,
    "placa" TEXT NOT NULL,
    "id_direccion" INTEGER NOT NULL,
    "asientos" INTEGER NOT NULL,
    "puertas" INTEGER NOT NULL,
    "soat" BOOLEAN NOT NULL,
    "precio_por_dia" DOUBLE PRECISION NOT NULL,
    "num_mantenimientos" INTEGER NOT NULL,
    "transmicion" TEXT NOT NULL,
    "estado" TEXT NOT NULL,
    "id_usuario_rol" INTEGER NOT NULL,
    "descripcion" TEXT,

    CONSTRAINT "Carro_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CombustibleCarro" (
    "id" SERIAL NOT NULL,
    "id_carro" INTEGER NOT NULL,
    "id_combustible" INTEGER NOT NULL,

    CONSTRAINT "CombustibleCarro_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TipoCombustible" (
    "id" SERIAL NOT NULL,
    "tipoDeCombustible" TEXT NOT NULL,
    "id_carro" INTEGER NOT NULL,

    CONSTRAINT "TipoCombustible_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "caracteristicasAdicionalesCarro" (
    "id" SERIAL NOT NULL,
    "id_carro" INTEGER NOT NULL,
    "id_carasteristicasAdicionales" INTEGER NOT NULL,

    CONSTRAINT "caracteristicasAdicionalesCarro_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CarasteristicasAdicionales" (
    "id" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,

    CONSTRAINT "CarasteristicasAdicionales_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Imagen" (
    "id" SERIAL NOT NULL,
    "data" BYTEA,
    "id_carro" INTEGER NOT NULL,

    CONSTRAINT "Imagen_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Calificacion" (
    "id" SERIAL NOT NULL,
    "id_usuario_rol" INTEGER NOT NULL,
    "calf_carro" INTEGER NOT NULL,
    "calf_usuario" INTEGER NOT NULL,
    "id_carro" INTEGER NOT NULL,
    "id_usuario" INTEGER NOT NULL,

    CONSTRAINT "Calificacion_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Reserva" (
    "id" SERIAL NOT NULL,
    "id_carro" INTEGER NOT NULL,
    "id_usuario" INTEGER NOT NULL,
    "fecha_creacion" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "fecha_inicio" TIMESTAMP(3) NOT NULL,
    "fecha_fin" TIMESTAMP(3) NOT NULL,
    "fecha_expiracion" TIMESTAMP(3),
    "estado" TEXT NOT NULL DEFAULT 'pendiente',
    "id_descuento" INTEGER,

    CONSTRAINT "Reserva_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Descuento" (
    "id" SERIAL NOT NULL,
    "fecha" TIMESTAMP(3) NOT NULL,
    "porcentaje" DOUBLE PRECISION NOT NULL,

    CONSTRAINT "Descuento_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Garantia" (
    "id" SERIAL NOT NULL,
    "precio" DOUBLE PRECISION NOT NULL,
    "fecha_limite" TIMESTAMP(3) NOT NULL,
    "pagado" BOOLEAN NOT NULL,

    CONSTRAINT "Garantia_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Ciudad" (
    "id" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,
    "id_pais" INTEGER,

    CONSTRAINT "Ciudad_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Pais" (
    "id" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,

    CONSTRAINT "Pais_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Direccion" (
    "id" SERIAL NOT NULL,
    "id_provincia" INTEGER NOT NULL,
    "calle" TEXT NOT NULL,
    "zona" TEXT NOT NULL,
    "num_casa" TEXT,

    CONSTRAINT "Direccion_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Ubicacion" (
    "id" SERIAL NOT NULL,
    "id_direccion" INTEGER NOT NULL,
    "coordenadas" JSONB NOT NULL,
    "radio_cobertura" INTEGER NOT NULL DEFAULT 5000,

    CONSTRAINT "Ubicacion_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Provincia" (
    "id" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,
    "id_ciudad" INTEGER NOT NULL,

    CONSTRAINT "Provincia_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Busqueda" (
    "id" SERIAL NOT NULL,
    "criterio" TEXT NOT NULL,
    "fecha_creacion" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "id_usuario" INTEGER NOT NULL,

    CONSTRAINT "Busqueda_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Ejemplo" (
    "id" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,
    "apellido" TEXT NOT NULL,
    "edad" INTEGER NOT NULL,
    "id_ciudad" INTEGER NOT NULL,

    CONSTRAINT "Ejemplo_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Usuario_correo_key" ON "Usuario"("correo");

-- AddForeignKey
ALTER TABLE "Usuario" ADD CONSTRAINT "Usuario_id_ciudad_fkey" FOREIGN KEY ("id_ciudad") REFERENCES "Ciudad"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UsuarioRol" ADD CONSTRAINT "UsuarioRol_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "Usuario"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UsuarioRol" ADD CONSTRAINT "UsuarioRol_id_rol_fkey" FOREIGN KEY ("id_rol") REFERENCES "Rol"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Favorito" ADD CONSTRAINT "Favorito_id_usuario_rol_fkey" FOREIGN KEY ("id_usuario_rol") REFERENCES "UsuarioRol"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Favorito" ADD CONSTRAINT "Favorito_id_carro_fkey" FOREIGN KEY ("id_carro") REFERENCES "Carro"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Favorito" ADD CONSTRAINT "Favorito_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "Usuario"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Notificacion" ADD CONSTRAINT "Notificacion_id_usuario_rol_fkey" FOREIGN KEY ("id_usuario_rol") REFERENCES "Usuario"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Carro" ADD CONSTRAINT "Carro_id_direccion_fkey" FOREIGN KEY ("id_direccion") REFERENCES "Direccion"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Carro" ADD CONSTRAINT "Carro_id_usuario_rol_fkey" FOREIGN KEY ("id_usuario_rol") REFERENCES "Usuario"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CombustibleCarro" ADD CONSTRAINT "CombustibleCarro_id_carro_fkey" FOREIGN KEY ("id_carro") REFERENCES "Carro"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CombustibleCarro" ADD CONSTRAINT "CombustibleCarro_id_combustible_fkey" FOREIGN KEY ("id_combustible") REFERENCES "TipoCombustible"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "caracteristicasAdicionalesCarro" ADD CONSTRAINT "caracteristicasAdicionalesCarro_id_carro_fkey" FOREIGN KEY ("id_carro") REFERENCES "Carro"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "caracteristicasAdicionalesCarro" ADD CONSTRAINT "caracteristicasAdicionalesCarro_id_carasteristicasAdiciona_fkey" FOREIGN KEY ("id_carasteristicasAdicionales") REFERENCES "CarasteristicasAdicionales"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Imagen" ADD CONSTRAINT "Imagen_id_carro_fkey" FOREIGN KEY ("id_carro") REFERENCES "Carro"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Calificacion" ADD CONSTRAINT "Calificacion_id_carro_fkey" FOREIGN KEY ("id_carro") REFERENCES "Carro"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Calificacion" ADD CONSTRAINT "Calificacion_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "Usuario"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Reserva" ADD CONSTRAINT "Reserva_id_carro_fkey" FOREIGN KEY ("id_carro") REFERENCES "Carro"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Reserva" ADD CONSTRAINT "Reserva_id_descuento_fkey" FOREIGN KEY ("id_descuento") REFERENCES "Descuento"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Reserva" ADD CONSTRAINT "Reserva_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "Usuario"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Ciudad" ADD CONSTRAINT "Ciudad_id_pais_fkey" FOREIGN KEY ("id_pais") REFERENCES "Pais"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Direccion" ADD CONSTRAINT "Direccion_id_provincia_fkey" FOREIGN KEY ("id_provincia") REFERENCES "Provincia"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Ubicacion" ADD CONSTRAINT "Ubicacion_id_direccion_fkey" FOREIGN KEY ("id_direccion") REFERENCES "Direccion"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Provincia" ADD CONSTRAINT "Provincia_id_ciudad_fkey" FOREIGN KEY ("id_ciudad") REFERENCES "Ciudad"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Busqueda" ADD CONSTRAINT "Busqueda_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "Usuario"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

/*
  Warnings:

  - You are about to drop the column `fecha` on the `Descuento` table. All the data in the column will be lost.
  - You are about to drop the column `porcentaje` on the `Descuento` table. All the data in the column will be lost.
  - You are about to drop the column `id_descuento` on the `Reserva` table. All the data in the column will be lost.
  - You are about to drop the `Ejemplo` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Reserva" DROP CONSTRAINT "Reserva_id_descuento_fkey";

-- DropForeignKey
ALTER TABLE "Usuario" DROP CONSTRAINT "Usuario_id_ciudad_fkey";

-- AlterTable
ALTER TABLE "Calificacion" ALTER COLUMN "calf_carro" DROP NOT NULL,
ALTER COLUMN "calf_usuario" DROP NOT NULL;

-- AlterTable
ALTER TABLE "Carro" ADD COLUMN     "NumeroViajes" INTEGER DEFAULT 0,
ADD COLUMN     "disponible_desde" TIMESTAMP(3),
ADD COLUMN     "disponible_hasta" TIMESTAMP(3),
ADD COLUMN     "fecha_ingreso" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "id_tipodeDescuento" INTEGER,
ADD COLUMN     "ingresoTotal" DOUBLE PRECISION DEFAULT 0;

-- AlterTable
ALTER TABLE "Descuento" DROP COLUMN "fecha",
DROP COLUMN "porcentaje",
ADD COLUMN     "id_descuentoTipo" INTEGER,
ADD COLUMN     "montoDescontado" DOUBLE PRECISION;

-- AlterTable
ALTER TABLE "Direccion" ADD COLUMN     "latitud" DOUBLE PRECISION,
ADD COLUMN     "longitud" DOUBLE PRECISION,
ALTER COLUMN "zona" DROP NOT NULL;

-- AlterTable
ALTER TABLE "Garantia" ADD COLUMN     "descripcion" TEXT,
ADD COLUMN     "id_reserva" INTEGER,
ADD COLUMN     "pagoPorDaños" BOOLEAN;

-- AlterTable
ALTER TABLE "Imagen" ADD COLUMN     "format" TEXT,
ADD COLUMN     "height" INTEGER,
ADD COLUMN     "public_id" TEXT,
ADD COLUMN     "width" INTEGER,
ALTER COLUMN "data" SET DATA TYPE TEXT;

-- AlterTable
ALTER TABLE "Reserva" DROP COLUMN "id_descuento",
ADD COLUMN     "hora_fin" INTEGER,
ADD COLUMN     "hora_inicio" INTEGER,
ADD COLUMN     "kilometraje" INTEGER,
ADD COLUMN     "montoPagoInicial" DOUBLE PRECISION,
ADD COLUMN     "montoTotalConDescuento" DOUBLE PRECISION,
ALTER COLUMN "fecha_fin" DROP NOT NULL;

-- AlterTable
ALTER TABLE "Usuario" ALTER COLUMN "fecha_nacimiento" DROP NOT NULL,
ALTER COLUMN "genero" DROP NOT NULL,
ALTER COLUMN "id_ciudad" DROP NOT NULL,
ALTER COLUMN "telefono" DROP NOT NULL;

-- DropTable
DROP TABLE "Ejemplo";

-- CreateTable
CREATE TABLE "SeguroCarro" (
    "id" SERIAL NOT NULL,
    "fechaInicio" TIMESTAMP(3) NOT NULL,
    "fechaFin" TIMESTAMP(3) NOT NULL,
    "id_carro" INTEGER NOT NULL,
    "id_seguro" INTEGER NOT NULL,

    CONSTRAINT "SeguroCarro_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Seguro" (
    "id" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,
    "tipoSeguro" TEXT NOT NULL,
    "empresa" TEXT NOT NULL,

    CONSTRAINT "Seguro_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tipodeDescuento" (
    "id" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,
    "porcentaje" DOUBLE PRECISION NOT NULL,
    "fecha_inicio" TIMESTAMP(3),
    "fecha_fin" TIMESTAMP(3),

    CONSTRAINT "tipodeDescuento_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "contratodeAlquiler" (
    "id" SERIAL NOT NULL,
    "id_reserva" INTEGER NOT NULL,
    "kilometraje" INTEGER NOT NULL,
    "id_carro" INTEGER NOT NULL,
    "estado" TEXT NOT NULL DEFAULT 'pendiente',

    CONSTRAINT "contratodeAlquiler_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "aeropuerto" (
    "id" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,
    "latitud" DOUBLE PRECISION,
    "longitud" DOUBLE PRECISION,
    "id_ciudad" INTEGER NOT NULL,

    CONSTRAINT "aeropuerto_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_DescuentoToReserva" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,

    CONSTRAINT "_DescuentoToReserva_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateIndex
CREATE INDEX "_DescuentoToReserva_B_index" ON "_DescuentoToReserva"("B");

-- AddForeignKey
ALTER TABLE "Usuario" ADD CONSTRAINT "Usuario_id_ciudad_fkey" FOREIGN KEY ("id_ciudad") REFERENCES "Ciudad"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Carro" ADD CONSTRAINT "Carro_id_tipodeDescuento_fkey" FOREIGN KEY ("id_tipodeDescuento") REFERENCES "tipodeDescuento"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SeguroCarro" ADD CONSTRAINT "SeguroCarro_id_carro_fkey" FOREIGN KEY ("id_carro") REFERENCES "Carro"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SeguroCarro" ADD CONSTRAINT "SeguroCarro_id_seguro_fkey" FOREIGN KEY ("id_seguro") REFERENCES "Seguro"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Descuento" ADD CONSTRAINT "Descuento_id_descuentoTipo_fkey" FOREIGN KEY ("id_descuentoTipo") REFERENCES "tipodeDescuento"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Garantia" ADD CONSTRAINT "Garantia_id_reserva_fkey" FOREIGN KEY ("id_reserva") REFERENCES "Reserva"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "contratodeAlquiler" ADD CONSTRAINT "contratodeAlquiler_id_carro_fkey" FOREIGN KEY ("id_carro") REFERENCES "Carro"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "aeropuerto" ADD CONSTRAINT "aeropuerto_id_ciudad_fkey" FOREIGN KEY ("id_ciudad") REFERENCES "Ciudad"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_DescuentoToReserva" ADD CONSTRAINT "_DescuentoToReserva_A_fkey" FOREIGN KEY ("A") REFERENCES "Descuento"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_DescuentoToReserva" ADD CONSTRAINT "_DescuentoToReserva_B_fkey" FOREIGN KEY ("B") REFERENCES "Reserva"("id") ON DELETE CASCADE ON UPDATE CASCADE;

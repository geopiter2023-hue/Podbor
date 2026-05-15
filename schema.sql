SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for mapping
-- ----------------------------
DROP TABLE IF EXISTS `mapping`;
CREATE TABLE `mapping`  (
  `newMakeId` bigint UNSIGNED NOT NULL DEFAULT 0,
  `newModelId` bigint UNSIGNED NOT NULL DEFAULT 0,
  `newTypeId` bigint UNSIGNED NOT NULL DEFAULT 0,
  `seoType` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `makeId` int NULL DEFAULT NULL COMMENT 'Идентификатор марки ТС',
  `modelId` int NULL DEFAULT NULL COMMENT 'Идентификатор модели ТС',
  `typeId` varchar(53) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Идентификатор модификации',
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `newMakeId`(`newMakeId`) USING BTREE,
  INDEX `newMakeId_2`(`newMakeId`, `newModelId`) USING BTREE,
  INDEX `newMakeId_3`(`newMakeId`, `newModelId`, `newTypeId`) USING BTREE,
  INDEX `seoType`(`seoType`) USING BTREE,
  INDEX `makeId`(`makeId`) USING BTREE,
  INDEX `makeId_2`(`makeId`, `modelId`) USING BTREE,
  INDEX `makeId_3`(`makeId`, `modelId`, `typeId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23768 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for TObrands
-- ----------------------------
DROP TABLE IF EXISTS `TObrands`;
CREATE TABLE `TObrands`  (
  `id` int NULL DEFAULT NULL COMMENT 'Идентификатор марки ТС',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Название марки',
  UNIQUE INDEX `id`(`id`, `name`) USING BTREE,
  INDEX `id_2`(`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'Каталог ТО - Таблица марок' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for TOmodels
-- ----------------------------
DROP TABLE IF EXISTS `TOmodels`;
CREATE TABLE `TOmodels`  (
  `makeId` int NULL DEFAULT NULL COMMENT 'Идентификатор марки ТС',
  `modelId` int NULL DEFAULT NULL COMMENT 'Идентификатор модели ТС',
  `modelName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Название модели',
  `yearFrom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Начало выпуска',
  `yearTo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Окончание выпуска',
  UNIQUE INDEX `makeId`(`makeId`, `modelId`, `modelName`, `yearFrom`, `yearTo`) USING BTREE,
  INDEX `makeId_2`(`makeId`) USING BTREE,
  INDEX `modelId`(`modelId`) USING BTREE,
  CONSTRAINT `TOmodels_ibfk_1` FOREIGN KEY (`makeId`) REFERENCES `TObrands` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'Каталог ТО - Таблица моделей' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for TOmodifications
-- ----------------------------
DROP TABLE IF EXISTS `TOmodifications`;
CREATE TABLE `TOmodifications`  (
  `id` varchar(53) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Идентификатор модификации',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Название',
  `engineCode` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Код двигателя',
  `constructionType` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Кузов',
  `fuel` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Топливо',
  `horsePower` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Мощность двигателя, ЛС',
  `startDate` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Начало производства',
  `endDate` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Окончание производства',
  `engineCapacity` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Объем двигателя',
  `numberOfCylinders` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Количество цилиндров',
  `valves` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Клапаны',
  `valvesTotal` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Всего клапанов',
  `motorType` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Тип двигателя',
  `fullName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Полное название модификации',
  `brand` json NULL COMMENT 'Производитель',
  `model` json NULL COMMENT 'Модель',
  `makeId` int NULL DEFAULT NULL COMMENT 'Идентификатор марки ТС',
  `modelId` int NULL DEFAULT NULL COMMENT 'Идентификатор модели ТС',
  UNIQUE INDEX `id_2`(`id`, `name`, `engineCode`, `fullName`, `makeId`, `modelId`) USING BTREE,
  INDEX `makeId`(`makeId`, `modelId`) USING BTREE,
  INDEX `modelId`(`modelId`) USING BTREE,
  INDEX `id`(`id`) USING BTREE,
  CONSTRAINT `TOmodifications_ibfk_1` FOREIGN KEY (`makeId`) REFERENCES `TObrands` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `TOmodifications_ibfk_2` FOREIGN KEY (`modelId`) REFERENCES `TOmodels` (`modelId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'Каталог ТО - Модификации автомобилей' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for TOoils
-- ----------------------------
DROP TABLE IF EXISTS `TOoils`;
CREATE TABLE `TOoils`  (
  `makeId` int NULL DEFAULT NULL COMMENT 'Идентификатор марки',
  `modelId` int NULL DEFAULT NULL COMMENT 'Идентификатор модели',
  `modificationId` int NULL DEFAULT NULL COMMENT 'Идентификатор модификации',
  `catalogId` int NULL DEFAULT NULL COMMENT 'Техническое поле',
  `catalogItemId` int NULL DEFAULT NULL COMMENT 'Техническое поле',
  `orderPosition` int NULL DEFAULT NULL COMMENT 'Сортировка',
  `artNumber` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Артикул',
  `originalName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Оригинальное название',
  `volume` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Объем',
  `commentName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Пояснения',
  INDEX `makeId`(`makeId`, `modelId`, `modificationId`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'Каталог ТО - Технические жидкости' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for TOparts
-- ----------------------------
DROP TABLE IF EXISTS `TOparts`;
CREATE TABLE `TOparts`  (
  `makeId` int NULL DEFAULT NULL COMMENT 'Идентификатор Марки ТС',
  `modelId` int NULL DEFAULT NULL COMMENT 'Идентификатор Модели ТС',
  `modificationId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Идентификатор Модификации ТС',
  `manufacturerId` int NULL DEFAULT NULL COMMENT 'Идентификатор Производителя запчасти',
  `manufacturerName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Название производителя запчасти',
  `itemName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Наименование запчасти',
  `partNumber` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Номер запчасти',
  `quantity` int NULL DEFAULT NULL COMMENT 'Необходимое количество',
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Комментарии и пояснения',
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `makeId_2`(`makeId`, `modelId`, `modificationId`, `manufacturerId`, `partNumber`, `quantity`, `itemName`) USING BTREE,
  INDEX `makeId`(`makeId`, `modelId`, `modificationId`) USING BTREE,
  INDEX `modelId`(`modelId`) USING BTREE,
  INDEX `modificationId`(`modificationId`) USING BTREE,
  INDEX `itemName`(`itemName`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 600415 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'Каталог ТО - Таблица запчастей' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for TOpartsCrosses
-- ----------------------------
DROP TABLE IF EXISTS `TOpartsCrosses`;
CREATE TABLE `TOpartsCrosses`  (
  `manufacturerName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Название производителя запчасти',
  `partNumber` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Номер запчасти',
  `crossBrand` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT 'Бренд кросса',
  `crossNumber` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT 'Номер кросса',
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `manufacturerName`(`manufacturerName`, `partNumber`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 369657 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'Каталог ТО - Кроссы на запчасти' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;

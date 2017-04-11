/*

	Роли и основные пользователи в безе

*/

-- Роль администратора в бд
DROP ROLE IF EXISTS BicycleAdminRole;
CREATE ROLE BicycleAdminRole;

GRANT ALL ON Bicycle.* TO BicycleAdminRole;

-- Роль участника клуба
DROP ROLE IF EXISTS BicycleMemberRole;
CREATE ROLE BicycleMemberRole;

GRANT SELECT, INSERT, UPDATE, DROP, EXECUTE ON Bicycle.* TO BicycleMemberRole;
GRANT SELECT ON Bicycle.BikeType TO BicycleMemberRole;

-- Роль гостей сайта клуба
DROP ROLE IF EXISTS BicycleVisitorRole;
CREATE ROLE BicycleVisitorRole;

GRANT SELECT, EXECUTE ON Bicycle.* TO BicycleVisitorRole;

-- Аккаунт администратора
DROP USER IF EXISTS BicycleAdminAcc@localhost;
CREATE USER BicycleAdminAcc@localhost;

GRANT BicycleAdminRole TO BicycleAdminAcc@localhost;

-- Аккаунт участника
DROP USER IF EXISTS BicycleMemberAcc@localhost;
CREATE USER BicycleMemberAcc@localhost;

GRANT BicycleMemberRole TO BicycleMemberAcc@localhost;

-- Аккаунт гостя
DROP USER IF EXISTS BicycleVisitorAcc@localhost;
CREATE USER BicycleVisitorAcc@localhost;

GRANT BicycleVisitorRole TO BicycleVisitorAcc@localhost;
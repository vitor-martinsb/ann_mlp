LIBRARY WORK;
USE WORK.fixed_package.ALL;

ENTITY fixed_package_entity IS
	PORT(entrada1 : OUT fixed(4 DOWNTO -5);
		entrada2 : IN  fixed(4 DOWNTO -5));
END fixed_package_entity;

ARCHITECTURE teste OF fixed_package_entity IS
BEGIN	
	PROCESS(entrada2)
	BEGIN
		entrada1 <= entrada2 * (-2.25);
	END PROCESS;
	
END teste;
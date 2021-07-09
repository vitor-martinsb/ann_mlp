LIBRARY WORK;
USE WORK.fixed_package.ALL;

ENTITY fixed_package_entity IS
	PORT(entrada1 : OUT fixed(4 DOWNTO -5);
		entrada2 : IN  fixed(4 DOWNTO -5));
END fixed_package_entity;

ARCHITECTURE teste OF fixed_package_entity IS
	CONSTANT VALUE_REAL: REAL := -6.1;
BEGIN	
	PROCESS(entrada2)
	BEGIN
		entrada1 <= to_fixed(VALUE_REAL,4,-5);
	END PROCESS;
	
END teste;
LIBRARY WORK;
USE WORK.fixed_package.ALL;

ENTITY fixed_package_entity IS
	PORT(saida	  : OUT fixed(N_BIT-1 DOWNTO 0);
		 entrada1 : IN INTEGER RANGE 32767 DOWNTO -32768;
		 entrada2 : IN fixed(N_BIT-1 DOWNTO 0));
END fixed_package_entity;

ARCHITECTURE teste OF fixed_package_entity IS
BEGIN
	PROCESS(entrada1,entrada2)
	BEGIN
		saida <= entrada1 + entrada2;
	END PROCESS;
END teste;
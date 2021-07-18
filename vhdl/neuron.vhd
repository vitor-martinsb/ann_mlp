LIBRARY WORK;
USE WORK.fixed_package.ALL;

ENTITY neuron IS
	GENERIC(N: INTEGER := 9);
	PORT(	
			entrada2: IN fixed(0 DOWNTO -15);
			entrada1: OUT fixed(0 DOWNTO -15)
			--B : IN fixed(max_ind DOWNTO min_ind);
			--Y : OUT fixed(max_ind DOWNTO min_ind)
			--X : IN fixed_vector(0 TO N-1, max_ind DOWNTO min_ind);
			--W : IN fixed_vector(0 TO N-1, max_ind DOWNTO min_ind);
		);
END neuron;

ARCHITECTURE teste OF neuron IS
BEGIN
	PROCESS(entrada2)
	BEGIN
		entrada1 <= entrada2 * (-0.35);
	END PROCESS;
END teste;
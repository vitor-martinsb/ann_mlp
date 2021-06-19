----------------------------
--Vitor Martins Barbosa

--12099991

--Descrição:

-- Exercío de Aula 09
----------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.MATH_REAL.ALL;

PACKAGE fixed_package IS
	CONSTANT N_BIT: INTEGER := 16;
	CONSTANT max_ind: INTEGER := 15;
	CONSTANT min_ind: INTEGER := -15;
	TYPE fixed IS ARRAY(NATURAL RANGE <>)OF BIT;
	TYPE matrix is array (NATURAL RANGE <>, NATURAL RANGE <>) OF BIT;
	SUBTYPE fixed_range IS integer RANGE min_ind TO max_ind;
	FUNCTION MAX (arg_L, arg_R: INTEGER) RETURN INTEGER;
	FUNCTION MIN (arg_L, arg_R: INTEGER) RETURN INTEGER;
	FUNCTION COMP1_FIXED(arg_L: fixed) RETURN fixed;
	FUNCTION ADD_SUB_FIXED (arg_L, arg_R: fixed; c: bit) RETURN fixed;
	FUNCTION MULT_FIXED (arg_L, arg_R: fixed) RETURN fixed;
	FUNCTION to_fixed (arg_L: INTEGER; max_range: fixed_range := MAX_IND;
						min_range: fixed_range := 0) RETURN fixed;
	FUNCTION to_integer (arg_L: fixed) RETURN integer;
	FUNCTION "+"(arg_L, arg_R: fixed) RETURN fixed;
	FUNCTION "+"(arg_L: fixed; arg_R: INTEGER) RETURN fixed;
	FUNCTION "+"(arg_L: INTEGER; arg_R: fixed) return fixed;
	FUNCTION "-"(arg_L, arg_R: fixed) RETURN fixed;
	FUNCTION "-"(arg_L: fixed; arg_R: INTEGER) RETURN fixed;
	FUNCTION "-"(arg_L: INTEGER; arg_R: fixed) RETURN fixed;

END fixed_package; 

PACKAGE BODY fixed_package IS
--Internas
	--Auxiliares aritmeticas
	--MAX
		FUNCTION MAX (arg_L, arg_R: INTEGER) RETURN INTEGER IS
		BEGIN
			IF arg_L > arg_R THEN
				return arg_L;
			ELSE
				return arg_R;
			END IF;
		END MAX;
	--MIN
		FUNCTION MIN (arg_L, arg_R: INTEGER) RETURN INTEGER IS
		BEGIN
			IF arg_L < arg_R THEN
				RETURN arg_L;
			ELSE
				RETURN arg_R;
			END IF;
		END MIN;
	--COMP1_FIXED
		FUNCTION COMP1_FIXED(arg_L: fixed) RETURN fixed IS
			VARIABLE arg_L_COMP1: fixed(arg_L'LENGTH-1 DOWNTO 0);
		BEGIN
			FOR k in 0 TO arg_L'LENGTH-1 LOOP
				arg_L_COMP1(k) := NOT(arg_L(k)); 
			END LOOP;
			RETURN arg_L_COMP1;
		END COMP1_FIXED;
	--ADD_SUB_FIXED
		FUNCTION ADD_SUB_FIXED (arg_L, arg_R: fixed; c: bit) return fixed IS
			VARIABLE s: fixed(0 TO arg_L'LENGTH-1);
			VARIABLE v: bit;
		BEGIN
			v := c;
			FOR k in 0 TO arg_L'LENGTH -1 LOOP
				s(k) := (arg_L(k) XOR arg_R(k)) XOR v;
				v := (arg_L(k) AND arg_R(k)) OR (v AND (arg_L(k) OR arg_R(k)));
			END LOOP;
			RETURN s;
		END ADD_SUB_FIXED;
		
	--MULT_FIXED
		FUNCTION MULT_FIXED (arg_L, arg_R: fixed) return fixed IS
			CONSTANT M: INTEGER := arg_L'length;
			CONSTANT N: INTEGER := arg_R'length;
			VARIABLE Mij: matrix(0 TO M-1, 0 TO M+N-1);
			VARIABLE Cij: matrix(0 TO M-1, 0 TO M+N);
			VARIABLE Pij: matrix(0 TO M, 0 to M+N);
			VARIABLE blinha: fixed(m+n-1 downto 0);
			VARIABLE P: fixed(M+N-1 DOWNTO 0);
		BEGIN
			
			blinha := (M+N-1 downto N => '0') & arg_R;
			
			initCij: FOR i IN 0 TO M-1 LOOP
				Cij(i, 0) := '0';
			END LOOP initCij;
			
			initPij1: FOR i IN 0 to M LOOP
				Pij(i, 0) := '0';
			END LOOP initPij1;
			
			initPij2: FOR j IN 1 TO M+N-1 LOOP
				Pij(m, j) := '0';
			END LOOP initPij2;
			
			Mijcol: FOR i IN M-1 DOWNTO 0 LOOP
				Mijrow: FOR j IN M+N-1 DOWNTO 0 LOOP
					Mij(i,j) := arg_L(i) and blinha(j);
				END LOOP Mijrow;
			END LOOP Mijcol;
			
			Pijcol: FOR i IN M-1 DOWNTO 0 LOOP
				Pijrow: FOR j IN 0 TO M+N-1 LOOP
					Pij(i,j+1) := Pij(i+1,j) XOR Mij(i,j) XOR Cij(i,j);
					Cij(i,j+1) := (Pij(i+1,j) AND (Mij(i,j) OR Cij(i,j))) OR (Mij(i,j) AND Cij(i,j));
					--SOMA: som PORT MAP(Pij(i+1,j),Cij(i,j),Mij(i,j),Pij(i,j+1),Cij(i,j+1));
				END LOOP Pijrow;
			END LOOP Pijcol;
			
			initPi: FOR i IN M+N-1 DOWNTO 0 LOOP
				P(i) := Pij(0,i+1);
			END LOOP initPi;

			RETURN P;		
		END MULT_FIXED;
			
--Externas
	--Conversao de tipo
		--to_fixed
		FUNCTION to_fixed (arg_L: INTEGER; max_range: fixed_range := max_ind;
							min_range: fixed_range := 0) RETURN fixed IS
			VARIABLE int_res		: integer := arg_L;						
			VARIABLE res			: fixed (max_range DOWNTO min_range);
			VARIABLE res_0			: fixed (max_range DOWNTO min_range);   
	  
		BEGIN
			FOR k IN min_range TO max_range LOOP
				res(k) := '0';
				res_0(k) := '0';
			END LOOP;
			
			IF int_res<0 THEN
				int_res:=int_res*(-1);
			END IF;
			
			IF int_res = 1 THEN
				res(min_range) := '1';
			ELSE
				FOR k IN min_range TO max_range-1 LOOP
					IF int_res >= 1 AND int_res >= -1 THEN 
						IF (int_res MOD 2) = 0 THEN
							res(k) := '0';
						ELSE
							res(k) := '1';
						END IF;
						int_res := INTEGER(int_res / 2);
					ELSE
						res(k) := '0';
					END IF;
					
				END LOOP;
			END IF;
			
			IF arg_L < 0 THEN
				res(max_range) := '1';
			END IF;
			
			RETURN res;
		END	to_fixed;	
					
		--to_integer
		FUNCTION to_integer (arg_L: fixed) RETURN INTEGER IS
			VARIABLE v_arg_L: fixed(arg_L'RANGE);
			VARIABLE res: INTEGER := 0;	
		BEGIN
		
			v_arg_L := arg_L;
			
			IF arg_L(arg_L'LEFT) = '1' THEN
				v_arg_L := COMP1_FIXED(arg_L);
			END IF;
			
			FOR k IN v_arg_L'RANGE LOOP
				IF v_arg_L(k) = '1' THEN
					res := (2**k) + res;
				END IF;
			END LOOP;
			
			IF arg_L(arg_L'LEFT) = '1' THEN
				res := -1*(res+1);
			END IF;
			
			RETURN res;
		END to_integer;		
		--Aritmeticas
		-- +
		FUNCTION "+" (arg_L, arg_R: fixed) RETURN fixed IS
			VARIABLE res: fixed(arg_L'LENGTH-1 DOWNTO 0);
		BEGIN	
			res := ADD_SUB_FIXED(arg_L, arg_R, '0');
			RETURN res;
		END "+";
		-- -	
		FUNCTION "-" (arg_L, arg_R: fixed) RETURN fixed IS
			VARIABLE NEG_arg_R:  fixed(arg_L'LENGTH-1 DOWNTO 0); 
			VARIABLE res: fixed(arg_L'LENGTH-1 DOWNTO 0);
		BEGIN
			NEG_arg_R := COMP1_FIXED(arg_R);
			res := ADD_SUB_FIXED(arg_L, NEG_arg_R, '1');
			RETURN res;
		END "-";
		
		--"+"
		FUNCTION "+"(arg_L: fixed; arg_R: INTEGER) RETURN fixed IS
			VARIABLE res: fixed(arg_L'LENGTH-1 DOWNTO 0);
			VARIABLE arg_F: fixed(arg_L'LENGTH-1 DOWNTO 0);
		BEGIN
			arg_F := to_fixed(arg_R);
			RETURN arg_L + arg_F;
		END "+";
		
		FUNCTION "+" (arg_L: INTEGER; arg_R: fixed) RETURN fixed IS
			VARIABLE res: fixed(arg_R'LENGTH-1 DOWNTO 0);
			VARIABLE arg_F: fixed(arg_R'LENGTH-1 DOWNTO 0);
		BEGIN
			arg_F := to_fixed(arg_L);
			RETURN arg_F + arg_R;
		END "+";
		
		--"-"
		FUNCTION "-" (arg_L: fixed; arg_R: INTEGER) RETURN fixed IS
			VARIABLE res: fixed(arg_L'LENGTH-1 DOWNTO 0);
			VARIABLE arg_F: fixed(arg_L'LENGTH-1 DOWNTO 0);
		BEGIN
			arg_F := to_fixed(arg_R);
			RETURN arg_L - arg_F;
		END "-";
		
		FUNCTION "-" (arg_L: INTEGER; arg_R: fixed) RETURN fixed IS
			VARIABLE res: fixed(arg_R'LENGTH-1 DOWNTO 0);
			VARIABLE arg_F: fixed(arg_R'LENGTH-1 DOWNTO 0);
		BEGIN	
			arg_F := to_fixed(arg_L);
			RETURN arg_F - arg_R;
		END "-";
END fixed_package;

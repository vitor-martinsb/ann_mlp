USE work.neuron_pkg.all;
USE work.fixed_package.all;


ENTITY neuron IS
	GENERIC( INPUT: INTEGER := 9;
		Q_L : fixed_range := 3;
		Q_R : fixed_range := -12
	);
	PORT(
		X : BUFFER fixed_vector(INPUT-1 downto 0, Q_L DOWNTO Q_R);
		W_1 : BUFFER fixed_vector(INPUT-1 downto 0, Q_L DOWNTO Q_R);
		B_1 : BUFFER fixed(Q_L DOWNTO Q_R);
		W_2 : BUFFER fixed(Q_L DOWNTO Q_R);
		B_2 : BUFFER fixed(Q_L DOWNTO Q_R);
		Y_1 : OUT fixed(Q_L DOWNTO Q_R);
		Y_2 : OUT fixed(Q_L DOWNTO Q_R)
	);
END ENTITY;

ARCHITECTURE STRUTUCTAL OF neuron IS
BEGIN
	PROCESS(X,W_1,W_2,B_1,B_2)
		VARIABLE V : FIXED(Q_L DOWNTO Q_R);
		VARIABLE aux : FIXED(Q_L DOWNTO Q_R);
		VARIABLE X_tmp, W_tmp : fixed(Q_L DOWNTO Q_R);
	BEGIN
		v := (OTHERS => '0');
		B_1 <= to_fixed(-4.389378, Q_L, Q_R);
		W_2 <= to_fixed(-2.800294, Q_L, Q_R);
		B_2 <= to_fixed(-0.830327, Q_L, Q_R);
--		[-1.3688   -1.3308   -1.3595   -1.3696   -0.2197   -2.3010   -0.0300   -1.5020    1.2731]
		aux := to_fixed(-1.3688,Q_L,Q_R);
		FOR k IN Q_L DOWNTO Q_R LOOP
			W_1(0,k) <= aux(k);
		END LOOP;
		
		aux := to_fixed(-1.3308,Q_L,Q_R);
		FOR k IN Q_L DOWNTO Q_R LOOP
			W_1(1,k) <= aux(k);
		END LOOP;
		
		aux := to_fixed(-1.3595,Q_L,Q_R);
		FOR k IN Q_L DOWNTO Q_R LOOP
			W_1(2,k) <= aux(k);
		END LOOP;
		
		aux := to_fixed(-1.3696,Q_L,Q_R);
		FOR k IN Q_L DOWNTO Q_R LOOP
			W_1(3,k) <= aux(k);
		END LOOP;
		
		aux := to_fixed(-0.2197,Q_L,Q_R);
		FOR k IN Q_L DOWNTO Q_R LOOP
			W_1(4,k) <= aux(k);
		END LOOP;
		
		aux := to_fixed(-2.3010,Q_L,Q_R);
		FOR k IN Q_L DOWNTO Q_R LOOP
			W_1(5,k) <= aux(k);
		END LOOP;
		
		aux := to_fixed(-0.0300,Q_L,Q_R);
		FOR k IN Q_L DOWNTO Q_R LOOP
			W_1(6,k) <= aux(k);
		END LOOP;
		
		aux := to_fixed(-1.5020,Q_L,Q_R);
		FOR k IN Q_L DOWNTO Q_R LOOP
			W_1(7,k) <= aux(k);
		END LOOP;
		
		aux := to_fixed(1.2731,Q_L,Q_R);
		FOR k IN Q_L DOWNTO Q_R LOOP
			W_1(8,k) <= aux(k);
		END LOOP;

--		[0.0000 0.0000 0.0000 0.0000 0.5000 0.0000 1.0000 0.0000 0.0000] B
		
		aux := to_fixed(0.0000,Q_L,Q_R);
		FOR k IN Q_L DOWNTO Q_R LOOP
			X(0,k) <= aux(k);
		END LOOP;
		
		aux := to_fixed(0.0000,Q_L,Q_R);
		FOR k IN Q_L DOWNTO Q_R LOOP
			X(1,k) <= aux(k);
		END LOOP;
		
		aux := to_fixed(0.0000,Q_L,Q_R);
		FOR k IN Q_L DOWNTO Q_R LOOP
			X(2,k) <= aux(k);
		END LOOP;
		
		aux := to_fixed(0.0000,Q_L,Q_R);
		FOR k IN Q_L DOWNTO Q_R LOOP
			X(3,k) <= aux(k);
		END LOOP;
		
		aux := to_fixed(0.5000,Q_L,Q_R);
		FOR k IN Q_L DOWNTO Q_R LOOP
			X(4,k) <= aux(k);
		END LOOP;
		
		aux := to_fixed(0.0000,Q_L,Q_R);
		FOR k IN Q_L DOWNTO Q_R LOOP
			X(5,k) <= aux(k);
		END LOOP;
		
		aux := to_fixed(1.0000,Q_L,Q_R);
		FOR k IN Q_L DOWNTO Q_R LOOP
			X(6,k) <= aux(k);
		END LOOP;
		
		aux := to_fixed(0.0000,Q_L,Q_R);
		FOR k IN Q_L DOWNTO Q_R LOOP
			X(7,k) <= aux(k);
		END LOOP;
		
		aux := to_fixed(0.0000,Q_L,Q_R);
		FOR k IN Q_L DOWNTO Q_R LOOP
			X(8,k) <= aux(k);
		END LOOP;
		
-- 		[0.0000 1.0000 0.7143 0.5714 0.4286 0.8571 0.8571 0.0000 0.7143] M		

--		aux := to_fixed(0.0,Q_L,Q_R);
--		FOR k IN Q_L DOWNTO Q_R LOOP
--			X(0,k) <= aux(k);
--		END LOOP;
--		
--		aux := to_fixed(1.0000,Q_L,Q_R);
--		FOR k IN Q_L DOWNTO Q_R LOOP
--			X(1,k) <= aux(k);
--		END LOOP;
--		
--		aux := to_fixed(0.7143,Q_L,Q_R);
--		FOR k IN Q_L DOWNTO Q_R LOOP
--			X(2,k) <= aux(k);
--		END LOOP;
--		
--		aux := to_fixed(0.5714,Q_L,Q_R);
--		FOR k IN Q_L DOWNTO Q_R LOOP
--			X(3,k) <= aux(k);
--		END LOOP;
--		
--		aux := to_fixed(0.4286,Q_L,Q_R);
--		FOR k IN Q_L DOWNTO Q_R LOOP
--			X(4,k) <= aux(k);
--		END LOOP;
--		
--		aux := to_fixed(0.8571,Q_L,Q_R);
--		FOR k IN Q_L DOWNTO Q_R LOOP
--			X(5,k) <= aux(k);
--		END LOOP;
--		
--		aux := to_fixed(0.8571,Q_L,Q_R);
--		FOR k IN Q_L DOWNTO Q_R LOOP
--			X(6,k) <= aux(k);
--		END LOOP;
--		
--		aux := to_fixed(0.0,Q_L,Q_R);
--		FOR k IN Q_L DOWNTO Q_R LOOP
--			X(7,k) <= aux(k);
--		END LOOP;
--		
--		aux := to_fixed(0.7143,Q_L,Q_R);
--		FOR k IN Q_L DOWNTO Q_R LOOP
--			X(8,k) <= aux(k);
--		END LOOP;

		FOR i in INPUT-1 DOWNTO 0 LOOP
			FOR j in Q_L DOWNTO Q_R LOOP
				W_tmp(j) := W_1(i,j);
				X_tmp(j) := X(i,j);
			END LOOP;
			v := v + W_tmp * X_tmp;
		END LOOP;
		v := v-B_1;
		Y_1 <= Activation2(v);
		Y_2 <= Activation1((Activation2(v)*W_2)-B_2);
		
	END PROCESS;
END STRUTUCTAL;
			 
.data 						# Sección para declarar variables

 pregunta: .asciiz "Digita un valor de N: " 	# Declara una cadena de caracteres
 n: .word 0 					# Declara un entero con valor 0
 a: .word 0 					# Declara un entero con valor 0
 b: .word 1 					# Declara un entero con valor 1
 c: .word 0 					# Declara un entero con valor 0
 newline: .asciiz "\n"				# Salto de linea

.text 						# Sección de código
 
#asignar valor a n
 li $v0, 4               			# Código de servicio 4 para imprimir una cadena
 la $a0, pregunta       			# Carga la dirección de la cadena en $a0
 syscall                 			# Llama al sistema para imprimir
 
 li $v0, 5           				# Cargar el código del servicio 5 para leer un entero
 syscall             				# Llamar al sistema para leer el entero ingresado por el usuario
 move $s0, $v0       				# Guardar el primer número en $s0
 
 li $t0, 1   					# Inicializamos el contador a 0
 lw $t3, a       				# Carga el valor de a en el registro $t3
 lw $t2, b       				# Carga el valor de b en el registro $t2
 
 loop:
    # Comprobamos si hemos alcanzado el final del bucle
    bge $t0, $s0, end_loop   			# Si t0 >= t1, salimos del bucle
    
    # Imprimir el valor de 'a'
    move $a0, $t3   				# Pasar el valor de 'a' a $a0 para imprimirlo
    li $v0, 1       				# Cargar el código de servicio 1 para imprimir un entero
    syscall         				# Llamar al sistema para imprimir el entero
    
    # Imprimir nueva línea
    li $v0, 4					# Código de servicio 4 para imprimir una cadena
    la $a0, newline				# Carga la dirección de la cadena en $a0
    syscall					# Llama al sistema para imprimir
    
    # Calcular 'c'
    add $t4, $t3, $t2   			# Sumar 'a' y 'b' y almacenar el resultado en $t4
    
    # Actualizar 'a' con el valor de 'b'
    move $t3, $t2   				# Mover el valor de 'b' a 'a'
    
    # Actualizar 'b' con el valor de 'c'
    move $t2, $t4   				# Mover el valor de 'c' a 'b'
    
    # Incrementamos el contador
    addi $t0, $t0, 1   				# Incrementamos t0 en 1
    
    # Saltamos de vuelta al inicio del bucle
    j loop
    
 end_loop:
    li $v0, 10   				# Código de salida del programa
    syscall					# Llama al sistema para imprimir

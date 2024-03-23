.data 					# Secci�n para declarar variables

pregunta1: .asciiz "Ingrese el valor del primer numero: "
pregunta2: .asciiz "Ingrese el valor del segundo numero: "
pregunta3: .asciiz "Ingrese el valor del tercer numero: "
result: .asciiz "El numero menor es: "
newline: .asciiz "\n"

.text 					# Secci�n de c�digo

main:

#pregunta 1
 li $v0, 4               		# C�digo de servicio 4 para imprimir una cadena
 la $a0, pregunta1       		# Carga la direcci�n de la cadena en $a0
 syscall                 		# Llama al sistema para imprimir
 
 li $v0, 5           			# Cargar el c�digo del servicio 5 para leer un entero
 syscall             			# Llamar al sistema para leer el entero ingresado por el usuario
 move $s0, $v0       			# Guardar el primer n�mero en $s0

#pregunta 2
 li $v0, 4               		# C�digo de servicio 4 para imprimir una cadena
 la $a0, pregunta2       		# Carga la direcci�n de la cadena en $a0
 syscall                 		# Llama al sistema para imprimir
 
 li $v0, 5           			# Cargar el c�digo del servicio 5 para leer un entero
 syscall             			# Llamar al sistema para leer el entero ingresado por el usuario
 move $s1, $v0       			# Guardar el segundo n�mero en $s1
 
 #pregunta 3
 li $v0, 4               		# C�digo de servicio 4 para imprimir una cadena
 la $a0, pregunta3       		# Carga la direcci�n de la cadena en $a0
 syscall                 		# Llama al sistema para imprimir
 
 li $v0, 5           			# Cargar el c�digo del servicio 5 para leer un entero
 syscall             			# Llamar al sistema para leer el entero ingresado por el usuario
 move $s2, $v0       			# Guardar el tercer n�mero en $s2
 
 #Comparar los numeros 
 blt  $s0, $s1, check_s0_s2   		# Si s0 < s1, saltar a la comparaci�n entre s0 y s2
 blt  $s1, $s2, check_s1      		# Si no, comprobar si s1 < s2
 move $t0, $s2               		# Si no, s2 es el menor, lo guardamos en $t0
 j print_result              		# Saltar a imprimir el resultado

check_s0_s2:
    blt  $s0, $s2, s0_is_min     	# Si s0 < s2, s0 es el menor, salta a imprimirlo
    move $t0, $s2               	# Si no, s2 es el menor, lo guardamos en $t0
    j print_result              	# Saltar a imprimir el resultado

check_s1:
    blt  $s1, $s2, s1_is_min     	# Si s1 < s2, s1 es el menor, salta a imprimirlo
    move $t0, $s2               	# Si no, s2 es el menor, lo guardamos en $t0
    j print_result              	# Saltar a imprimir el resultado
    
s0_is_min:
    move $t0, $s0               	# Guardar s0 en $t0, ya que s0 es el menor
    j print_result              	# Saltar a imprimir el resultado
    
s1_is_min:
    move $t0, $s1               	# Guardar s1 en $t0, ya que s1 es el menor
    j print_result              	# Saltar a imprimir el resultado
    
print_result:
    # Imprimir el n�mero menor
    li $v0, 4           		# Cargar el c�digo del servicio 4 para imprimir una cadena
    la $a0, result      		# Cargar la direcci�n de la cadena result en $a0
    syscall             		# Llamar al sistema para imprimir la cadena
    
    # Imprimir el valor del n�mero menor
    li $v0, 1           		# Cargar el c�digo del servicio 1 para imprimir un entero
    move $a0, $t0       		# Cargar el n�mero menor en $a0
    syscall             		# Llamar al sistema para imprimir el n�mero
    
    # Imprimir una nueva l�nea
    li $v0, 4           		# Cargar el c�digo del servicio 4 para imprimir una cadena
    la $a0, newline     		# Cargar la direcci�n de la cadena newline en $a0
    syscall             		# Llamar al sistema para imprimir la cadena
    
    # Finalizar el programa
    li $v0, 10          		# Cargar el c�digo del servicio 10 para terminar el programa
    syscall             		# Llamar al sistema para terminar el programa

# Descripción entidad de caché

Esta entidad VHDL implementa una caché asociativa de 2 vías para un procesador que utiliza el pipeline de MIPS. Opera con direcciones de 32 bits y datos de salida de 32 bits. 
Divide la dirección en un tag de 10 bits, un índice de 8 bits y un desplazamiento (offset) de 5 bits. 
La caché utiliza la política de reemplazo del menos utilizado recientemente (LRU). 

## Entidad `cacheLRU`: 

### Puertos: 

- **Entradas**:
	- `clock` (std_logic): Señal de reloj 
	- `Address` (std_logic_vector(31 DOWNTO 0)): Dirección de 32 bits desde el cual se va a leer el dato. 

- **Salidas:**
  - `hit` (std_logic): Indica si el dato solicitado se encuentra en la caché.
  - `data_out` (std_logic_vector(31 DOWNTO 0)): Dato de 32 bits leído de la caché.
  - `tag_out` (std_logic_vector(16 DOWNTO 0)): Parte del tag de la dirección de salida.
  - `index_out` (std_logic_vector(8 DOWNTO 0)): Parte del índice de la dirección de salida.
  - `offset_out` (std_logic_vector(5 DOWNTO 0)): Parte del desplazamiento de la dirección de salida.
  - `miss_out` (std_logic): Indica si el dato solicitado no se encuentra en la caché.


## Arquitectura:

### Tipos y Señales Internas

- **Tipos:**
  - `bloque`: Tipo de array que representa un bloque de caché (array de std_logic_vector(16 DOWNTO 0)).
  - `t_set`: Tipo de array que representa un conjunto de bloques de caché (array de `bloque`).
  - `t_tag`: Tipo de array que representa un conjunto de tags.
  - `t_valid`: Tipo de array que representa bits de validez para los bloques de caché.
  - `t_Dirty`: Tipo de array que representa bits de suciedad para los bloques de caché.
  - `t_LRU`: Tipo de array que representa bits LRU para los bloques de caché.
  - `t_Memory`: Tipo de array que representa la memoria principal.

- **Señales:**
  - `cache0`, `cache1`: Dos conjuntos de caché.
  - `dirtys0`, `dirtys1`: Bits de suciedad para ambos conjuntos de caché.
  - `valids0`, `valids1`: Bits de validez para ambos conjuntos de caché.
  - `tags0`, `tags1`: Tags para ambos conjuntos de caché.
  - `lru0`, `lru1`: Bits LRU para ambos conjuntos de caché.
  - `s_tag`, `s_index`, `s_offset`: Señales para almacenar partes de la dirección de entrada.
  - `data`: Señal para almacenar los datos leídos de la caché o de la memoria principal.
  - `hit_addr`: Señal que indica si la dirección es un hit en la caché.
  - `miss`: Señal que indica si la dirección es un miss en la caché.
  - `mainmem`: Señal que representa la memoria principal.

### Proceso

El proceso se activa con el flanco positivo de la señal `clock`.
Realiza los siguientes pasos:

1. **Extraen los componentes de la dirección:**
   - `s_tag` <= Address(31 DOWNTO 15)
   - `s_index` <= Address(14 DOWNTO 6)
   - `s_offset` <= Address(5 DOWNTO 0)
  
2. **Comprobar Validez y Tags:**
   - Se verifica si el bit de validez está configurado para cualquiera de los conjuntos de caché.
   - Luego se verificar si el tag coincide con los tags almacenados en cualquiera de los conjuntos de caché.
   - Si es válido y el tag coincide, se leen los datos del conjunto de caché correspondiente y se cambian los valores de `hit_addr` a '1' y `miss` a '0'. Ya que se encontró el dato en la caché. 

3. **Reemplazo LRU:**
   - Si el bit en LRU indica el conjunto 0, se actualiza el conjunto 0.
     - Se configura el bit de validez para el conjunto 0.
     - Se actualiza el bit de LRU para indicar el uso reciente del conjunto 0.
     - Se almacena el tag y los datos en el conjunto 0.
   - De lo contrario, se actualiza el conjunto 1.
     - Se configurar el bit de validez para el conjunto 1.
     - Se actualiza el bit de LRU para indicar el uso reciente del conjunto 1.
     - Se almacena el tag y los datos en el conjunto 1.

4. **Señales de Salida:**
   - Se asigna `hit_addr` a `hit`.
   - Se asigna `data` a `data_out`.
   - Se asignar `miss` a `miss_out`.



## Notas Adicionales

- En este primer diseño, la caché se implementó para interactuar con una memoria principal simplificada (`mainmem`), que está precargada con datos de ejemplo. 
- La política de reemplazo LRU asegura que el bloque de caché menos usado recientemente sea reemplazado cuando se carga un nuevo bloque en la caché.
- Esta implementación asume operaciones de solo lectura y no maneja operaciones de escritura ni actualizaciones de bits de suciedad.
- Esta implementación es un primer acercamiento al diseño de una cache, por eso las salidas incluyen el desplazamiento (offset), index y el tag. Esto para ver que estaba funcionando de manera correcta. 

## Mejoras a implementar:

- Implementar políticas de write-back y write-through.
- Integrar con un modelo de memoria principal
- Cambiar la interfaz de VHDL para poder integrar con el procesador de pipeline MIPS

#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Feb 19 15:37:01 2024

@author: Andres hernandez
"""
import matplotlib.pyplot as plt

# Datos
languages = ['WALLACE TREE', 'BOOTH PARALLEL', 'BAUGH-WOLLEY', 'PYTHON*1000', 'C++', 'MATLAB*100', 'GOLANG', 'JAVA*100']
operation_times = [13.03, 15.75, 10.82, 100.130, 160, 68.00, 146, 12.78]  # Tiempo de operación en nanosegundos

# Escalar los datos de Python
scaled_times = [time / max(operation_times) * 100 for time in operation_times]

# Crear el gráfico de barras
plt.figure(figsize=(10, 6))
plt.bar(languages, scaled_times, color='skyblue')

# Añadir título y etiquetas
plt.title('Operation Time by Programming Language (8-bit Operation)')
plt.xlabel('Programming Language')
plt.ylabel('Scaled Operation Time (%)')
plt.xticks(rotation=45, ha='right')

# Añadir cuadrícula
plt.grid(axis='y', linestyle='--', alpha=0.7)

# Añadir valores en las barras
for i, time in enumerate(scaled_times):
    plt.text(i, time, f'{operation_times[i]} ns', ha='center', va='bottom')

# Mostrar el gráfico
plt.tight_layout()
plt.show()

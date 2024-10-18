import 'package:empleados_test/models/departamento.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:empleados_test/controllers/alta_empleado_controller.dart';

class AltaEmpleadoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AltaEmpleadoController controller = Get.put(AltaEmpleadoController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de Empleado'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nombre Completo (No requiere Obx)
            TextField(
              onChanged: (value) => controller.nombre.value = value,
              decoration: InputDecoration(
                labelText: 'Nombre Completo',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Fecha de Nacimiento (No requiere Obx)
            TextField(
              onChanged: (value) => controller.fechanac.value = value,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                labelText: 'Fecha de Nacimiento (YYYY-MM-DD)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Correo Electrónico (No requiere Obx)
            TextField(
              onChanged: (value) => controller.correo.value = value,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Correo Electrónico',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Estatus (Checkbox) -- Esto sí requiere Obx porque depende de una variable observable
            Row(
              children: [
                Obx(() => Checkbox(
                      value: controller.estatus.value,
                      onChanged: (bool? value) {
                        controller.estatus.value = value ?? false;
                      },
                    )),
                const Text('Activo'),
              ],
            ),
            const SizedBox(height: 16),

            // Departamento (Dropdown con datos de la API) -- También usa Obx
            Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else {
                return DropdownButton<Departamento>(
                  hint: const Text('Selecciona un departamento'),
                  value: controller.selectedDepartamento.value,
                  onChanged: (Departamento? newValue) {
                    controller.selectedDepartamento.value = newValue;
                  },
                  items: controller.departamentos.map((departamento) {
                    return DropdownMenuItem<Departamento>(
                      value: departamento,
                      child: Text(departamento.nombre),
                    );
                  }).toList(),
                );
              }
            }),
            const SizedBox(height: 16),

            // Botón para registrar el empleado (No requiere Obx)
            ElevatedButton(
              onPressed: () {
                controller.registrarEmpleado();
              },
              child: const Text('Registrar Empleado'),
            ),
          ],
        ),
      ),
    );
  }
}

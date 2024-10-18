<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Empleado;
use Illuminate\Http\Request;

class EmpleadoController extends Controller
{
    public function show($id)
    {
        $empleado = Empleado::find($id);
        if ($empleado) {
            return response()->json($empleado, 200);
        } else {
            return response()->json(['message' => 'Empleado no encontrado'], 404);
        }
    }

    public function store(Request $request)
    {
        $request->validate([
            'nombre' => 'required|string',
            'fechanac' => 'required|date',
            'correo' => 'required|string|email',
            'activo' => 'required|integer',
            'id_departamento' => 'required|integer|exists:departamentos,id',
        ]);

        $empleado = Empleado::create([
            'nombre' => $request->nombre,
            'fechanac' => $request->fechanac,
            'correo' => $request->correo,
            'activo' => $request->activo,
            'id_departamento' => $request->id_departamento,
        ]);

        return response()->json($empleado, 201);
    }

    public function updateStatus($id, Request $request)
    {
        $request->validate([
            'activo' => 'required|integer',
        ]);

        $empleado = Empleado::find($id);

        if ($empleado) {
            $empleado->activo = $request->activo;
            $empleado->save();
            return response()->json($empleado, 200);
        } else {
            return response()->json(['message' => 'Empleado no encontrado'], 404);
        }
    }

    public function destroy($id)
    {
        $empleado = Empleado::find($id);

        if ($empleado) {
            $empleado->delete();
            return response()->json(['message' => 'Empleado eliminado'], 200);
        } else {
            return response()->json(['message' => 'Empleado no encontrado'], 404);
        }
    }

    public function index()
    {
        $empleados = Empleado::all();
        return response()->json($empleados, 200);
    }
}

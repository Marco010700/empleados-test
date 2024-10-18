<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Departamento;
use Illuminate\Http\Request;

class DepartamentoController extends Controller
{
    public function index()
    {
        $departamentos = Departamento::where('activo', 1)->get();
        return response()->json($departamentos, 200);
    }

    public function show($id)
    {
        $departamento = Departamento::find($id);

        if ($departamento) {
            return response()->json($departamento, 200);
        } else {
            return response()->json(['message' => 'Departamento no encontrado'], 404);
        }
    }
}

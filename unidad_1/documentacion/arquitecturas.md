---
marp: true
theme: default
class: invert
paginate: true
---

# Introducción a las Arquitecturas de Software

## Para Ingenieros en Formación

**MVC · MVP · MVVM · DDD · Clean Architecture**

*Universidad - Ingeniería de Software*
*2025*

---

## Objetivos de Aprendizaje

Al finalizar esta clase podrás:

1. **Comprender** qué es una arquitectura de software y por qué es importante
2. **Identificar** los patrones arquitectónicos más utilizados en la industria
3. **Distinguir** dónde colocar cada tipo de lógica en tu aplicación
4. **Seleccionar** la arquitectura adecuada para diferentes proyectos
5. **Reconocer** buenos y malos diseños arquitectónicos

---

##  ¿Por qué estudiar arquitecturas?

### El Problema

```java
// ❌ Código sin arquitectura (todo mezclado)
public class App {
    public static void main(String[] args) {
        // Conexión a BD, lógica de negocio, UI, todo junto
        Connection conn = DriverManager.getConnection("jdbc:...");
        System.out.println("Ingrese edad:");
        int edad = scanner.nextInt();
        if (edad >= 18) {  // Regla de negocio
            String sql = "INSERT INTO users...";  // Acceso a datos
            System.out.println("Usuario registrado");  // UI
        }
    }
}
```

---

### Problemas

- Imposible de testear
- Difícil de mantener
- No reutilizable

---

## ¿Qué es una Arquitectura de Software?

> **"La arquitectura de software son las decisiones significativas sobre la organización de un sistema de software"**
> — IEEE Standard 1471-2000¹

### En términos simples

Es como organizar tu código en **carpetas y responsabilidades claras**, similar a como organizas:

- 📁 Apuntes por materia
- 🏗️ Planos de una casa por sistemas (eléctrico, hidráulico)
- 🍳 Una cocina (zona de cocción, lavado, almacenamiento)

---

##  Conceptos Base que Necesitas Conocer

### Tipos de Lógica en una Aplicación

1. **Lógica de Presentación**
   - Cómo mostrar datos al usuario
   - Ejemplo: Formatear fecha como "DD/MM/YYYY"

---

2. **Lógica de Negocio**
   - Las reglas de tu dominio/problema
   - Ejemplo: "Un estudiante puede inscribir máximo 7 materias"

3. **Lógica de Persistencia**
   - Cómo guardar y recuperar datos
   - Ejemplo: Consultas SQL, conexión a BD

---

##  Analogía Académica

Imagina tu universidad:

```
┌─────────────────────────────────┐
│     Interfaz (Portal Web)       │ ← Lo que ves
├─────────────────────────────────┤
│   Lógica de Negocio (Reglas)    │ ← Requisitos, límites de créditos
├─────────────────────────────────┤
│    Datos (Base de Datos)        │ ← Información almacenada
└─────────────────────────────────┘
```

**Pregunta clave**: ¿Dónde pondrías la regla "máximo 7 materias por semestre"?

---

# Patrón MVC

## Model - View - Controller

###  Historia

- Creado en 1978 por Trygve Reenskaug en Xerox PARC²
- Originalmente para aplicaciones Smalltalk
- Hoy: el patrón más usado en desarrollo web

---

## MVC: Componentes

### Analogía: Restaurant 

```
┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│    MODEL     │     │     VIEW     │     │  CONTROLLER  │
│   (Cocina)   │ ←→  │    (Menú)    │ ←→  │   (Mesero)   │
└──────────────┘     └──────────────┘     └──────────────┘
     ↓                      ↓                     ↓
  Prepara la           Muestra las          Toma tu orden
  comida               opciones             y coordina
```

---

## MVC: Ejemplo Simple - Sistema de Notas

```python
# Model - La lógica y datos
class Estudiante:
    def __init__(self, nombre, notas):
        self.nombre = nombre
        self.notas = notas
    
    def calcular_promedio(self):  # LÓGICA DE NEGOCIO
        return sum(self.notas) / len(self.notas)
    
    def esta_aprobado(self):      # REGLA DE NEGOCIO
        return self.calcular_promedio() >= 3.0

# View - Lo que ve el usuario
def mostrar_estudiante(estudiante):
    print(f"Estudiante: {estudiante.nombre}")
    print(f"Promedio: {estudiante.calcular_promedio():.2f}")
    print(f"Estado: {'Aprobado' if estudiante.esta_aprobado() else 'Reprobado'}")

# Controller - Coordina todo
class EstudianteController:
    def procesar_notas(self, nombre, notas_string):
        notas = [float(n) for n in notas_string.split(',')]
        estudiante = Estudiante(nombre, notas)
        mostrar_estudiante(estudiante)
```

---

## MVC: ¿Dónde va cada cosa?

| Componente | Responsabilidad | Ejemplo |
|------------|----------------|---------|
| **Model** | Datos y reglas de negocio | `calcular_promedio()`, validaciones |
| **View** | Presentación visual | HTML, templates, console output |
| **Controller** | Coordinación y flujo | Recibir peticiones, llamar métodos |

### Regla de Oro
>
> **La lógica de negocio NUNCA va en el Controller**

---

## MVC: Ventajas y Desventajas

### ✅ Ventajas

- Simple de entender y aprender
- Separación clara de responsabilidades
- Muchos frameworks lo implementan (Spring, Django, Rails)

---

### ❌ Desventajas  

- El Controller puede volverse muy grande ("Fat Controller")
- La View conoce al Model (acoplamiento)
- Difícil de testear la UI

###  Fuente Principal

Krasner, G.E. and Pope, S.T. (1988). "A cookbook for using the MVC user interface paradigm in Smalltalk-80"³

---

# Patrón MVP

## Model - View - Presenter

### 🔄 Evolución de MVC

- La View se vuelve "tonta" (pasiva)
- El Presenter maneja TODA la lógica de presentación
- Mejor para testing

---

## MVP: Diferencia Clave con MVC

```
MVC:  View ←→ Model (la vista conoce el modelo)
         ↑
    Controller

MVP:  View ← Presenter → Model (la vista NO conoce el modelo)
```

---

### Ejemplo: Calculadora Simple

```java
// View Interface (lo que el Presenter espera)
interface CalculatorView {
    String getFirstNumber();
    String getSecondNumber();
    void showResult(String result);
    void showError(String error);
}

// Presenter - Toda la lógica de presentación
class CalculatorPresenter {
    private CalculatorView view;
    private CalculatorModel model;
    
    void onAddButtonClicked() {
        try {
            double num1 = Double.parseDouble(view.getFirstNumber());
            double num2 = Double.parseDouble(view.getSecondNumber());
            double result = model.add(num1, num2);  // Lógica en Model
            view.showResult(String.format("%.2f", result));
        } catch (NumberFormatException e) {
            view.showError("Por favor ingrese números válidos");
        }
    }
}
```

---

## MVP: Ventajas para Testing

```java
// Test sin necesidad de UI real
@Test
public void testSumaCorrecta() {
    // Mock de la vista
    CalculatorView mockView = mock(CalculatorView.class);
    when(mockView.getFirstNumber()).thenReturn("5");
    when(mockView.getSecondNumber()).thenReturn("3");
    
    // Ejecutar
    CalculatorPresenter presenter = new CalculatorPresenter(mockView, model);
    presenter.onAddButtonClicked();
    
    // Verificar
    verify(mockView).showResult("8.00");
}
```

---

### 📚 Referencias MVP

- Potel, M. (1996). "MVP: Model-View-Presenter The Taligent Programming Model for C++ and Java"⁴

---

# Patrón MVVM

## Model - View - ViewModel

### 🔗 Data Binding: La Magia de MVVM

- La View se "enlaza" automáticamente con el ViewModel
- Cambios en el ViewModel actualizan la View automáticamente
- Popular en: WPF, Angular, Vue, React

---

## MVVM: Ejemplo con Binding

```html
<!-- View (HTML con Angular) -->
<div>
    <h2>Calculadora de Promedio</h2>
    <input [(ngModel)]="nota1" placeholder="Nota 1">
    <input [(ngModel)]="nota2" placeholder="Nota 2">
    <input [(ngModel)]="nota3" placeholder="Nota 3">
    
    <p>Promedio: {{ promedio }}</p>
    <p [style.color]="color">{{ estado }}</p>
</div>
```
---

```typescript
// ViewModel (TypeScript)
export class PromedioViewModel {
    nota1: number = 0;
    nota2: number = 0;
    nota3: number = 0;
    
    get promedio(): number {
        return (this.nota1 + this.nota2 + this.nota3) / 3;
    }
    
    get estado(): string {
        return this.promedio >= 3 ? 'Aprobado' : 'Reprobado';
    }
    
    get color(): string {
        return this.promedio >= 3 ? 'green' : 'red';
    }
}
```

---

## MVVM: ¿Cuándo Usarlo?

### ✅ Ideal para

- Aplicaciones con UI reactiva
- Frameworks con binding (Angular, Vue, WPF)
- Cuando necesitas sincronización automática UI ↔ Datos

### ❌ Evitar cuando

- No tienes framework con binding
- Aplicación muy simple
- Backend puro sin UI

### 📚 Fuente

Smith, J. (2009). "WPF Apps With The MVVM Design Pattern" - MSDN Magazine⁵

---

# DDD - Domain Driven Design

## Diseño Dirigido por Dominio

### 💡 Filosofía
>
> "El software debe reflejar el dominio del problema que resuelve"
> — Eric Evans

### No es solo arquitectura, es una forma de pensar

---

## DDD: Conceptos Clave para Estudiantes

### 📦 Building Blocks

1. **Entity** (Entidad)
   - Tiene identidad única
   - Ejemplo: `Estudiante` con matrícula

2. **Value Object** (Objeto de Valor)
   - No tiene identidad, solo valores
   - Ejemplo: `Calificación`, `Dirección`

3. **Aggregate** (Agregado)
   - Grupo de objetos que se tratan como unidad
   - Ejemplo: `Curso` con sus `Estudiantes` y `Calificaciones`

---

## DDD: Ejemplo - Sistema de Inscripciones

```java
// Entity
public class Estudiante {
    private Matricula matricula;  // Identity
    private String nombre;
    private List<Inscripcion> inscripciones;
    
    // Regla de negocio del dominio
    public void inscribirMateria(Materia materia) {
        if (inscripciones.size() >= 7) {
            throw new LimiteMateriasException("Máximo 7 materias");
        }
        if (tieneChoqueHorario(materia)) {
            throw new ChoqueHorarioException();
        }
        inscripciones.add(new Inscripcion(this, materia));
    }
}

// Value Object
public class Horario {
    private final DiaSemana dia;
    private final LocalTime horaInicio;
    private final LocalTime horaFin;
    
    // Inmutable, sin identidad
    public boolean seSuperpone(Horario otro) {
        return this.dia == otro.dia && 
               !(this.horaFin.isBefore(otro.horaInicio) ||
                 this.horaInicio.isAfter(otro.horaFin));
    }
}
```

---

## DDD: ¿Cuándo es útil?

### ✅ Usar DDD cuando

- El dominio es complejo (ej: sistema bancario, hospital)
- Muchas reglas de negocio
- El equipo incluye expertos del dominio

### ❌ Overkill para

- CRUD simple
- Proyectos pequeños
- Prototipos rápidos

### 📚 Libro Fundamental

Evans, E. (2003). "Domain-Driven Design: Tackling Complexity in the Heart of Software"⁶

---

# Clean Architecture

## La Arquitectura Limpia

### 🎯 Principio Central
>
> "La arquitectura debe ser independiente de frameworks, UI, base de datos y cualquier agencia externa"
> — Robert C. Martin

---

## Clean Architecture: La Regla de Dependencia

```
            ┌─────────────────────┐
            │   Infraestructura   │
            │   (BD, Web, UI)     │
            └──────────↓──────────┘
            ┌─────────────────────┐
            │     Adaptadores      │
            │   (Controllers)      │
            └──────────↓──────────┘
            ┌─────────────────────┐
            │    Casos de Uso     │  ← Lógica de aplicación
            │    (Use Cases)       │
            └──────────↓──────────┘
            ┌─────────────────────┐
            │     Entidades        │  ← Lógica de negocio PURA
            │    (Entities)        │
            └─────────────────────┘

Regla: Las flechas solo apuntan hacia adentro
```

---

## Clean Architecture: Ejemplo Práctico

```python
# 1. Entity (Centro - sin dependencias)
class Usuario:
    def __init__(self, email, edad):
        self.email = email
        self.edad = edad
    
    def puede_votar(self):  # Regla de negocio
        return self.edad >= 18

# 2. Use Case (Lógica de aplicación)
class RegistrarVotanteUseCase:
    def __init__(self, user_repository):
        self.repo = user_repository
    
    def ejecutar(self, email, edad):
        usuario = Usuario(email, edad)
        if not usuario.puede_votar():
            raise Exception("Menor de edad")
        self.repo.guardar(usuario)
        return "Votante registrado"

# 3. Adapter (Controller)
class VotanteController:
    def __init__(self, use_case):
        self.use_case = use_case
    
    def registrar(self, request):
        resultado = self.use_case.ejecutar(
            request['email'], 
            request['edad']
        )
        return {"status": "success", "message": resultado}
```

---

## Clean Architecture: Beneficios

### 🎯 Independencia Total

- Puedes cambiar de MySQL a MongoDB sin tocar la lógica
- Puedes cambiar de REST a GraphQL sin tocar casos de uso
- Puedes cambiar de Web a Mobile sin tocar entidades

### 📚 Referencia Principal

Martin, R.C. (2017). "Clean Architecture: A Craftsman's Guide to Software Structure and Design"⁷

---

# 📊 Comparación Rápida

| Patrón | Complejidad | Cuándo Usar | Framework Ejemplo |
|--------|------------|-------------|-------------------|
| **MVC** | ⭐⭐ Baja | Web apps, CRUD | Spring MVC, Django |
| **MVP** | ⭐⭐⭐ Media | Apps móviles, testing importante | Android (legacy) |
| **MVVM** | ⭐⭐⭐ Media | UI reactiva, SPA | Angular, Vue |
| **DDD** | ⭐⭐⭐⭐ Alta | Dominio complejo | Cualquiera |
| **Clean** | ⭐⭐⭐⭐⭐ Muy Alta | Sistemas críticos, largo plazo | Cualquiera |

---

<!-- # 🎮 Ejercicio Práctico

## Mini-Proyecto: Sistema de Biblioteca

Diseña la arquitectura para:

- Registrar libros
- Prestar libros a estudiantes
- Máximo 3 libros por estudiante
- Multa por retraso

### Preguntas

1. ¿Qué arquitectura elegirías?
2. ¿Dónde pondrías la regla "máximo 3 libros"?
3. ¿Dónde calcularías la multa?

--- -->


## 1. Empieza Simple

- Aprende bien MVC primero
- Luego explora MVP/MVVM
- DDD y Clean para proyectos avanzados

---

## 2. Practica con Proyectos Reales

- To-do list → MVC
- Chat app → MVP/MVVM
- E-commerce → DDD

---


## 3. No Over-engineer

- No uses Clean Architecture para un proyecto de 3 archivos
- No uses DDD para un CRUD simple

---

# 🚨 Errores Comunes de Principiantes

## 1. Fat Controller

```java
// ❌ MAL - Controller hace todo
@PostMapping("/prestamo")
public void prestarLibro(String isbn, String estudiante) {
    // Valida estudiante
    // Busca libro
    // Verifica disponibilidad
    // Calcula fecha devolución
    // Guarda en BD
    // Envía email
    // 200 líneas de código...
}
```
---

## 2. Lógica en la Vista

```html
<!-- ❌ MAL - Cálculo en la vista -->
<div>
    Precio con IVA: {{ precio * 1.19 }}
</div>
```

---

# 📚 Recursos para Profundizar

## Libros Fundamentales

1. **Fowler, M.** (2002). *Patterns of Enterprise Application Architecture*⁸
2. **Evans, E.** (2003). *Domain-Driven Design*⁶
3. **Martin, R.C.** (2017). *Clean Architecture*⁷
4. **Freeman, E. et al.** (2004). *Head First Design Patterns*⁹

## Cursos Online Gratuitos

- **MIT OpenCourseWare**: Software Construction
- **Coursera**: Software Design and Architecture (University of Alberta)
- **YouTube**: Derek Banas - Design Patterns Playlist

---

# 📖 Referencias Académicas

1. **IEEE** (2000). "IEEE Standard 1471-2000: Recommended Practice for Architectural Description"
2. **Reenskaug, T.** (1979). "Thing-Model-View-Editor: An Example from a Planning System"
3. **Krasner, G.E. & Pope, S.T.** (1988). "A Cookbook for Using the MVC User Interface Paradigm"
4. **Potel, M.** (1996). "MVP: Model-View-Presenter - The Taligent Programming Model"
5. **Smith, J.** (2009). "WPF Apps With The MVVM Design Pattern", MSDN Magazine
6. **Evans, E.** (2003). "Domain-Driven Design: Tackling Complexity", Addison-Wesley
7. **Martin, R.C.** (2017). "Clean Architecture: A Craftsman's Guide", Prentice Hall
8. **Fowler, M.** (2002). "Patterns of Enterprise Application Architecture", Addison-Wesley
9. **Freeman, E. et al.** (2004). "Head First Design Patterns", O'Reilly Media

---

# 🔗 Recursos Adicionales

## Repositorios de Ejemplo

- github.com/android/architecture-samples (MVP, MVVM examples)
- github.com/dotnet-architecture/eShopOnContainers (DDD, Clean)
- github.com/gothinkster/realworld (Multiple architectures)

## Herramientas Útiles

- **Draw.io**: Para diagramar arquitecturas
- **PlantUML**: Para diagramas UML desde código
- **ArchUnit**: Para validar reglas arquitectónicas en Java

## Comunidades

- r/softwarearchitecture (Reddit)
- Software Architecture Stack Exchange
- DDD Community (dddcommunity.org)

---

# 🎯 Siguiente Paso

## Proyecto Sugerido: Sistema de Gestión de Cursos

### Requisitos

1. Estudiantes se registran en cursos
2. Profesores califican estudiantes  
3. Límite de créditos por semestre
4. Prerequisitos entre materias
5. Cálculo de promedio acumulado

### Desafío

**Implementa el mismo sistema con 2 arquitecturas diferentes y compara:**

- Facilidad de desarrollo
- Facilidad de testing
- Mantenibilidad

---

# 💭 Reflexión Final

## La Arquitectura Correcta

> "No existe una arquitectura perfecta, solo la arquitectura correcta para tu problema específico"

### Factores a Considerar

- 📏 Tamaño del proyecto
- 👥 Tamaño del equipo
- ⏰ Tiempo disponible
- 💰 Presupuesto
- 🔄 Expectativa de cambios
- 🎯 Criticidad del sistema

---

# ¿Preguntas?

## 📧 Contacto

- <profesor@universidad.edu>
- Horario de oficina: Lunes y Miércoles 14:00-16:00

## 📝 Tarea

1. Leer capítulo 1 de "Clean Architecture" (en biblioteca)
2. Implementar una calculadora simple en MVC
3. Escribir reflexión (1 página): ¿Qué arquitectura usarías para rediseñar el sistema de inscripciones de la universidad?

## 🗓️ Próxima Clase

**Patrones de Diseño**: Singleton, Factory, Observer y más

---

# 🙏 ¡Gracias

## Recuerden

> "Un buen arquitecto de software no es quien conoce todas las arquitecturas, sino quien sabe elegir la correcta para cada situación"

### 🚀 ¡Ahora a practicar

#### Material disponible en

- Plataforma del curso
- GitHub: universidad/arquitecturas-software

**#IngenieriaDeSoftware #ArquitecturaDeSoftware**

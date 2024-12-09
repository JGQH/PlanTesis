#import "./utilidades/formato.typ": formato

#show "UNSA": "Universidad Nacional de San Agustín"
#show "21500": [norma ISO 21500]

#show: doc => formato(
  doc,
  asesor: "[NOMBRE ASESOR]",
  autores: ("Quispe Huillca, Juan Guillermo",),
  cabecera: [Propuesta de un Sistema de Gestión de Proyectos y Documentación Basado en la 21500]
)

#include "partes/preliminares.typ"

#set heading(numbering: "1.")

#context {
  outline(
    title: [Índice de contenidos],
    target: heading.where(level: 1).or(heading.where(level: 2).or(heading.where(level: 3))).after(here()) ,
    indent: 0.5in
  )
  outline(
    title: [Índice de figuras],
    target: figure.where(kind: image),
    indent: 0.5in
  )

  outline(
    title: [Índice de tablas],
    target: figure.where(kind: table),
    indent: 0.5in
  )
}

#include "partes/cap01.typ"
#include "partes/cap02.typ"
#include "partes/cap03.typ"
#include "partes/cap04.typ"

#set heading(numbering: none)

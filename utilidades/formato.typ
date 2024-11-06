#let TEXT_SIZE = 12pt

#let figura(imagen, ancho: 75%, alto: auto, leyenda: none) = {
  let grosor = 1.25pt

  figure(
    rect(
      stroke: grosor + rgb("#cccccc"),
      inset: (grosor / 2) + 1.5pt,
      image("../media/" + imagen, width: ancho, height: alto)
    ),
    caption: leyenda,
    gap: 2em
  )
}

#let formato(cabecera: [Lorem Ipsum], autores: ("Quispe Huillca, Juan Guillermo",), asesor: ("Mg. Wick, John"), doc) = {
  // Preparar el formato base
  show heading: set text(size: TEXT_SIZE)
  show heading: set block(spacing: 2em)
  show heading.where(level: 1, outlined: true): h => context {
    // counter(heading).display("1")
    align(center)[Capítulo #counter(heading).display("I"): *#h.body*]
    // repr(h)
    /*
    if (h.numbering == none) { h }
    else { repr(h) }*/
  }
  show heading.where(level: 3): emph
  show figure: set block(spacing: 2em)
  show figure.caption: c => {
    set par(leading: 0.65em)
    emph(c)
  }

  set document(
    title: cabecera,
    date: none,
    author: autores
  )
  set page(
    paper: "a4",
    margin: 1in
  )
  set par(
    linebreaks: "optimized",
    leading: 2em,
    spacing: 2em
  )
  set list(
    tight: false,
    spacing: 2em,
    indent: 0.5in
  )
  set enum(
    tight: false,
    spacing: 2em,
    indent: 0.5in
  )
  set heading(
    numbering: "1."
  )
  set text(
    lang: "es",
    font: "Times New Roman",
    hyphenate: false,
    size: TEXT_SIZE,
    overhang: false,
    number-type: "lining",
    number-width: "tabular"
  )
  set page(
    header: context {
      let val = int(counter(page).display("1")) - 1
      if val == 0 [] else { align(right)[*#val*] }
    }
  )

  /*
  show heading.where(level: 1): h => context upper(if h.numbering == none {
      h
    } else {
      pagebreak()
      align(center)[ Capítulo #counter(heading).display("I"): #h.body ]
    })

  show outline.entry.where(level: 1): e => context {
    v(2em, weak: true)
    let oc = counter("oc")
    oc.update(_ => counter(heading).at(e.element.location()).at(0))
    link(e.element.location(), upper([ *Capítulo #context oc.display("I"): #e.element.body #h(1fr) #e.page*]))
  }
  show outline.entry.where(level: 2): e => strong(e)*/

  // Agregar carátula
  [
    #set align(center)
    #set text(weight: "bold")

    UNIVERSIDAD NACIONAL DE SAN AGUSTÍN

    FACULTAD DE INGENIERÍA DE PRODUCCIÓN Y SERVICIOS

    ESCUELA PROFESIONAL DE INGENIERÍA INDUSTRIAL

    #image("../media/escudo.png", width: 25%)

    #upper(cabecera)

    #h(50%) #box[
      #set align(left)
      PLAN DE TESIS PRESENTADO POR:

      #autores.map(autor => text(weight: "regular", autor)).join("\n")

      ASESOR(A):

      #text(weight: "regular", asesor)
    ]

    #v(1fr)

    AREQUIPA - PERÚ

    2024
  ]

  pagebreak()

  // Agregar índice
  outline(
    title: [Tabla de Contenido],
    target: heading.where(level: 1).or(heading.where(level: 2).or(heading.where(level: 3))),
    indent: 2em
  )

  pagebreak()

  outline(
    title: [Lista de Figuras],
    target: figure.where(kind: image)
  )

  pagebreak()

  // Cuerpo del documento
  for (ie, elem) in doc.children.enumerate() {
    if elem.func() == text {
      if ie > 0 and doc.children.at(ie - 1).func() == parbreak {
        h(0.5in)
      }
      elem
    } else {
      elem
    }
  }
}

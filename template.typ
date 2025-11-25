#import "@preview/numbly:0.1.0": numbly
#import "@preview/mitex:0.2.6": *

#let fonts = (
  serif: ("New Computer Modern", "FZShuSong-Z01"),
  sans: ("CMU Sans Serif", "FZHei-B01"),
  kaishu: "FZKai-Z03",
  tims_new_roman: ("Times New Roman", "FZKai-Z03"),
  song: "FZShuSong-Z01"
)

#let maketitle(
  title: none,
  subtitle: none,
  author: none,
  date: none,
) = {
  set align(center)
  set par(spacing: 0em)

  image("photo/logo.png", width: 6cm)
  v(1.4em)

  if title != none {
    text(2.2em, weight: "bold", font: fonts.tims_new_roman, title)
    v(1.4em)
  }

  if subtitle != none {
    text(2.2em, weight: "bold", font: fonts.song, subtitle)
    v(2.4em)
  }
}

#let render-problem(problem, statement) = [
  #v(-10pt)
  = #text(font: fonts.sans, size: 20pt)[#problem.display-name]
  #v(10pt)

  #if problem.at("latex", default: false) {
    mitext(statement.description)
  } else {
    eval(statement.description, mode: "markup")
  }

  #if statement.input != none [
    == #text(font: fonts.sans, size: 15pt)[输入格式]
    #if problem.at("latex", default: false) {
      mitext(statement.input)
    } else {
      eval(statement.input, mode: "markup")
    }
  ]

  #if statement.output != none [
    == #text(font: fonts.sans, size: 15pt)[输出格式]
    #if problem.at("latex", default: false) {
      mitext(statement.output)
    } else {
      eval(statement.output, mode: "markup")
    }
  ]

  #if problem.samples.len() > 0 [
    == #text(font: fonts.sans, size: 15pt)[样例]

    #figure(
      table(
        columns: (7.2cm, 7.2cm),
        align: (x, y) => if y == 0 { center } else { left },
        stroke: 0.4pt,
        table.header([标准输入], [标准输出]),
        ..problem.samples.map(s => (raw(s.input, block: true), raw(s.output, block: true))).flatten(),
      ),
    )
  ]

  #if statement.notes != none [
    == #text(font: fonts.sans, size: 15pt)[提示]
    #if problem.at("latex", default: false) {
      mitext(statement.notes)
    } else {
      eval(statement.notes, mode: "markup")
    }
  ]
]

#let render-problems(problems: none) = {}

#let contest-conf(
  title: "这是一场 XCPC 程序设计竞赛",
  subtitle: "试题册",
  author: "初梦",
  date: "2026年2月1日",
  problems: none,
  enable-titlepage: true,
  doc,
) = {
  set text(lang: "zh", font: fonts.serif)
  set document(title: title, author: author)

  // 封面页
  if enable-titlepage {
    set page(
      margin: (top: 2cm, bottom: 3cm, left: 0.5cm, right: 0.5cm),
    )
    set par(spacing: 0.8em)
    maketitle(title: title, subtitle: subtitle, date: none, author: none)
    // TOC
    figure(
      [
        #text(size: 18pt, font: fonts.sans)[试题列表]

        #set table(stroke: (x, y) => (
          if y == 0 {
            (top: 0.4pt, left: 0.4pt, right: 0.4pt)
          } else if y == problems.len() - 1 {
            (bottom: 0.4pt, left: 0.4pt, right: 0.4pt)
          } else {
            (left: 0.4pt, right: 0.4pt)
          }
        ))
        // #v(0.6em)

        #table(
          columns: (1.4cm, 6cm),
          align: center,
          ..problems
            .enumerate()
            .map(((i, e)) => (
              str.from-unicode(int(i) + 65),
              e.problem.display_name,
            ))
            .flatten()
        )

        #v(0.8cm)

        本试题册共 #problems.len() 题，#context counter(page).final().at(0) 页。

        如果您的试题册缺少页面，请立即通知志愿者。

        #v(1.2cm)

        #block(width: 100%)[
          #pad(right: 3cm)[   // 距离右边再留 1cm 缓冲，可以自己调
            #align(right)[
              #text(
                font: fonts.kaishu,
                size: 1em,
                fill: gray,
              )[ #author ]

              #v(0.3em)

              #text(
                size: 1em,
                fill: gray,
              )[ #date ]
            ]
          ]
        ]
      ],
    )
  }

  // 题面
  {
    set par(first-line-indent: (amount: 2em, all: true), justify: true, spacing: 0.65em)
    show heading: set block(above: 0.6em)

    set page(
      margin: (top: 3cm, bottom: 2.5cm, x: 2.5cm),
      header: [
        #set text(size: 10pt)
        #grid(
          columns: (1fr, 1fr),
          align: (left, right),
          [#title], [#date],
        )
        #v(-0.1cm)
        #line(length: 100%, stroke: 0.5pt)
      ],
      footer: context [
        #set align(center)
        #line(length: 100%, stroke: 0.5pt)
        #set text(font: fonts.sans)
        #counter(page).display(
          numbly("{1}", { "Page {1} of {2}" }),
          both: true,
        )
      ],
    )

    counter(page).update(1)

    if problems != none {
      for (i, e) in problems.enumerate() {
        e.problem.display-name = "Problem " + str.from-unicode(int(i) + 65) + ". " + e.problem.display_name
        render-problem(e.problem, e.statement)

        if i < problems.len() - 1 {
          pagebreak()
        }
      }
    }
  }

  doc
}

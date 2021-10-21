# Generated with https://github.com/karaxnim/karax
include pkg/karax/prelude

proc createDom(): VNode =
  result = buildHtml(body):
    h1:
      text "Hello World!"
    #[ I
    am
    a
    multiline
    comment ]#
    input(`type` = "checkbox", id = "13", name = "Test")
    tdiv(class = "container"):
      nav:
        a(class = "item", href = "#1"):
          text "Link 1"
        a(class = "item", href = "#2"):
          text "Link 2"
        a(class = "item", href = "#3"):
          text "Link 3"
        a(class = "item", href = "#4"):
          text "Link 4"
      main:
        tdiv(class = "cards"):
          tdiv(class = "card"):
            header:
              span(class = "title"):
                text "Card 1"
              span(class = "close")
            main:
              p:
                text "Some items"
              tdiv(class = "items"):
                tdiv(class = "item"):
                  span(class = "text"):
                    text "Item 1"
                  tdiv(class = "btn"):
                    text "View"
                tdiv(class = "item"):
                  span(class = "text"):
                    text "Item 2"
                  tdiv(class = "btn"):
                    text "View"
                tdiv(class = "item"):
                  span(class = "text"):
                    text "Item 3"
                  tdiv(class = "btn"):
                    text "View"
                tdiv(class = "item"):
                  span(class = "text"):
                    text "Item 4"
                  tdiv(class = "btn"):
                    text "View"
                tdiv(class = "item"):
                  span(class = "text"):
                    text "Item 5"
                  tdiv(class = "btn"):
                    text "View"
            footer:
              span(class = "center"):
                text "View more"
          tdiv(class = "card"):
            header:
              span(class = "title"):
                text "Card 1"
              span(class = "close")
            main:
              p:
                text "Some items"
              tdiv(class = "items"):
                tdiv(class = "item"):
                  span(class = "text"):
                    text "Item 1"
                  tdiv(class = "btn"):
                    text "View"
                tdiv(class = "item"):
                  span(class = "text"):
                    text "Item 2"
                  tdiv(class = "btn"):
                    text "View"
                tdiv(class = "item"):
                  span(class = "text"):
                    text "Item 3"
                  tdiv(class = "btn"):
                    text "View"
                tdiv(class = "item"):
                  span(class = "text"):
                    text "Item 4"
                  tdiv(class = "btn"):
                    text "View"
                tdiv(class = "item"):
                  span(class = "text"):
                    text "Item 5"
                  tdiv(class = "btn"):
                    text "View"
            footer:
              span(class = "center"):
                text "View more"

setRenderer createDom
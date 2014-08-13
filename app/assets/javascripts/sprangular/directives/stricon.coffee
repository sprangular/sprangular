#

Sprangular.directive "ngStricon", [->
  scope:
    string: '=ngStricon'
  link: (scope, element, attr) ->
    chars = ['a','c','d','i','m','o','s','t','u']
    map =
      'a':
        'layout': 'reg',
        'icons': [
          'cherry', 'melon', 'mont', 'pyra', 'tipi'
        ]
      'c':
        'layout': 'nrw',
        'icons': [
          'banana', 'dolph', 'lune', 'peeled'
        ]
      'd':
        'layout': 'reg',
        'icons': [
          'melon', 'pom'
        ]
      'i':
        'layout': 'nrw',
        'icons': [
          'gloss', 'lip', 'pen', 'wand'
        ]
      'm':
        'layout': 'wide',
        'icons': [
          'note'
        ]
      'o':
        'layout': 'reg',
        'icons': [
          'alien', 'base', 'basket', 'ring', 'smile', 'vinyl'
        ]
      's':
        'layout': 'reg',
        'icons': [
          'bolt'
        ]
      't':
        'layout': 'reg',
        'icons': [
          'palm', 'pi', 'umb', 'umbdark'
        ]
      'u':
        'layout': 'reg',
        'icons': [
          'shades'
        ]
    scope.$watch 'string', (data) ->
      find = (chars, string) ->
        m = []
        if string.length > 1 and string.length < 8
          i = 0
          while m.length is 0
            ind = string.indexOf(chars[i])
            if chars[i] isnt " " and ind > 0
              m.push string, chars[i], string.indexOf(chars[i])
            i++
          return m
        else
          m.push string
          return m
      build = (words) ->
        mark = ""
        for word in words
          if word.length > 2
            before = word[0].slice 0, word[2]
            after = word[0].slice word[2]+1, word[0].length
            ico = _.shuffle map[word[1]].icons
            lay = map[word[1]].layout
            mark += "<div class='si-word'><span>#{before}</span>"
            mark += "<span><svg class='si-ico--#{lay}'><use xlink:href='#i-ico--#{word[1]}--#{ico[0]}'></svg></span>"
            mark += "<span>#{after} </span></div>"
          else
            mark += "<div class='si-word'><span>#{word[0]}</span></div>"
        return mark

      if data
        shf = _.shuffle chars
        words = data.toLowerCase().split " "
        blocks = []
        _.each words, (word) ->
          blocks.push find(shf, word)
        append = build blocks
        angular.element(element).append("<div class='si-el'>#{append}</div>")
]

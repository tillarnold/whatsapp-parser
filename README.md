# whatsapp-parser
[![devDependency Status](https://david-dm.org/tillarnold/whatsapp-parser/dev-status.svg)](https://david-dm.org/tillarnold/whatsapp-parser#info=devDependencies)

> Parse whatsapp logs. For Android and IOS

```js
var whatsapp = require('whatsapp-parser')
  , parsed = whatsapp.parseFile('./chat_export.txt')
  
parsed.forEach (function(message){
 console.log(message.date, ":", message.name, ":", message.name) 
})

```

#var whatsapp = require('whatsapp-parser')

##whatsapp.parse(text)
Parses the given string and returns an array of objects 

```js
[
  { date: '1.4.15 21:59:33',
    msg: 'I like robots. They are sooo cool.',
    name: 'Hans Christian Andersen' },
 //...
]
```

##whatsapp.parseFile(path)
Does the same as 
```js
whatsapp.parse(fs.readFileSync(path,'utf8'))
```

#know issues
- The android log does not report seconds or the year
  - It just returns 0. So the date might be '1.4.00 22:0:00'
- Can't parse the "system messages". (like "Johann Wolfgang von Goethe created group “unicorns and rainbows”")
  - they are parsed as messages by a user named "system"


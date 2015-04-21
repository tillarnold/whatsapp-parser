{
var monthMap = "Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec".split(' ')

}

s = 
 allmess +

allmess = start / sysmess

start
  = date:date m:mes { 
  return { date: date 
         , msg: m.msg
         , name: m.name
         }
}


sysmess = date:date m:sysmessageText {
return {
date:date,
msg: m,
name: "system"
}
}

mes = name:name ": " msg:( m:mesP* "\n" {return m})+ { return { name: name
                                                             , msg: msg.join('')
                                                             }
                                                    }

mesP "message body" =
!date t:[^\n]+ { return t.join('') }

date = androidDate / IOSdate

androidDate = month:([A-Z][a-z][a-z]) " " day:twonum ", " h:twonum ":" m:twonum " - "  {
  var monthNum = monthMap.indexOf(month.join(''))+1
  return day + "." + monthNum + "." + "00" + " " + h+ ":" + m + ":" + "00"
}


IOSdate = month:twonum "/" day:twonum "/" year:twonum ", " h:twonum ":" m:twonum ":" s:twonum " " pm:pmOrAm ": "  {
return day + "." + month + "." + year + " " + h+ ":" + m + ":" + s
}

pmOrAm = "PM" / "AM"


name = $nameLetter+

nameLetter = !":" .

sysmessageText = n:($sysmessageLetter+) "\n" {return n}
sysmessageLetter = !":" !"\n".

twonum =
t:$( [0-9] [0-9]?) { return parseInt(t) }

_ = require 'lodash'
api = module.exports
moment = require 'moment'
i18n = require './i18n.coffee'
t = (string, vars) ->
  func = (lang) -> 
    vars ?= {a: 'a'}
    i18n.t(string, vars, lang)
  func.i18nLangFunc = true #Trick to recognize this type of function
  func

###
  ---------------------------------------------------------------
  Gear (Weapons, Armor, Head, Shield)
  Item definitions: {index, text, notes, value, str, def, int, per, classes, type}
  ---------------------------------------------------------------
###

classes = ['warrior', 'rogue', 'healer', 'wizard']
gearTypes = [ 'weapon', 'armor', 'head', 'shield', 'body', 'back', 'headAccessory']

events =
  winter: {start:'2013-12-31',end:'2014-02-01'}
  birthday: {start:'2013-01-30',end:'2014-02-01'}
  spring: {start:'2014-03-21',end:'2014-05-01'}

mystery =
  201402: {start:'2014-02-22',end:'2014-02-28'}
  201403: {start:'2014-03-24',end:'2014-04-01'}
  201404: {start:'2014-04-24',end:'2014-05-01'}
  201405: {start:'2014-05-21',end:'2014-06-01'}
  wondercon: {start:'2014-03-24',end:'2014-04-01'} # not really, but the mechanic works

gear =
  weapon:
    base:
      0: 
        text: t('weaponBase0Text'), notes: t('weaponBase0Notes'), value:0
    warrior:
      0: text: t('weaponWarrior0Text'), notes: t('weaponWarrior0Notes'), value:0
      1: text: t('weaponWarrior1Text'), notes: t('weaponWarrior1Notes', {str: 3}), str: 3, value:20
      2: text: t('weaponWarrior2Text'), notes: t('weaponWarrior2Notes', {str: 6}), str: 6, value:30
      3: text: t('weaponWarrior3Text'), notes: t('weaponWarrior3Notes', {str: 9}), str: 9, value:45
      4: text: t('weaponWarrior4Text'), notes: t('weaponWarrior4Notes', {str: 12}), str: 12, value:65
      5: text: t('weaponWarrior5Text'), notes: t('weaponWarrior5Notes', {str: 15}), str: 15, value:90
      6: text: t('weaponWarrior6Text'), notes: t('weaponWarrior6Notes', {str: 18}), str: 18, value:120, last: true
    rogue:
      #Not using bows at the moment, but they would be easy to add back in to an advanced Armory feature, as Quest drops, etc.
      #0: twoHanded: true, text: "Practice Bow", notes:'Training weapon. Confers no benefit.', value:0
      #1: twoHanded: true, text: "Short Bow", notes:'Simple bow best at close ranges. Increases STR by 2.', str: 2, value:20
      #2: twoHanded: true, text: "Long Bow", notes:'Bow with a strong draw for extra distance. Increases STR by 5.', str: 5, value:50
      #3: twoHanded: true, text: "Recurve Bow", notes:'Built with advanced techniques. Increases STR by 8.', str: 8, value:80
      #4: twoHanded: true, text: "Icicle Bow", notes:'Fires arrows of piercing cold. Increases STR by 12.', str: 12, value:120
      #5: twoHanded: true, text: "Meteor Bow", notes:'Rains flame upon your foes. Increases STR by 16.', str: 16, value:160
      #6: twoHanded: true, text: "Golden Bow", notes:'As swift as sunlight and as sharp as lightning. Increases STR by 20.', str: 20, value:200, last: true
      0: text: t('weaponRogue0Text'), notes: t('weaponRogue0Notes'), str: 0, value: 0
      1: text: t('weaponRogue1Text'), notes: t('weaponRogue1Notes', {str: 2}), str: 2, value: 20
      2: text: t('weaponRogue2Text'), notes: t('weaponRogue2Notes', {str: 3}), str: 3, value: 35
      3: text: t('weaponRogue3Text'), notes: t('weaponRogue3Notes', {str: 4}), str: 4, value: 50
      4: text: t('weaponRogue4Text'), notes: t('weaponRogue4Notes', {str: 6}), str: 6, value: 70
      5: text: t('weaponRogue5Text'), notes: t('weaponRogue5Notes', {str: 8}), str: 8, value: 90
      6: text: t('weaponRogue6Text'), notes: t('weaponRogue6Notes', {str: 10}), str: 10, value: 120, last: true
    wizard:
      0: twoHanded: true, text: t('weaponWizard0Text'), notes: t('weaponWizard0Notes'), value:0
      1: twoHanded: true, text: t('weaponWizard1Text'), notes: t('weaponWizard1Notes', {int: 3, per: 1}), int: 3, per: 1, value:30
      2: twoHanded: true, text: t('weaponWizard2Text'), notes: t('weaponWizard2Notes', {int: 6, per: 2}), int: 6, per: 2, value:50
      3: twoHanded: true, text: t('weaponWizard3Text'), notes: t('weaponWizard3Notes', {int: 9, per: 3}), int: 9, per: 3, value:80
      4: twoHanded: true, text: t('weaponWizard4Text'), notes: t('weaponWizard4Notes', {int: 12, per: 5}), int:12, per: 5, value:120
      5: twoHanded: true, text: t('weaponWizard5Text'), notes: t('weaponWizard5Notes', {int: 15, per: 7}), int: 15, per: 7, value:160
      6: twoHanded: true, text: t('weaponWizard6Text'), notes: t('weaponWizard6Notes', {int: 18, per: 10}), int: 18, per: 10, value:200, last: true
    healer:
      0: text: t('weaponHealer0Text'), notes: t('weaponHealer0Notes'), value:0
      1: text: t('weaponHealer1Text'), notes: t('weaponHealer1Notes', {int: 2}), int: 2, value:20
      2: text: t('weaponHealer2Text'), notes: t('weaponHealer2Notes', {int: 3}), int: 3, value:30
      3: text: t('weaponHealer3Text'), notes: t('weaponHealer3Notes', {int: 5}), int: 5, value:45
      4: text: t('weaponHealer4Text'), notes: t('weaponHealer4Notes', {int: 7}), int:7, value:65
      5: text: t('weaponHealer5Text'), notes: t('weaponHealer5Notes', {int: 9}), int: 9, value:90
      6: text: t('weaponHealer6Text'), notes: t('weaponHealer6Notes', {int: 11}), int: 11, value:120, last: true
    special:
      0: text: t('weaponSpecial0Text'), notes: t('weaponSpecial0Notes', {str: 20}), str: 20, value:150, canOwn: ((u)-> +u.backer?.tier >= 70)
      1: text: t('weaponSpecial1Text'), notes: t('weaponSpecial1Notes', {attrs: 6}), str: 6, per: 6, con: 6, int: 6, value:170, canOwn: ((u)-> +u.contributor?.level >= 4)
      2: text: t('weaponSpecial2Text'), notes: t('weaponSpecial2Notes', {attrs: 25}), str: 25, per: 25, value:200, canOwn: ((u)-> (+u.backer?.tier >= 300) or u.items.gear.owned.weapon_special_2?)
      3: text: t('weaponSpecial3Text'), notes: t('weaponSpecial3Notes', {attrs: 17}), str: 17, int: 17, con: 17, value:200, canOwn: ((u)-> +u.backer?.tier >= 300)
      critical: text: t('weaponSpecialCriticalText'), notes: t('weaponSpecialCriticalNotes', {attrs: 40}), str: 40, per: 40, value:200, canOwn: ((u)-> !!u.contributor?.critical)
      # Winter event gear
      yeti:       event: events.winter, canOwn: ((u)->u.stats.class is 'warrior' ), text: t('weaponSpecialYetiText'), notes: t('weaponSpecialYetiNotes', {str: 15}), str: 15, value:90
      ski:        event: events.winter, canOwn: ((u)->u.stats.class is 'rogue'   ), text: t('weaponSpecialSkiText'), notes: t('weaponSpecialSkiNotes', {str: 8}), str: 8, value: 90
      candycane:  event: events.winter, canOwn: ((u)->u.stats.class is 'wizard'  ), twoHanded: true, text: t('weaponSpecialCandycaneText'), notes: t('weaponSpecialCandycaneNotes', {int: 15, per: 7}), int: 15, per: 7, value:160
      snowflake:  event: events.winter, canOwn: ((u)->u.stats.class is 'healer'  ), text: t('weaponSpecialSnowflakeText'), notes: t('weaponSpecialSnowflakeNotes', {int: 9}), int: 9, value:90
      #Spring Fling
      springRogue:    event: events.spring, specialClass: 'rogue',   text: t('weaponSpecialSpringRogueText'), notes: t('weaponSpecialSpringRogueNotes', {str: 8}), value: 80, str: 8
      springWarrior:  event: events.spring, specialClass: 'warrior', text: t('weaponSpecialSpringWarriorText'), notes: t('weaponSpecialSpringWarriorNotes', {str: 15}), value: 90, str: 15
      springMage:     event: events.spring, specialClass: 'wizard',  twoHanded:true, text: t('weaponSpecialSpringMageText'), notes: t('weaponSpecialSpringMageNotes', {int: 15, per: 7}), value: 160, int:15, per:7
      springHealer:   event: events.spring, specialClass: 'healer',  text: t('weaponSpecialSpringHealerText'), notes: t('weaponSpecialSpringHealerNotes', {int: 9}), value: 90, int: 9

  armor:
    base:
      0: text: t('armorBase0Text'), notes: t('armorBase0Notes'), value:0
    warrior:
      #0: text: "Plain Clothing", notes:'Ordinary clothing. Confers no benefit.', value:0
      1: text: t('armorWarrior1Text'), notes: t('armorWarrior1Notes', {con: 3}), con: 3, value:30
      2: text: t('armorWarrior2Text'), notes: t('armorWarrior2Notes', {con: 5}), con: 5, value:45
      3: text: t('armorWarrior3Text'), notes: t('armorWarrior3Notes', {con: 7}), con: 7, value:65
      4: text: t('armorWarrior4Text'), notes: t('armorWarrior4Notes', {con: 9}), con: 9, value:90
      5: text: t('armorWarrior5Text'), notes: t('armorWarrior5Notes', {con: 11}), con: 11, value:120, last: true
    rogue:
      #0: text: "Plain Clothing", notes:'Ordinary clothing. Confers no benefit.', value:0
      1: text: t('armorRogue1Text'), notes: t('armorRogue1Notes', {per: 6}), per: 6, value:30
      2: text: t('armorRogue2Text'), notes: t('armorRogue2Notes', {per: 9}), per: 9, value:45
      3: text: t('armorRogue3Text'), notes: t('armorRogue3Notes', {per: 12}), per: 12, value:65
      4: text: t('armorRogue4Text'), notes: t('armorRogue4Notes', {per: 15}), per: 15, value:90
      5: text: t('armorRogue5Text'), notes: t('armorRogue5Notes', {per: 18}), per: 18, value:120, last: true
    wizard:
      #0: text: "Apprentice Garb", notes:'For students of magic. Confers no benefit.', value:0
      1: text: t('armorWizard1Text'), notes: t('armorWizard1Notes', {int: 2}), int: 2, value:30
      2: text: t('armorWizard2Text'), notes: t('armorWizard2Notes', {int: 4}), int: 4, value:45
      3: text: t('armorWizard3Text'), notes: t('armorWizard3Notes', {int: 6}), int: 6, value:65
      4: text: t('armorWizard4Text'), notes: t('armorWizard4Notes', {int: 9}), int: 9, value:90
      5: text: t('armorWizard5Text'), notes: t('armorWizard5Notes', {int: 12}), int: 12, value:120, last: true
    healer:
      #0: text: "Novice Robe", notes:'For healers in training. Confers no benefit.', value:0
      1: text: t('armorHealer1Text'), notes: t('armorHealer1Notes', {con: 6}), con: 6, value:30
      2: text: t('armorHealer2Text'), notes: t('armorHealer2Notes', {con: 9}), con: 9, value:45
      3: text: t('armorHealer3Text'), notes: t('armorHealer3Notes', {con: 12}), con: 12, value:65
      4: text: t('armorHealer4Text'), notes: t('armorHealer4Notes', {con: 15}), con: 15, value:90
      5: text: t('armorHealer5Text'), notes: t('armorHealer5Notes', {con: 18}), con: 18, value:120, last: true
    special:
      0: text: t('armorSpecial0Text'), notes: t('armorSpecial0Notes', {con: 20}), con: 20, value:150, canOwn: ((u)-> +u.backer?.tier >= 45)
      1: text: t('armorSpecial1Text'), notes: t('armorSpecial1Notes', {attrs: 6}), con: 6, str: 6, per: 6, int: 6, value:170, canOwn: ((u)-> +u.contributor?.level >= 2)
      2: text: t('armorSpecial2Text'), notes: t('armorSpecial2Notes', {attrs: 25}), int: 25, con: 25, value:200, canOwn: ((u)-> +u.backer?.tier >= 300)
      #Winter event
      yeti:       event: events.winter, canOwn: ((u)->u.stats.class is 'warrior' ), text: t('armorSpecialYetiText'), notes: t('armorSpecialYetiNotes', {con: 9}), con: 9, value:90
      ski:        event: events.winter, canOwn: ((u)->u.stats.class is 'rogue'   ), text: t('armorSpecialSkiText'), notes: t('armorSpecialSkiText', {per: 15}), per: 15, value:90
      candycane:  event: events.winter, canOwn: ((u)->u.stats.class is 'wizard'  ), text: t('armorSpecialCandycaneText'), notes: t('armorSpecialCandycaneNotes', {int: 9}), int: 9, value:90
      snowflake:  event: events.winter, canOwn: ((u)->u.stats.class is 'healer'  ), text: t('armorSpecialSnowflakeText'), notes: t('armorSpecialSnowflakeNotes', {con: 15}), con: 15, value:90
      birthday:   event: events.birthday, text: t('armorSpecialBirthdayText'), notes: t('armorSpecialBirthdayNotes'), value: 0
      # Spring Fling
      springRogue:    event: events.spring, specialClass: 'rogue',   text: t('armorSpecialSpringRogueText'), notes: t('armorSpecialSpringRogueNotes', {per: 15}), value: 90, per: 15
      springWarrior:  event: events.spring, specialClass: 'warrior', text: t('armorSpecialSpringWarriorText'), notes: t('armorSpecialSpringWarriorNotes', {con: 9}), value: 90, con: 9
      springMage:     event: events.spring, specialClass: 'wizard',    text: t('armorSpecialSpringMageText'), notes: t('armorSpecialSpringMageNotes', {int: 9}), value: 90, int: 9
      springHealer:   event: events.spring, specialClass: 'healer',  text: t('armorSpecialSpringHealerText'), notes: t('armorSpecialSpringHealerNotes', {con: 15}), value: 90, con: 15
    mystery:
      201402: text: t('armorMystery201402Text'), notes: t('armorMystery201402Notes'), mystery:mystery['201402'], value: 0
      201403: text: t('armorMystery201403Text'), notes: t('armorMystery201403Notes'), mystery:mystery['201403'], value: 0
      201405: text: t('armorMystery201405Text'), notes: t('armorMystery201405Notes'), mystery:mystery['201405'], value: 0

  head:
    base:
      0: text: t('headBase0Text'), notes: t('headBase0Notes'), value:0
    warrior:
      #0: text: "No Helm", notes:'No headgear.', value:0
      1: text: t('headWarrior1Text'), notes: t('headWarrior1Notes', {str: 2}), str: 2, value:15
      2: text: t('headWarrior2Text'), notes: t('headWarrior2Notes', {str: 4}), str: 4, value:25
      3: text: t('headWarrior3Text'), notes: t('headWarrior3Notes', {str: 6}), str: 6, value:40
      4: text: t('headWarrior4Text'), notes: t('headWarrior4Notes', {str: 9}), str: 9, value:60
      5: text: t('headWarrior5Text'), notes: t('headWarrior5Notes', {str: 12}), str: 12, value:80, last: true
    rogue:
      #0: text: "No Hood", notes:'No headgear.', value:0
      1: text: t('headRogue1Text'), notes: t('headRogue1Notes', {per: 2}), per: 2, value:15
      2: text: t('headRogue2Text'), notes: t('headRogue2Notes', {per: 4}), per: 4, value:25
      3: text: t('headRogue3Text'), notes: t('headRogue3Notes', {per: 6}), per: 6, value:40
      4: text: t('headRogue4Text'), notes: t('headRogue4Notes', {per: 9}), per: 9, value:60
      5: text: t('headRogue5Text'), notes: t('headRogue5Notes', {per: 12}), per: 12, value:80, last: true
    wizard:
      #0: text: "No Hat", notes:'No headgear.', value:0
      1: text: t('headWizard1Text'), notes: t('headWizard1Notes', {per: 2}), per: 2, value:15
      2: text: t('headWizard2Text'), notes: t('headWizard2Notes', {per: 3}), per: 3, value:25
      3: text: t('headWizard3Text'), notes: t('headWizard3Notes', {per: 5}), per: 5, value:40
      4: text: t('headWizard4Text'), notes: t('headWizard4Notes', {per: 7}), per: 7, value:60
      5: text: t('headWizard5Text'), notes: t('headWizard5Notes', {per: 10}), per: 10, value:80, last: true
    healer:
      #0: text: "No Circlet", notes:'No headgear.', value:0
      1: text: t('headHealer1Text'), notes: t('headHealer1Notes', {int: 2}), int: 2, value:15
      2: text: t('headHealer2Text'), notes: t('headHealer2Notes', {int: 3}), int: 3, value:25
      3: text: t('headHealer3Text'), notes: t('headHealer3Notes', {int: 5}), int: 5, value:40
      4: text: t('headHealer4Text'), notes: t('headHealer4Notes', {int: 7}), int: 7, value:60
      5: text: t('headHealer5Text'), notes: t('headHealer5Notes', {int: 9}), int: 9, value:80, last: true
    special:
      0: text: t('headSpecial0Text'), notes: t('headSpecial0Notes', {int: 20}), int: 20, value:150, canOwn: ((u)-> +u.backer?.tier >= 45)
      1: text: t('headSpecial1Text'), notes: t('headSpecial1Notes', {attrs: 6}), con: 6, str: 6, per: 6, int: 6, value:170, canOwn: ((u)-> +u.contributor?.level >= 3)
      2: text: t('headSpecial2Text'), notes: t('headSpecial2Notes', {attrs: 25}), int: 25, str: 25, value:200, canOwn: ((u)-> +u.backer?.tier >= 300)
      #Winter event
      nye:        event: events.winter, text: t('headSpecialNyeText'), notes: t('headSpecialNyeNotes'), value: 0
      yeti:       event: events.winter, canOwn: ((u)->u.stats.class is 'warrior' ), text: t('headSpecialYetiText'), notes: t('headSpecialYetiNotes', {str: 9}), str: 9, value:60
      ski:        event: events.winter, canOwn: ((u)->u.stats.class is 'rogue'   ), text: t('headSpecialSkiText'), notes: t('headSpecialSkiNotes', {per: 9}), per: 9, value:60
      candycane:  event: events.winter, canOwn: ((u)->u.stats.class is 'wizard'  ), text: t('headSpecialCandycaneText'), notes: t('headSpecialCandycaneNotes', {per: 7}), per: 7, value:60
      snowflake:  event: events.winter, canOwn: ((u)->u.stats.class is 'healer'  ), text: t('headSpecialSnowflakeText'), notes: t('headSpecialSnowflakeNotes', {int: 7}), int: 7, value:60
      # Spring Fling
      springRogue:    event: events.spring, specialClass: 'rogue',   text: t('headSpecialSpringRogueText'), notes: t('headSpecialSpringRogueNotes', {per: 9}),value: 40,per: 9
      springWarrior:  event: events.spring, specialClass: 'warrior', text: t('headSpecialSpringWarriorText'), notes: t('headSpecialSpringWarriorNotes', {str: 9}),value: 40,str: 9
      springMage:     event: events.spring, specialClass: 'wizard',    text: t('headSpecialSpringMageText'), notes: t('headSpecialSpringMageNotes', {per: 7}),value: 40,per: 7
      springHealer:   event: events.spring, specialClass: 'healer',  text: t('headSpecialSpringHealerText'), notes: t('headSpecialSpringHealerNotes', {int: 7}), value: 40, int: 7
    mystery:
      201402: text: t('headMystery201402Text'), notes: t('headMystery201402Notes'), mystery:mystery['201402'], value: 0
      201405: text: t('headMystery201405Text'), notes: t('headMystery201405Notes'), mystery:mystery['201405'], value: 0

  shield:
    base:
      0: text: t('shieldBase0Text'), notes: t('shieldBase0Notes'), value:0
      #changed because this is what shows up for all classes, including those without shields
    warrior:
      #0: text: "No Shield", notes:'No shield.', value:0
      1: text: t('shieldWarrior1Text'), notes: t('shieldWarrior1Notes', {con: 2}), con: 2, value:20
      2: text: t('shieldWarrior2Text'), notes: t('shieldWarrior2Notes', {con: 3}), con: 3, value:35
      3: text: t('shieldWarrior3Text'), notes: t('shieldWarrior3Notes', {con: 5}), con: 5, value:50
      4: text: t('shieldWarrior4Text'), notes: t('shieldWarrior4Notes', {con: 7}), con: 7, value:70
      5: text: t('shieldWarrior5Text'), notes: t('shieldWarrior5Notes', {con: 9}), con: 9, value:90, last: true
    rogue:
      0: text: t('weaponRogue0Text'), notes: t('weaponRogue0Notes'), str: 0, value: 0
      1: text: t('weaponRogue1Text'), notes: t('weaponRogue1Notes', {str: 2}), str: 2, value: 20
      2: text: t('weaponRogue2Text'), notes: t('weaponRogue2Notes', {str: 3}), str: 3, value: 35
      3: text: t('weaponRogue3Text'), notes: t('weaponRogue3Notes', {str: 4}), str: 4, value: 50
      4: text: t('weaponRogue4Text'), notes: t('weaponRogue4Notes', {str: 6}), str: 6, value: 70
      5: text: t('weaponRogue5Text'), notes: t('weaponRogue5Notes', {str: 8}), str: 8, value: 90
      6: text: t('weaponRogue6Text'), notes: t('weaponRogue6Notes', {str: 10}), str: 10, value: 120, last: true
    wizard: {}
      #0: text: "No Shield", notes:'No shield.', def: 0, value:0, last: true
    healer:
      #0: text: "No Shield", notes:'No shield.', def: 0, value:0
      1: text: t('shieldHealer1Text'), notes: t('shieldHealer1Notes', {con: 2}), con: 2, value:20
      2: text: t('shieldHealer2Text'), notes: t('shieldHealer2Notes', {con: 4}), con: 4, value:35
      3: text: t('shieldHealer3Text'), notes: t('shieldHealer3Notes', {con: 6}), con: 6, value:50
      4: text: t('shieldHealer4Text'), notes: t('shieldHealer4Notes', {con: 9}), con: 9, value:70
      5: text: t('shieldHealer5Text'), notes: t('shieldHealer5Notes', {con: 12}), con: 12, value:90, last: true
    special:
      0: text: t('shieldSpecial0Text'), notes: t('shieldSpecial0Notes', {per: 20}), per: 20, value:150, canOwn: ((u)-> +u.backer?.tier >= 45)
      1: text: t('shieldSpecial1Text'), notes: t('shieldSpecial1Notes', {attrs: 6}), con: 6, str: 6, per: 6, int:6, value:170, canOwn: ((u)-> +u.contributor?.level >= 5)
      #Winter event
      yeti:       event: events.winter, canOwn: ((u)->u.stats.class is 'warrior' ), text: t('shieldSpecialYetiText'), notes: t('shieldSpecialYetiNotes', {con: 7}), con: 7, value: 70
      ski:        event: events.winter, canOwn: ((u)->u.stats.class is 'rogue'   ), text: t('weaponSpecialSkiText'), notes: t('weaponSpecialSkiNotes', {str: 8}), str: 8, value: 90
      snowflake:  event: events.winter, canOwn: ((u)->u.stats.class is 'healer'  ), text: t('shieldSpecialSnowflakeText'), notes: t('shieldSpecialSnowflakeNotes', {con: 9}), con: 9, value: 70
      #Spring Fling
      springRogue:    event: events.spring, specialClass: 'rogue',   text: t('shieldSpecialSpringRogueText'), notes: t('shieldSpecialSpringRogueNotes', {str: 8}), value: 80, str: 8
      springWarrior:  event: events.spring, specialClass: 'warrior', text: t('shieldSpecialSpringWarriorText'), notes: t('shieldSpecialSpringWarriorNotes', {con: 7}), value: 70, con: 7
      springHealer:   event: events.spring, specialClass: 'healer',  text: t('shieldSpecialSpringHealerText'), notes: t('shieldSpecialSpringHealerNotes', {con: 9}), value: 70, con: 9

  back:
    base:
      0: text: t('backBase0Text'), notes: t('backBase0Notes'), value:0
    mystery:
      201402: text: t('backMystery201402Text'), notes: t('backMystery201402Notes'), mystery:mystery['201402'], value: 0
      201404: text: t('backMystery201404Text'), notes: t('backMystery201404Notes'), mystery:mystery['201404'], value: 0
    special:
      wondercon_red: text: t('backSpecialWonderconRedText'), notes: t('backSpecialWonderconRedNotes'), value: 0, mystery:mystery.wondercon
      wondercon_black: text: t('backSpecialWonderconBlackText'), notes: t('backSpecialWonderconBlackNotes'), value: 0,   mystery:mystery.wondercon

  body:
    base:
      0: text: t('bodyBase0Text'), notes:t('bodyBase0Notes'), value:0
    special:
      wondercon_red: text: t('bodySpecialWonderconRedText'), notes: t('bodySpecialWonderconRedNotes'), value: 0,      mystery:mystery.wondercon
      wondercon_gold: text: t('bodySpecialWonderconGoldText'), notes: t('bodySpecialWonderconGoldNotes'), value: 0,   mystery:mystery.wondercon
      wondercon_black: text: t('bodySpecialWonderconBlackText'), notes: t('bodySpecialWonderconBlackNotes'), value: 0,  mystery:mystery.wondercon

  headAccessory:
    base:
      0: text: t('headAccessoryBase0Text'), notes: t('headAccessoryBase0Notes'), value: 0, last: true
    special:
      # Spring Event
      springRogue:   event: events.spring, specialClass: 'rogue',   text: t('headAccessorySpecialSpringRogueText'), notes: t('headAccessorySpecialSpringRogueNotes'), value: 20
      springWarrior: event: events.spring, specialClass: 'warrior', text: t('headAccessorySpecialSpringWarriorText'), notes: t('headAccessorySpecialSpringWarriorNotes'), value: 20
      springMage:    event: events.spring, specialClass: 'wizard',  text: t('headAccessorySpecialSpringMageText'), notes: t('headAccessorySpecialSpringMageNotes'), value: 20
      springHealer:  event: events.spring, specialClass: 'healer',  text: t('headAccessorySpecialSpringHealerText'), notes: t('headAccessorySpecialSpringHealerNotes'), value: 20
      wondercon_red: text: t('headAccessorySpecialWonderconRedText'), notes: t('headAccessorySpecialWonderconRedNotes'), value: 0,           mystery:mystery.wondercon
      wondercon_black: text: t('headAccessorySpecialWonderconBlackText'), notes: t('headAccessorySpecialWonderconBlackNotes'), value: 0, mystery:mystery.wondercon
    mystery:
      201403: text: t('headAccessoryMystery201403Text'), notes: t('headAccessoryMystery201403Notes'), mystery:mystery['201403'], value: 0
      201404: text: t('headAccessoryMystery201404Text'), notes: t('headAccessoryMystery201404Notes'), mystery:mystery['201404'], value: 0

###
  The gear is exported as a tree (defined above), and a flat list (eg, {weapon_healer_1: .., shield_special_0: ...}) since
  they are needed in different froms at different points in the app
###
api.gear =
  tree: gear
  flat: {}

_.each gearTypes, (type) ->
  _.each classes.concat(['base', 'special', 'mystery']), (klass) ->
    # add "type" to each item, so we can reference that as "weapon" or "armor" in the html
    _.each gear[type][klass], (item, i) ->
      key = "#{type}_#{klass}_#{i}"
      _.defaults item, {type, key, klass, index: i, str:0, int:0, per:0, con:0}

      if item.event
        #? indicates null/undefined. true means they own currently, false means they once owned - and false is what we're
        # after (they can buy back if they bought it during the event's timeframe)
        _canOwn = item.canOwn or (->true)
        item.canOwn = (u)->
          _canOwn(u) and
            (u.items.gear.owned[key]? or (moment().isAfter(item.event.start) and moment().isBefore(item.event.end))) and
            (if item.specialClass then (u.stats.class is item.specialClass) else true)

      if item.mystery
        item.canOwn = (u)-> u.items.gear.owned[key]?

      api.gear.flat[key] = item

###
  ---------------------------------------------------------------
  Potion
  ---------------------------------------------------------------
###

api.potion = type: 'potion', text: t('potionText'), notes: t('potionNotes'), value: 25, key: 'potion'

###
   ---------------------------------------------------------------
   Classes
   ---------------------------------------------------------------
###

api.classes = classes

###
   ---------------------------------------------------------------
   Gear Types
   ---------------------------------------------------------------
###

api.gearTypes = gearTypes

###
  ---------------------------------------------------------------
  Spells
  ---------------------------------------------------------------
  Text, notes, and mana are obvious. The rest:

  * {target}: one of [task, self, party, user]. This is very important, because if the cast() function is expecting one
    thing and receives another, it will cause errors. `self` is used for self buffs, multi-task debuffs, AOEs (eg, meteor-shower),
    etc. Basically, use self for anything that's not [task, party, user] and is an instant-cast

  * {cast}: the function that's run to perform the ability's action. This is pretty slick - because this is exported to the
    web, this function can be performed on the client and on the server. `user` param is self (needed for determining your
    own stats for effectiveness of cast), and `target` param is one of [task, party, user]. In the case of `self` spells,
    you act on `user` instead of `target`. You can trust these are the correct objects, as long as the `target` attr of the
    spell is correct. Take a look at habitrpg/src/models/user.js and habitrpg/src/models/task.js for what attributes are
    available on each model. Note `task.value` is its "redness". If party is passed in, it's an array of users,
    so you'll want to iterate over them like: `_.each(target,function(member){...})`

  Note, user.stats.mp is docked after automatically (it's appended to functions automatically down below in an _.each)
###

#
diminishingReturns = (bonus, max, halfway=max/2) -> max*(bonus/(bonus+halfway))

api.spells =

  wizard:
    fireball:
      text: t('spellWizardFireballText')
      mana: 10
      lvl: 11
      target: 'task'
      notes: t('spellWizardFireballNotes')
      cast: (user, target) ->
        # I seriously have no idea what I'm doing here. I'm just mashing buttons until numbers seem right-ish. Anyone know math?
        bonus = user._statsComputed.int * user.fns.crit('per')
        target.value += diminishingReturns(bonus*.02, 4)
        bonus *= Math.ceil ((if target.value < 0 then 1 else target.value+1) *.075)
        #console.log {bonus, expBonus:bonus,upBonus:bonus*.1}
        user.stats.exp += diminishingReturns(bonus,75)
        user.party.quest.progress.up += diminishingReturns(bonus*.1,50,30) if user.party.quest.key

    mpheal:
      text: t('spellWizardMPHealText')
      mana: 30
      lvl: 12
      target: 'party'
      notes: t('spellWizardMPHealNotes'),
      cast: (user, target)->
        _.each target, (member) ->
          bonus = Math.ceil(user._statsComputed.int * .1)
          bonus = 25 if bonus > 25 #prevent ability to replenish own mp infinitely
          member.stats.mp += bonus

    earth:
      text: t('spellWizardEarthText')
      mana: 35
      lvl: 13
      target: 'party'
      notes: t('spellWizardEarthNotes'),
      cast: (user, target) ->
        _.each target, (member) ->
          member.stats.buffs.int ?= 0
          member.stats.buffs.int += Math.ceil(user._statsComputed.int * .05)

    frost:
      text: t('spellWizardFrostText'),
      mana: 40
      lvl: 14
      target: 'self'
      notes: t('spellWizardFrostNotes'),
      cast: (user, target) ->
        user.stats.buffs.streaks = true

  warrior:
    smash:
      text: t('spellWarriorSmashText')
      mana: 10
      lvl: 11
      target: 'task'
      notes: t('spellWarriorSmashNotes')
      cast: (user, target) ->
        target.value += 2.5 * (user._statsComputed.str / (user._statsComputed.str + 50)) * user.fns.crit('con')
        user.party.quest.progress.up += Math.ceil(user._statsComputed.str * .2) if user.party.quest.key
    defensiveStance:
      text: t('spellWarriorDefensiveStanceText')
      mana: 25
      lvl: 12
      target: 'self'
      notes: t('spellWarriorDefensiveStanceNotes')
      cast: (user, target) ->
        user.stats.buffs.con ?= 0
        user.stats.buffs.con += Math.ceil(user._statsComputed.con * .05)
    valorousPresence:
      text: t('spellWarriorValorousPresenceText')
      mana: 20
      lvl: 13
      target: 'party'
      notes: t('spellWarriorValorousPresenceNotes')
      cast: (user, target) ->
        _.each target, (member) ->
          member.stats.buffs.str ?= 0
          member.stats.buffs.str += Math.ceil(user._statsComputed.str * .05)
    intimidate:
      text: t('spellWarriorIntimidateText')
      mana: 15
      lvl: 14
      target: 'party'
      notes: t('spellWarriorIntimidateNotes')
      cast: (user, target) ->
        _.each target, (member) ->
          member.stats.buffs.con ?= 0
          member.stats.buffs.con += Math.ceil(user._statsComputed.con *  .03)

  rogue:
    pickPocket:
      text: t('spellRoguePickPocketText')
      mana: 10
      lvl: 11
      target: 'task'
      notes: t('spellRoguePickPocketNotes')
      cast: (user, target) ->
        bonus = (if target.value < 0 then 1 else target.value+2) + (user._statsComputed.per * 0.5)
        user.stats.gp += 25 * (bonus / (bonus + 75))
    backStab:
      text: t('spellRogueBackStabText')
      mana: 15
      lvl: 12
      target: 'task'
      notes: t('spellRogueBackStabNotes')
      cast: (user, target) ->
        _crit = user.fns.crit('str', .3)
        target.value += _crit * .03
        bonus =  (if target.value < 0 then 1 else target.value+1) * _crit
        user.stats.exp += bonus
        user.stats.gp += bonus
        # user.party.quest.progress.up += bonus if user.party.quest.key # remove hurting bosses for rogues, seems OP for now
    toolsOfTrade:
      text: t('spellRogueToolsOfTradeText')
      mana: 25
      lvl: 13
      target: 'party'
      notes: t('spellRogueToolsOfTradeNotes')
      cast: (user, target) ->
        ## lasts 24 hours ##
        _.each target, (member) ->
          member.stats.buffs.per ?= 0
          member.stats.buffs.per += Math.ceil(user._statsComputed.per * .03)
    stealth:
      text: t('spellRogueStealthText')
      mana: 45
      lvl: 14
      target: 'self'
      notes: t('spellRogueStealthNotes')
      cast: (user, target) ->
        user.stats.buffs.stealth ?= 0
        ## scales to user's # of dailies; maxes out at 100% at 100 per ##
        user.stats.buffs.stealth += Math.ceil(user.dailys.length * user._statsComputed.per / 100)

  healer:
    heal:
      text: t('spellHealerHealText')
      mana: 15
      lvl: 11
      target: 'self'
      notes: t('spellHealerHealNotes')
      cast: (user, target) ->
        user.stats.hp += (user._statsComputed.con + user._statsComputed.int + 5) * .075
        user.stats.hp = 50 if user.stats.hp > 50
    brightness:
      text: t('spellHealerBrightnessText')
      mana: 15
      lvl: 12
      target: 'self'
      notes: t('spellHealerBrightnessNotes')
      cast: (user, target) ->
        _.each user.tasks, (target) ->
          return if target.type is 'reward'
          target.value += 1.5 * (user._statsComputed.int / (user._statsComputed.int + 40))
    protectAura:
      text: t('spellHealerProtectAuraText')
      mana: 30
      lvl: 13
      target: 'party'
      notes: t('spellHealerProtectAuraNotes')
      cast: (user, target) ->
        ## lasts 24 hours ##
        _.each target, (member) ->
          member.stats.buffs.con ?= 0
          member.stats.buffs.con += Math.ceil(user._statsComputed.con * .15)
    heallAll:
      text: t('spellHealerHealAllText')
      mana: 25
      lvl: 14
      target: 'party'
      notes: t('spellHealerHealAllNotes')
      cast: (user, target) ->
        _.each target, (member) ->
          member.stats.hp += (user._statsComputed.con + user._statsComputed.int + 5) * .04
          member.stats.hp = 50 if member.stats.hp > 50

  special:
    snowball:
      text: t('spellSpecialSnowballAuraText')
      mana: 0
      value: 1
      target: 'user'
      notes: t('spellSpecialSnowballAuraNotes')
      cast: (user, target) ->
        target.stats.buffs.snowball = true
        target.achievements.snowball ?= 0
        target.achievements.snowball++
        user.items.special.snowball--

    salt:
      text: t('spellSpecialSaltText')
      mana: 0
      value: 5
      target: 'self'
      notes: t('spellSpecialSaltNotes')
      cast: (user, target) ->
        user.stats.buffs.snowball = false
        user.stats.gp -= 5

# Intercept all spells to reduce user.stats.mp after casting the spell
_.each api.spells, (spellClass) ->
  _.each spellClass, (spell, key) ->
    spell.key = key
    _cast = spell.cast
    spell.cast = (user, target) ->
      #return if spell.target and spell.target != (if target.type then 'task' else 'user')
      _cast(user,target)
      user.stats.mp -= spell.mana

api.special = api.spells.special

###
  ---------------------------------------------------------------
  Drops
  ---------------------------------------------------------------
###

api.dropEggs =
  # value & other defaults set below
  Wolf:             text: t('dropEggWolfText'), adjective: t('dropEggWolfAdjective')
  TigerCub:         text: t('dropEggTigerCubText'), mountText: t('dropEggTigerCubMountText'), adjective: t('dropEggTigerCubAdjective')
  PandaCub:         text: t('dropEggPandaCubText'), mountText: t('dropEggPandaCubMountText'), adjective: t('dropEggPandaCubAdjective')
  LionCub:          text: t('dropEggLionCubText'),  mountText: t('dropEggLionCubMountText'), adjective: t('dropEggLionCubAdjective')
  Fox:              text: t('dropEggFoxText'), adjective: t('dropEggFoxAdjective')
  FlyingPig:        text: t('dropEggFlyingPigText'), adjective: t('dropEggFlyingPigAdjective')
  Dragon:           text: t('dropEggDragonText'), adjective: t('dropEggDragonAdjective')
  Cactus:           text: t('dropEggCactusText'), adjective: t('dropEggCactusAdjective')
  BearCub:          text: t('dropEggBearCubText'),  mountText: t('dropEggBearCubMountText'), adjective: t('dropEggBearCubAdjective')
_.each api.dropEggs, (egg,key) ->
  _.defaults egg,
    canBuy:true
    value: 3
    key: key
    notes: t('eggNotes', {eggText: egg.text, eggAdjective: egg.adjective})
    mountText: egg.text

api.questEggs =
  # value & other defaults set below
  Gryphon:          text: t('questEggGryphonText'),  adjective: t('questEggGryphonAdjective'), canBuy: false
  Hedgehog:         text: t('questEggHedgehogText'), adjective: t('questEggHedgehogAdjective'), canBuy: false
  Deer:             text: t('questEggDeerText'), adjective: t('questEggDeerAdjective'), canBuy: false
  Egg:              text: t('questEggEggText'), adjective: t('questEggEggAdjective'), canBuy: false
  Rat:              text: t('questEggRatText'), adjective: t('questEggRatAdjective'), canBuy: false

_.each api.questEggs, (egg,key) ->
  _.defaults egg,
    canBuy:false
    value: 3
    key: key
    notes: t('eggNotes', {eggText: egg.text, eggAdjective: egg.adjective})
    mountText: egg.text

api.eggs = _.assign(_.cloneDeep(api.dropEggs), api.questEggs)

api.specialPets =
  'Wolf-Veteran':   true
  'Wolf-Cerberus':  true
  'Dragon-Hydra':   true
  'Turkey-Base':    true
  'BearCub-Polar':  true

api.specialMounts =
  'BearCub-Polar':	true
  'LionCub-Ethereal':	true

api.hatchingPotions =
  Base:             value: 2, text: t('hatchingPotionBase')
  White:            value: 2, text: t('hatchingPotionWhite')
  Desert:           value: 2, text: t('hatchingPotionDesert')
  Red:              value: 3, text: t('hatchingPotionRed')
  Shade:            value: 3, text: t('hatchingPotionShade')
  Skeleton:         value: 3, text: t('hatchingPotionSkeleton')
  Zombie:           value: 4, text: t('hatchingPotionZombie')
  CottonCandyPink:  value: 4, text: t('hatchingPotionCottonCandyPink')
  CottonCandyBlue:  value: 4, text: t('hatchingPotionCottonCandyBlue')
  Golden:           value: 5, text: t('hatchingPotionGolden')
_.each api.hatchingPotions, (pot,key) ->
  _.defaults pot, {key, value: 2, notes: t('hatchingPotionNotes', {potText: pot.text})}

api.pets = _.transform api.dropEggs, (m, egg) ->
  _.defaults m, _.transform api.hatchingPotions, (m2, pot) ->
    m2[egg.key + "-" + pot.key] = true

api.questPets = _.transform api.questEggs, (m, egg) ->
  _.defaults m, _.transform api.hatchingPotions, (m2, pot) ->
    m2[egg.key + "-" + pot.key] = true

api.food =
  Meat:             text: t('foodMeat'), target: 'Base', article: ''
  Milk:             text: t('foodMilk'), target: 'White', article: ''
  Potatoe:          text: t('foodPotatoe'), target: 'Desert', article: 'a '
  Strawberry:       text: t('foodStrawberry'), target: 'Red', article: 'a '
  Chocolate:        text: t('foodChocolate'), target: 'Shade', article: ''
  Fish:             text: t('foodFish'), target: 'Skeleton', article: 'a '
  RottenMeat:       text: t('foodRottenMeat'), target: 'Zombie', article: ''
  CottonCandyPink:  text: t('foodCottonCandyPink'), target: 'CottonCandyPink', article: ''
  CottonCandyBlue:  text: t('foodCottonCandyBlue'), target: 'CottonCandyBlue', article: ''
  # FIXME what to do with these extra items? Should we add "targets" (plural) for food instead of singular, so we don't have awkward extras?
  #Cheese:           text: 'Cheese', target: 'Golden'
  #Watermelon:       text: 'Watermelon', target: 'Golden'
  #SeaWeed:          text: 'SeaWeed', target: 'Golden'

  Cake_Skeleton:        canBuy: false, text: t('foodCakeSkeleton'), target: 'Skeleton', article: ''
  Cake_Base:            canBuy: false, text: t('foodCakeBase'), target: 'Base', article: ''
  Cake_CottonCandyBlue: canBuy: false, text: t('foodCakeCottonCandyBlue'), target: 'CottonCandyBlue', article: ''
  Cake_CottonCandyPink: canBuy: false, text: t('foodCakeCottonCandyPink'), target: 'CottonCandyPink', article: ''
  Cake_Shade:           canBuy: false, text: t('foodCakeShade'), target: 'Shade', article: ''
  Cake_White:           canBuy: false, text: t('foodCakeWhite'), target: 'White', article: ''
  Cake_Golden:          canBuy: false, text: t('foodCakeGolden'), target: 'Golden', article: ''
  Cake_Zombie:          canBuy: false, text: t('foodCakeZombie'), target: 'Zombie', article: ''
  Cake_Desert:          canBuy: false, text: t('foodCakeDesert'), target: 'Desert', article: ''
  Cake_Red:             canBuy: false, text: t('foodCakeRed'), target: 'Red', article: ''

  # Tests hack, put honey last so the faux random picks it up in unit tests
  Honey:            text: t('foodHoney'), target: 'Golden', article: ''

  Saddle:           text: t('foodSaddleText'), value: 5, notes: t('foodSaddleNotes')
_.each api.food, (food,key) ->
  _.defaults food, {value: 1, key, notes: t('foodNotes'), canBuy:true}

api.quests =

  evilsanta:
    canBuy:false
    text: t('questEvilSantaText') # title of the quest (eg, Deep into Vice's Layer)
    notes: t('questEvilSantaNotes')
    completion: t('questEvilSantaCompletion')
    value: 4 # Gem cost to buy, GP sell-back
    #mechanic: enum['perfectDailies', ...]
    boss:
      name: t('questEvilSantaBoss') # name of the boss himself (eg, Vice)
      hp: 300
      str: 1 # Multiplier of users' missed dailies
    drop:
      items: [
        {type: 'mounts', key: 'BearCub-Polar', text: t('questEvilSantaDropBearCubPolarMount')}
      ]
      gp: 20
      exp: 100 # Exp bonus from defeating the boss

  evilsanta2:
    canBuy:false
    text: t('questEvilSanta2Text')
    notes: t('questEvilSanta2Notes')
    completion: t('questEvilSanta2Completion')
    value: 4
    previous: 'evilsanta'
    collect:
      tracks: text: t('questEvilSanta2CollectTracks'), count: 20
      branches: text: t('questEvilSanta2CollectBranches'), count: 10
    drop:
      items: [
        {type: 'pets', key: 'BearCub-Polar', text: t('questEvilSanta2DropBearCubPolarPet')}
      ]
      gp: 20
      exp: 100

  gryphon:
    text: t('questGryphonText')
    notes: t('questGryphonNotes')
    completion: t('questGryphonCompletion')
    value: 4 # Gem cost to buy, GP sell-back
    boss:
      name: t('questGryphonBoss') # name of the boss himself (eg, Vice)
      hp: 300
      str: 1.5 # Multiplier of users' missed dailies
    drop:
      items: [
        {type: 'eggs', key: 'Gryphon', text: t('questGryphonDropGryphonEgg')}
        {type: 'eggs', key: 'Gryphon', text: t('questGryphonDropGryphonEgg')}
        {type: 'eggs', key: 'Gryphon', text: t('questGryphonDropGryphonEgg')}
      ]
      gp: 25
      exp: 125
      
  hedgehog:
    text: t('questHedgehogText')
    notes: t('questHedgehogNotes')
    completion: t('questHedgehogCompletion')
    value: 4 # Gem cost to buy, GP sell-back
    boss:
      name: t('questHedgehogBoss') # name of the boss himself (eg, Vice)
      hp: 400
      str: 1.25 # Multiplier of users' missed dailies
    drop:
      items: [
        {type: 'eggs', key: 'Hedgehog', text: t('questHedgehogDropHedgehogEgg')}
        {type: 'eggs', key: 'Hedgehog', text: t('questHedgehogDropHedgehogEgg')}
        {type: 'eggs', key: 'Hedgehog', text: t('questHedgehogDropHedgehogEgg')}
      ]
      gp: 30
      exp: 125


  ghost_stag:
    text: t('questGhostStagText')
    notes: t('questGhostStagNotes')
    completion: t('questGhostStagCompletion')
    value: 4
    boss:
      name: t('questGhostStagBoss')
      hp: 1200
      str: 2.5
    drop:
      items: [
        {type: 'eggs', key: 'Deer', text: t('questGhostStagDropDeerEgg')}
        {type: 'eggs', key: 'Deer', text: t('questGhostStagDropDeerEgg')}
        {type: 'eggs', key: 'Deer', text: t('questGhostStagDropDeerEgg')}
      ]
      gp: 80
      exp: 800


  vice1:
    text: t('questVice1Text')
    notes: t('questVice1Notes')
    value: 4
    lvl: 30
    boss:
      name: t('questVice1Boss')
      hp: 750
      str: 1.5
    drop:
      items: [
        {type: 'quests', key: "vice2", text: t('questVice1DropVice2Quest')}
      ]
      gp: 20
      exp: 100

  vice2:
    text: t('questVice2Text')
    notes: t('questVice2Notes')
    value: 4
    lvl: 35
    previous: 'vice1'
    collect:
      lightCrystal: text: t('questVice2CollectLightCrystal'), count: 45
    drop:
      items: [
        {type: 'quests', key: 'vice3', text: t('questVice2DropVice3Quest')}
      ]
      gp: 20
      exp: 75

  vice3:
    text: t('questVice3Text')
    notes: t('questVice3Notes')
    completion: t('questVice3Completion')
    previous: 'vice2'
    value: 4
    lvl: 40
    boss:
      name: t('questVice3Boss')
      hp: 1500
      str: 3
    drop:
      items: [
        {type: 'gear', key: "weapon_special_2", text: t('questVice3DropWeaponSpecial2')}
        {type: 'eggs', key: 'Dragon', text: t('questVice3DropDragonEgg')}
        {type: 'eggs', key: 'Dragon', text: t('questVice3DropDragonEgg')}
        {type: 'hatchingPotions', key: 'Shade', text: t('questVice3DropShadeHatchingPotion')}
        {type: 'hatchingPotions', key: 'Shade', text: t('questVice3DropShadeHatchingPotion')}
      ]
      gp: 100
      exp: 1000

  egg:
    text: t('questEggHuntText')
    notes: t('questEggHuntNotes')
    completion: t('questEggHuntCompletion')
    value: 1
    canBuy: false
    collect:
      plainEgg: text: t('questEggHuntCollectPlainEgg'), count: 100
    drop:
      items: [
        {type: 'eggs', key: 'Egg', text: t('questEggHuntDropPlainEgg')}
        {type: 'eggs', key: 'Egg', text: t('questEggHuntDropPlainEgg')}
        {type: 'eggs', key: 'Egg', text: t('questEggHuntDropPlainEgg')}
        {type: 'eggs', key: 'Egg', text: t('questEggHuntDropPlainEgg')}
        {type: 'eggs', key: 'Egg', text: t('questEggHuntDropPlainEgg')}
        {type: 'eggs', key: 'Egg', text: t('questEggHuntDropPlainEgg')}
        {type: 'eggs', key: 'Egg', text: t('questEggHuntDropPlainEgg')}
        {type: 'eggs', key: 'Egg', text: t('questEggHuntDropPlainEgg')}
        {type: 'eggs', key: 'Egg', text: t('questEggHuntDropPlainEgg')}
        {type: 'eggs', key: 'Egg', text: t('questEggHuntDropPlainEgg')}
      ]
      gp: 0
      exp: 0

  rat:
    text: t('questRatText')
    notes: t('questRatNotes')
    completion: t('questRatCompletion')
    value: 4
    boss:
      name: t('questRatBoss')
      hp: 1200
      str: 2.5
    drop:
      items: [
        {type: 'eggs', key: 'Rat', text: t('questRatDropRatEgg')}
        {type: 'eggs', key: 'Rat', text: t('questRatDropRatEgg')}
        {type: 'eggs', key: 'Rat', text: t('questRatDropRatEgg')}
      ]
      gp: 80
      exp: 800


_.each api.quests, (v,key) ->
  _.defaults v, {key,canBuy:true}

repeat = {m:true,t:true,w:true,th:true,f:true,s:true,su:true}
api.userDefaults =
  habits: [
    {type: 'habit', text: t('defaultHabit1Text'), notes: t('defaultHabit1Notes'), value: 0, up: true, down: false, attribute: 'per' }
    {type: 'habit', text: t('defaultHabit2Text'), notes: t('defaultHabit2Notes'), value: 0, up: false, down: true, attribute: 'con'}
    {type: 'habit', text: t('defaultHabit3Text'), notes: t('defaultHabit3Notes'), value: 0, up: true, down: true, attribute: 'str'}
  ]

  dailys: [
    {type: 'daily', text: t('defaultDaily1Text'), notes: t('defaultDaily1Notes'), value: 0, completed: false, repeat: repeat, attribute: 'per' }
    {type: 'daily', text: t('defaultDaily2Text'), notes: t('defaultDaily2Notes'), value: 3, completed: false, repeat: repeat, attribute: 'con' }
    {type: 'daily', text: t('defaultDaily3Text'), notes: t('defaultDaily3Notes'), value: -10, completed: false, repeat: repeat, attribute: 'int' }
    {type: 'daily', text: t('defaultDaily4Text'), notes: t('defaultDaily4Notes'), checklist: [{completed: true, text: t('defaultDaily4Checklist1') }, {completed: false, text: t('defaultDaily4Checklist2')}, {completed: false, text: t('defaultDaily4Checklist3')}], completed: false, repeat: repeat, attribute: 'str' }
  ]

  todos: [
    {type: 'todo', text: t('defaultTodo1Text'), notes: t('defaultTodo1Notes'), completed: false, attribute: 'int' }
    {type: 'todo', text: t('defaultTodo2Text'), notes: t('defaultTodo2Notes'), completed: false, attribute: 'int' }
    {type: 'todo', text: t('defaultTodo3Text'), notes: t('defaultTodo3Notes'), value: -3, completed: false, attribute: 'per' }
  ]

  rewards: [
    {type: 'reward', text: t('defaultReward1Text'), notes: t('defaultReward1Notes'), value: 20 }
    {type: 'reward', text: t('defaultReward2Text'), notes: t('defaultReward2Notes'), value: 10 }
  ]

  tags: [
    {name: t('defaultTag1')}
    {name: t('defaultTag2')}
    {name: t('defaultTag3')}
  ]

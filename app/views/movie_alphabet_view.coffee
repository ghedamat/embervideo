App.MovieAlphabetView = Em.View.extend
  templateName: 'templates/alphabet'
  alphabet: ['ALL','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']

App.MovieLetterView = Em.View.extend
  letter: undefined
  classNames: ['alert','letter-item']
  classNameBindings: ['isSelected:alert-error:alert-info']
  isSelected: (->
    @get('letter') == @get('controller.currentLetter')
  ).property('controller.currentLetter')
  click: (e) ->
    @set('controller.currentLetter',@letter)

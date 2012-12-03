#*************************************************************************************
# TOCOMMENT
#*************************************************************************************
@view "Games.Index",
  #*************************************************************************************
  # CONSTRUCTOR
  #*************************************************************************************
  constructor: ->
    @score = 0
    @life = 3

    @launcher = window.setInterval((=> @popRandomTargets()), 500)

    $('#trashes div.chicken').click (e) => @hideChicken($(e.target), true)
    $('#trashes div.piggy').click (e) => @hidePiggy($(e.target), true)


  #*************************************************************************************
  # PUBLIC INSTANCE METHODS
  #*************************************************************************************
  endGame: () ->
    window.clearInterval @launcher

    $('#life-pane').hide()
    $('#submit-pane').fadeIn 500, -> $('#field-name').focus()


  hideChicken: (chicken, clicked) ->
    @incrementScore() if clicked

    @hideTarget chicken


  hidePiggy: (piggy, clicked) ->
    @removeLife() if clicked

    @hideTarget piggy


  hideTarget: (target) ->
    trash = target.closest('div.trash')

    target.animate({ marginTop: '100px' }, 200)

    trash = target.closest('div.trash')
    trash.removeClass 'popped'
    trash.addClass 'hidden'


  incrementScore: () ->
    @score += 1

    $('#field-score').val @score
    $('#score').html @score


  popRandomTargets: () ->
    id = Math.floor((Math.random()*10)+1)
    nature_id = Math.floor((Math.random()*100)+1)

    return false if id > 5

    if nature_id < 45
      @popTarget('chicken', id, 1200)
    else if nature_id < 60
      @popTarget('piggy', id, 2100)
    else if nature_id < 100
      @popFakeTarget(id)


  popFakeTarget: (id) ->
    popChickenTime = (Math.floor((Math.random()*6)) * 100) + 600
    popPiggyTime = popChickenTime + 100

    @popTarget('chicken', id, popChickenTime)
    setTimeout ( => @popTarget('piggy', id, 1400) ), popPiggyTime


  popTarget: (nature, id, expositionTime) ->
    trash = target = $('#trash' + id + '.hidden')
    target = trash.find('div.' + nature)

    target.animate({ marginTop: '0px' }, 200)

    trash.addClass('popped')
    trash.removeClass('hidden')

    if nature == 'chicken'
      setTimeout ( => @hideChicken(target, false) ), expositionTime
    else
      setTimeout ( => @hidePiggy(target, false) ), expositionTime


  removeLife: () ->
    $('#life' + @life + ' div.killed').show()
    @life -= 1

    @endGame() if @life <= 0

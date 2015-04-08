# this script for the animation of the slider
createDots = ->
  nav = $('#slider-nav ul')
  slides = $('.slide').length
  i = 0
  while i < slides
    nav.append '<li class="dot">&bull;</li>'
    i++
  $('.dot').first().addClass 'active-dot'
  return

# Next slide transition

next = ->
  activeSlide = $('.active-slide')
  nextSlide = activeSlide.next('.slide')
  if nextSlide.length == 0
    nextSlide = $('.slide').first()
  activeSlide.fadeOut('slow').removeClass 'active-slide'
  nextSlide.fadeIn(1000).addClass 'active-slide'
  activeDot = $('.active-dot')
  nextDot = activeDot.next('.dot')
  if nextDot.length == 0
    nextDot = $('.dot').first()
  activeDot.removeClass 'active-dot'
  nextDot.addClass 'active-dot'
  return

prev = ->
  activeSlide = $('.active-slide')
  prevSlide = activeSlide.prev('.slide')
  if prevSlide.length == 0
    prevSlide = $('.slide').last()
  activeSlide.fadeOut('slow').removeClass 'active-slide'
  prevSlide.fadeIn(1000).addClass 'active-slide'
  activeDot = $('.active-dot')
  prevDot = activeDot.prev('.dot')
  if prevDot.length == 0
    prevDot = $('.dot').last()
  activeDot.removeClass 'active-dot'
  prevDot.addClass 'active-dot'
  return

clickDot = (dot) ->
  activeSlide = $('.active-slide')
  i = $(dot).index() + 1
  nextSlide = $('.slide:nth-child(' + i + ')')
  activeSlide.fadeOut('slow').removeClass 'active-slide'
  nextSlide.fadeIn(1000).addClass 'active-slide'
  $('.active-dot').removeClass 'active-dot'
  $(dot).addClass 'active-dot'
  return

slideLoop = undefined

showDialog = (show) ->
  if show
    $('#dialog').fadeIn 'slow'
    clearInterval slideLoop
  else
    $('#dialog').fadeOut 'slow'
  show

main = ->
  mili = 5000
  dialog = false
  createDots()
  # Move automaticaly through the slides
  slideLoop = setInterval(next, mili)
  $('#slider').mouseenter ->
    $('.arrow').fadeIn 'slow'
    $('#update-btn').fadeIn 'slow'
    if !dialog
      clearInterval slideLoop
    return
  $('#slider').mouseleave ->
    $('.arrow').fadeOut 'slow'
    $('#update-btn').fadeOut 'slow'
    if !dialog
      slideLoop = setInterval(next, mili)
    return
  $('.right').click next
  $('.left').click prev
  # Clicking a dot move to the corresponding slide
  $('.dot').click ->
    clickDot this
    return

$(document).ready main



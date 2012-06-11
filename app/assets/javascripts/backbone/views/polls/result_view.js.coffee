AsqUs.Views.Polls ||= {}

class AsqUs.Views.Polls.ResultView extends Backbone.View
  template: JST["backbone/templates/polls/result"]
  
  render: ->
    @model.attributes.share_url = document.location.href
    $(@el).html(@template(@model.toJSON() ))
    return this

  generatePlots: ->
    console.log "Plots for"
    console.log @model.attributes
    @generateResultPlot()
    @generateActivityPlot()
    return this
  
  
  generateResultPlot: ->
    plot_element = $("#poll_#{@model.attributes.poll_id}_result_plot")
    console.log 'Plot element:'
    console.log plot_element
    if plot_element.length == 0
      return this
    if @model.attributes.totals == null
      console.log 'Totals null'
      $('.poll-result-plot .plot-no-data').show()
      plot_element.hide()
      return this
      
    plot_data = @model.attributes.totals.map (val) ->
      return { label: val.option, data: parseInt(val.count) }
    console.log "HEREEE"
    #data = [ { label: "Series1",  data: 10}, { label: "Series2",  data: 30}, { label: "Series3",  data: 90}, { label: "Series4",  data: 5}, { label: "Series5",  data: 20} ]
    if plot_data.length == 4
      color_array = [
        '#31546B'
        '#6298EB'
        '#9DA7B2'
        '#71A43B'
      ]
    else
      color_array = [
        '#6D6'
        '#D66'
      ]
    plot_options =
      series:
        pie:
          show: true
          radius: 1
          label:
            radius: 0.7
            formatter: (label, series) ->
              return '<div class="plot-label"><div class="plot-label-label">'+label+'</div>'+
              '<div class="plot-label-series">'+ Math.round(series.percent) + "%</div></div>"
      colors: color_array
      legend:
        show: true
        position: 'nw'
        labelFormatter: (label, series) ->
          return label + ' ' + Math.round(series.percent) + '%'
      grid:
        clickable: true
      highlight:
        opacity: 0.9
    window.plot_element = plot_element
    window.plot_data = plot_data
    window.plot_options = plot_options
    $.plot(plot_element, plot_data, plot_options)
    return this


  generateActivityPlot: ->
    plot_element = $("#poll_#{@model.attributes.poll_id}_time_plot")
    if plot_element.length == 0
      return this
    if @model.attributes.totals == null
      $('.poll-time-plot .plot-no-data').show()
      plot_element.hide()
      return this

    plot_data = @model.attributes.votes_per_day.map (val) ->
      return [ val[0], val[1] ]
    plot_options =
      series:
        lines:
          show: true
          fill: true
          fillColor: 'rgba(170, 170, 187, 0.5)'
        points:
          show: false
      yaxis:
        show: true
        ticks: 0
      xaxis:
        show: true
        mode: "time"
        tickSize: [1, 'month']
        timeformat: "%b" #"%y/%m/%d"
      legend:
        show: false
      shadowSize: 5
      grid:
        hoverable: false
        clickable: false
        borderWidth: 1
        borderColor: '#777'
        backgroundColor:
          colors: ["#DDF0FF", "#999"]
      highlight:
        opacity: 0.9
      colors: ['#FFC']
    $.plot(plot_element, [ plot_data ], plot_options)
      
    return this


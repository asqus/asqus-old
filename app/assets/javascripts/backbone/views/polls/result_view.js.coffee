AsqUs.Views.Polls ||= {}

class AsqUs.Views.Polls.ResultView extends Backbone.View
  template: JST["backbone/templates/polls/result"]
  
  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this

  generatePlots: ->
    plot_data = @model.attributes.totals.map (val) ->
      return { label: val.option, data: val.count }
    #data = [ { label: "Series1",  data: 10}, { label: "Series2",  data: 30}, { label: "Series3",  data: 90}, { label: "Series4",  data: 5}, { label: "Series5",  data: 20} ]
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
      colors: [
        '#6D6'
        '#D66'
      ]
      legend:
        show: true
        labelFormatter: (label, series) ->
          return label + ' ' + Math.round(series.percent) + '%'
      grid:
        clickable: true
      highlight:
        opacity: 0.9
    $.plot($("#poll_#{@model.attributes.poll_id}_result_plot"), plot_data, plot_options)

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
        show: false
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
    $.plot($("#poll_#{@model.attributes.poll_id}_time_plot"), [ plot_data ], plot_options)
      
    return this


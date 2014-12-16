(->
  Weather =
    init: ->
      that = this
      content.find(":submit").click (e) ->
        e.preventDefault()
        data = searchBox.val()
        if data.length > 0
          that.city = data
          searchBox.val("").focus()
          return that.gotInput(data)
        searchBox.val("").focus()

    convertToFarenheit: (val) ->
      return (((val-273.15)*1.8)+32).toFixed(2) + " \u00B0F"

    gotInput: (city) ->
      @url = "http://api.openweathermap.org/data/2.5/weather?q=" + city + "&callback=?"
      @fetch()

    fetch: ->
      that = this
      $.ajax
        url: that.url
        dataType: "json"
        success: (data) ->
          console.log data
          if data.main
            that.weather =
              city: data.name
              country: data.sys.country
              temp: that.convertToFarenheit(data.main.temp)
              humid: data.main.humidity
              weatherdesc: data.weather[0].description

            console.log "SUCCESS Connection"
            that.attachTemplate false
          else
            that.attachTemplate true
            console.log "DATA isn't available"

        error: (data) ->
          console.log "ERROR Connection"


    attachTemplate: (error) ->
      template = Handlebars.compile(handleBar.html())
      data = @weather
      data = msg: "The city you have entered is not available"  if error
      error = false
      outputLocation.prepend template(data)
  #Weather
  Weather.init @handleBar = $("#weather-template"), @content = $("#main"), @outputLocation = $("#output"), @searchBox = $("#searchCity")
)()
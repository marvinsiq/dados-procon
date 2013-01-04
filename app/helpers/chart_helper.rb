DadosProcon.helpers do

  def draw_pie_chart(options)
    options[:chart_class] = 'PieChart'
    chart_template options
  end
  
  def draw_line_chart(options)
    options[:chart_class] = 'LineChart'
    chart_template options
  end
  
  def draw_bar_chart(options)
    options[:chart_class] = 'BarChart'
    chart_template options
  end
  
  private
    def chart_template(options)
      options[:chart_container] ||= 'chart_div'
      options[:width] ||= 400
      options[:height] ||= 300
      
      <<-eos
  <!--Load the AJAX API-->
  <script type="text/javascript" src="https://www.google.com/jsapi"></script>
  <script type="text/javascript">

    // Load the Visualization API and the piechart package.
    google.load('visualization', '1.0', {'packages':['corechart']});

    // Set a callback to run when the Google Visualization API is loaded.
    google.setOnLoadCallback(drawChart);

    // Callback that creates and populates a data table,
    // instantiates the chart, passes in the data and
    // draws it.
    function drawChart() {

      // Create the data table.
      var data = google.visualization.arrayToDataTable(#{options[:data]});

      // Set chart options
      var options = {'title':'#{options[:title]}',
                     'width':#{options[:width]},
                     'height':#{options[:height]}};

      // Instantiate and draw the chart, passing in some options.
      var chart = new google.visualization.#{options[:chart_class]}(document.getElementById('#{options[:chart_container]}'));
      chart.draw(data, options);
    }
  </script>
      eos
    end

end

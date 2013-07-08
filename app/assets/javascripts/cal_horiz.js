$(document).ready(function() {
  var calendarViz = {
    percent:      d3.format(".1%"),
    weekday:      function(dt) { return parseInt(d3.time.format("%w")(dt)); },
    dayInMonth:   function(dt) { return parseInt(d3.time.format("%d")(dt)); },
    weekInYear:   function(dt) { return parseInt(d3.time.format("%U")(dt)); },
    weekInMonth:  function(dt) { 
                    var md = this.dayInMonth(dt);
                    var wd = this.weekday(dt);
                    var fd = this.weekday(new Date(dt.getFullYear(), dt.getMonth(), 1));
                    var wk = Math.floor((md - wd) / 7) + 1;
                    return (fd == 0 || fd == 1) ? wk - 1 : wk;
                  },
    dayOfWeekAbbr: function(dt) { return parseInt(d3.time.format("%a")(dt)); },
    monthName:    d3.time.format("%B"),
    monthInYear:  function(dt) { return parseInt(d3.time.format("%m")(dt)) - 1; },
    dateFormat:   d3.time.format("%Y-%m-%d"),
    cellSize:     8,
    gutterWidth:  6,
    numMonths:    4,
    buildMonth:   function(date) {
                    var _self = this;
                    
                    var color = d3.scale.quantize()
                        .domain([-0.05, .05])
                        .range(d3.range(11).map(function(n) { return "q"+ n +"-11"; }));

                    var svg = d3.select("#calendar").selectAll("svg")
                        .data(d3.range(date.getMonth(), date.getMonth() + this.numMonths))
                        .enter().append("svg")
                            .attr("width", (this.cellSize * 7 + this.gutterWidth))
                            .attr("height", this.cellSize * 6 + 14)
                            .attr("class", "RdYlGn")
                            .append("g")
                                .attr("transform", "translate(0, 12)");

                    svg.append("text")
                        .attr("transform", "translate("+ (this.cellSize * 7 + this.gutterWidth) / 2 +",-3)")
                        .style("text-anchor", "middle")
                        .style("font-style", "italic")
                        .style("font-size", "8px")
                        .style("text-transform", "lowercase")
                        .attr("fill", "#aaa")
                        .text(function(d) { 
                          var dt = d > 11 
                              ? new Date(date.getFullYear() + 1, d - 12, 1)
                              : new Date(date.getFullYear(), d, 1);
                          return _self.monthName(dt);
                        });

                    var rect = svg.selectAll(".day")
                        .data(function(d) { 
                          var year = d > 11 ? date.getFullYear() + 1 : date.getFullYear();
                          var month = d > 11 ? d - 12 : d;
                          var start = new Date(year, month, 1);
                          var end = new Date(year, month + 1, 1);
                          return d3.time.days(start, end);
                        })
                        .enter().append("rect")
                            .attr("class", "day")
                            .attr("width", this.cellSize)
                            .attr("height", this.cellSize)
                            .attr("x", function(d) { 
                              var monthIndex = d.getMonth() - date.getMonth();
                              if(monthIndex < 0) { monthIndex = monthIndex + 11; }
                              return (_self.weekday(d) * _self.cellSize);
                            })
                            .attr("y", function(d) { 
                              var dayOffset = _self.weekInMonth(d) * _self.cellSize;
                              return dayOffset; 
                            })
                            .datum(this.dateFormat);

                    rect.append("title").text(function(d) { return d; });

                    var data = { 
                        '2013-05-14': { type: 'Initial Evaluation' },
                        '2013-05-28': { type: 'Appointment' },
                        '2013-06-05': { type: 'Appointment', status: 'Canceled' },
                        '2013-06-07': { type: 'Phone Appointment' },
                        '2013-06-19': { type: 'Appointment' },
                        '2013-07-03': { type: 'Appointment' },
                        '2013-07-17': { type: 'Appointment', status: 'Pending' },
                        '2013-07-31': { type: 'Appointment', status: 'Pending' }
                    };
//                      d3.csv(dataPath, function(error, csv) {
//                        var data = d3.nest()
//                            .key(function(d) { return d.Date; })
//                            .rollup(function(d) {
//                              return (d[0].Close - d[0].Open) / d[0].Open;
//                            })
//                            .map(csv);
//
                     rect.filter(function(d) { return d in data; })
                         .attr("class", function(d) { return "day "+ color(data[d]); })
                         .select("title")
                         .text(function(d) { return d +": "+ _self.percent(data[d]); });
//                      });
                  },
    version:      '0.0.1'
  };

  var today = new Date();
  var dt = new Date(today.getFullYear(), today.getMonth() - 2, today.getDate());
  calendarViz.buildMonth(dt);
});


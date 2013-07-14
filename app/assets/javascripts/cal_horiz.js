var calendarVis = null;
$(document).ready(function() {
  calendarViz = {
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
    dateFormat:   d3.time.format("%m/%d/%Y"),
    cellSize:     8,
    gutterWidth:  6,
    numMonths:    4,
    buildMonth:   function(date, json) {
                    var _self = this;
                    console.log(json);
                    
                    var color = d3.scale.quantize()
                        .domain(['Occurred', 'Pending', 'Canceled', null])
                        .range(['status-occurred', 'status-pending', 'status-canceled', 'status-unknown']);

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
                            .attr("class", function(d) { 
                              var clazz = "day"
                              if(json[d] != undefined) {
                                clazz = clazz +" "+ color(json[d].status);
                              }
                              return clazz; 
                            })
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
                    rect.filter(function(d) { 
                         return d in json; 
                       })
                       .attr("class", function(d) { 
                         return "day day-"+ json[d].status; 
                       })
                       .select("title")
                       .text(function(d) { 
                         return d +": "+ json[d].type; 
                       });
                  },
    version:      '0.0.1'
  };

});


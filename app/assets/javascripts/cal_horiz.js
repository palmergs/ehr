$(document).ready(function() {
  var calendarViz = {
    percent:      d3.format(".1%"),
    weekday:      function(dt) { return parseInt(d3.time.format("%w")(dt)); },
    dayInMonth:   function(dt) { return parseInt(d3.time.format("%d")(dt)); },
    weekInYear:   function(dt) { return parseInt(d3.time.format("%U")(dt)); },
    weekInMonth:  function(dt) { 
                    var md = this.dayInMonth(dt);
                    var wk = Math.floor(md / 7);
                    if(!this.monthStartSunday(dt)) {
                      if(this.weekday(dt) < (md % 7)) { wk = wk + 1; }
                    } else if(this.weekday(dt) == 6) {
                      wk = wk - 1;
                    }
                    return wk;
                  },
    dayOfWeekAbbr: function(dt) { return parseInt(d3.time.format("%a")(dt)); },
    monthName:    d3.time.format("%B"),
    monthInYear:  function(dt) { return parseInt(d3.time.format("%m")(dt)) - 1; },
    monthStartSunday: function(dt) {
                    var firstDay = new Date(dt.getFullYear(), dt.getMonth(), 1);
                    return this.dayOfWeekAbbr(firstDay) == 'Sun';
                  },
    dateFormat:   d3.time.format("%Y-%m-%d"),
    numColumns:   4,
    cellSize:     8,
    canvasHeight: function() { return (12 / this.numColumns) * this.cellSize * 7; },
    canvasWidth:  function() { return (this.numColumns * 90); },
    monthPath:    function(t0) {
                    var t1 = new Date(t0.getFullYear(), t0.getMonth() + 1, 0),
                        d0 = +this.weekday(t0), w0 = +this.weekInYear(t0),
                        d1 = +this.weekday(t1), w1 = +this.weekInYear(t1);
                    return "M" + (w0 + 1) * this.cellSize + "," + d0 * this.cellSize
                        + "H" + w0 * this.cellSize + "V" + 7 * this.cellSize
                        + "H" + w1 * this.cellSize + "V" + (d1 + 1) * this.cellSize
                        + "H" + (w1 + 1) * this.cellSize + "V" + 0
                        + "H" + (w0 + 1) * this.cellSize + "Z";
                  },
    buildMonth:   function(date, numMonths) {
                    var _self = this;
                    
                    var color = d3.scale.quantize()
                        .domain([-0.05, .05])
                        .range(d3.range(11).map(function(n) { return "q"+ n +"-11"; }));

                    var svg = d3.select("#calendar").selectAll("svg")
                        .data(d3.range(date.getMonth(), date.getMonth() + numMonths))
                        .enter().append("svg")
                            .attr("width", (this.cellSize * 7 + 12) * numMonths)
                            .attr("height", this.cellSize * 6 + 12)
                            .append("g")
                                .attr("transform", "translate(0, 10)");

                    svg.append("text")
                        .attr("transform", "translate("+ (this.cellSize * 7 + 2) / 2 +",2)")
                        .style("text-anchor", "middle")
                        .style("font-style", "italic")
                        .style("font-size", "8px")
                        .style("text-transform", "lowercase")
                        .attr("fill", "#aaa")
                        .text(function(d) { 
                          var dt = d > 11 
                              ? new Date(date.getFullYear() + 1, d - 11, 1)
                              : new Date(date.getFullYear(), d, 1);
                          return _self.monthName(dt);
                        });

                    var rect = svg.selectAll(".day")
                        .data(function(d) { 
                          var startMonth = new Date(date.getFullYear(), date.getMonth(), 1);
                          var endMonth = new Date(date.getFullYear(), date.getMonth() + numMonths, 1);
                          console.log("start="+ startMonth +" end="+ endMonth);
                          return d3.time.days(startMonth, endMonth);
                        })
                        .enter().append("rect")
                            .attr("class", "day")
                            .attr("width", this.cellSize)
                            .attr("height", this.cellSize)
                            .attr("x", function(d) { 
                              var monthIndex = d.getMonth() - date.getMonth();
                              if(monthIndex < 0) { monthIndex = monthIndex + 11; }
                              return (_self.weekday(d) * _self.cellSize) + (monthIndex * (_self.cellSize * 7 + 12)); 
                            })
                            .attr("y", function(d) { 
                              var dayOffset = _self.weekInMonth(d) * _self.cellSize;
                              return dayOffset; 
                            })
                            .datum(this.dateFormat);

                    rect.append("title").text(function(d) { return d; });
                  },
    build:        function(dataPath) {
                    var _self = this;
                    // map values from -0.05 to 0.05 to 10 classes from q0-11 to q10-11
                    var color = d3.scale.quantize()
                        .domain([-.05, .05])
                        .range(d3.range(11).map(function(n) { return "q"+ n +"-11"; }));

                    var svg = d3.select("#calendar").selectAll("svg")
                        .data(d3.range(1990, 2011))
                        .enter().append("svg")
                            .attr("width", this.canvasWidth())
                            .attr("height", this.canvasHeight())
                            .attr("class", "RdYlGn")
                            .append("g")
                                .attr("transform", "translate("+ 
                                    ((this.canvasWidth() - this.cellSize * 53) / 2) 
                                    +","+ 
                                    (this.canvasHeight() - this.cellSize * 7 - 1) + ")");

                    svg.append("text")
                        .attr("transform", "tranlate(-6,"+ this.cellSize * 2 +")rotate(-90)")
                        .style("text-anchor", "middle")
                        .text(function(d) { return d; });

                    var rect = svg.selectAll(".day")
                        .data(function(d) { return d3.time.days(new Date(d, 0, 1), new Date(d+1, 0, 1)); })
                        .enter().append("rect")
                            .attr("class", "day")
                            .attr("width", this.cellSize)
                            .attr("height", this.cellSize)
                            .attr("x", function(d) {
                              var monthOffset = _self.monthInYear(d) * _self.cellSize * 8;
                              return monthOffset + (_self.weekday(d) * _self.cellSize);
                            })
                            .attr("y", function(d) {
                              var monthOffset = Math.floor(_self.monthInYear(d) / _self.numColumns) * _self.cellSize * 6.5;
                              var weekOffset = (_self.weekInMonth(d) * _self.cellSize);
                              return monthOffset + weekOffset;
                            })
                            .datum(this.dateFormat);

                      rect.append("title").text(function(d) { return d; });

                      d3.csv(dataPath, function(error, csv) {
                        var data = d3.nest()
                            .key(function(d) { return d.Date; })
                            .rollup(function(d) {
                              return (d[0].Close - d[0].Open) / d[0].Open;
                            })
                            .map(csv);

                        rect.filter(function(d) { return d in data; })
                            .attr("class", function(d) { return "day "+ color(data[d]); })
                            .select("title")
                                .text(function(d) { return d +": "+ _self.percent(data[d]); });
                      });
                  },
    version:      '0.0.1'
  };

  calendarViz.buildMonth(new Date(2013, 10, 6), 4);
});


//= require_tree .
formatDigits = function(number, type) {
  return type + number.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,');
};
setOnChangeListner = function(fields, ranges, slider){
  $('#'+fields[0]).on('select.editable-select', function(e){
    max = $('#'+fields[1]);
    if(max.val() == 'Any'){
      max = ranges[1];
    }
    else{
      max = parseFloat(max.val().replace(/\$/g,''));
    }
    min = $('#'+fields[0]);
    if(min.val() == 'Any'){
      min = ranges[0]
    }else{
      min = parseFloat(this.value.replace(/\$/g,''))
    }
    slider.setValue([min, max], false, false);
  });

  $('#'+fields[1]).on('select.editable-select', function (e) {
    if(this.value == 'Any'){
      max = ranges[1]
    }else{
      max = parseFloat(this.value.replace(/\$/g,''))
    }
    min = $('#', fields[0]);
    if(min.val() == 'Any'){
      min = ranges[0]
    }else{
      min = parseFloat($('#'+fields[0]).val().replace(/\$/g,''))
    }
    slider.setValue([min, max], false, false);
  });

  $('#'+fields[0]).on("input", function(e){
    max = $('#'+fields[1]);
    if(max.val() == 'Any' || max.val() == ''){
      max = ranges[1];
    }
    else{
      max = parseFloat(max.val().replace(/\$/g,''));
    }
    if(this.value == 'Any' || this.value == ''){
      min = ranges[0];
    }else{
      min = parseFloat(this.value.replace(/\$/g,''));
    }
    slider.setValue([min, max], false, false);
  });

  $('#'+fields[1]).on("input", function(e){
    if(this.value == 'Any' || this.value == ''){
      max = ranges[1]
    }else{
      max = parseFloat(this.value.replace(/\$/g,''))
    }
    min = $('#'+fields[0]);
    if(min.val() == 'Any' || min.val() == ''){
      min = ranges[0];
    }else{
      min = parseFloat(min.val().replace(/\$/g,''));
    }
    slider.setValue([min, max], false, false);
  });
}
setSlider = function(selectors, ranges, options, sliderField){
  if(options['selector']){
    $('#'+selectors[0]).editableSelect({filter: options['suggestions']});
    $('#'+selectors[1]).editableSelect({filter: options['suggestions']});
  }
  if ($('#'+selectors[1]).val() == options['value'][1]){
    slideValue = ranges[1];
  }
  else{
    slideValue = $('#'+selectors[1]).val();
  }
  if ($('#'+selectors[0]).val() == options['value'][0]){
    slideMinValue = ranges[0];
  }
  else{
    slideMinValue = $('#'+selectors[0]).val();
  }
  mySlider = new Slider('#'+sliderField, {
    id: 'slider12c',
    min: parseFloat(ranges[0]),
    max: parseFloat(ranges[1]),
    range: true,
    value: [parseFloat(slideMinValue.replace('$', '')), parseFloat(slideValue.replace('$', ''))],
    tooltip: 'hide'
  }).on('slide', function(ev) {
      $('#'+selectors[0]).text(formatDigits(ev[0], options['type']));
      $('#'+selectors[0]).val(formatDigits(ev[0], options['type']));
      $('#'+selectors[1]).text(formatDigits(ev[1], options['type']));
      $('#'+selectors[1]).val(formatDigits(ev[1], options['type']));
      if( ev[0] <= ranges[0] ){
        $('#'+selectors[0]).val(options['value'][0]);
      }
      if( ev[1] >= ranges[1] ){
        $('#'+selectors[1]).val(options['value'][1]);
      }
  }).on('slideStop', function(ev) {
      $('#'+selectors[0]).text(formatDigits(ev[0], options['type']));
      $('#'+selectors[0]).val(formatDigits(ev[0], options['type']));
      $('#'+selectors[1]).text(formatDigits(ev[1], options['type']));
      $('#'+selectors[1]).val(formatDigits(ev[1], options['type']));
      if( ev[0] <= ranges[0]){
        $('#'+selectors[0]).val(options['value'][0]);
      }
      if( ev[1] >= ranges[1]){
        $('#'+selectors[1]).val(options['value'][1]);
      }
  });
  setOnChangeListner(selectors, ranges, mySlider);
}
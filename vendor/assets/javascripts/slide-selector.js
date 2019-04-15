//= require_tree .
formatDigits = function(number, type) {
  return type + number.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,');
};
focusListner = function(class_name, type, range){
  $(class_name).focusin(function() {
    var price_new;
    price_new = $(class_name).val().replace(/[$,]/g, '');
    $(class_name).val(price_new);
  }).focusout(function() {
    if ($(class_name).val() != 'Any'){
      var price_new;
      price_new = $(class_name).val().replace(/[$,]/g, '');
      if (price_new == ""){
        $(class_name).val(formatDigits(parseFloat(range), type));
        $(class_name).trigger("input");
      }else{
        $(class_name).val(formatDigits(parseFloat(price_new), type));
      }
    }
  });
}
setOnChangeListner = function(fields, ranges, slider){
  $('#'+fields[0]).on('select.editable-select', function(e){
    max = $('#'+fields[1]);
    if(max.val() == 'Any'){
      max = ranges[1];
    }
    else{
      max = parseFloat(max.val().replace(/[$,]/g, ''));
    }
    min = $('#'+fields[0]);
    if(min.val() == 'Any'){
      min = ranges[0]
    }else{
      min = parseFloat(this.value.replace(/[$,]/g, ''))
    }
    slider.setValue([min, max], false, false);
  });

  $('#'+fields[1]).on('select.editable-select', function (e) {
    if(this.value == 'Any'){
      max = ranges[1]
    }else{
      max = parseFloat(this.value.replace(/[$,]/g, ''))
    }
    min = $('#', fields[0]);
    if(min.val() == 'Any'){
      min = ranges[0]
    }else{
      min = parseFloat($('#'+fields[0]).val().replace(/[$,]/g, ''))
    }
    slider.setValue([min, max], false, false);
  });

  $('#'+fields[0]).on("input", function(e){
    max = $('#'+fields[1]);
    if(max.val() == 'Any' || max.val() == ''){
      max = ranges[1];
    }
    else{
      max = parseFloat(max.val().replace(/[$,]/g, ''));
    }
    if(this.value == 'Any' || this.value == ''){
      min = ranges[0];
    }else{
      min = parseFloat(this.value.replace(/[$,]/g, ''));
    }
    slider.setValue([min, max], false, false);
  });

  $('#'+fields[1]).on("input", function(e){
    if(this.value == 'Any' || this.value == ''){
      max = ranges[1]
    }else{
      max = parseFloat(this.value.replace(/[$,]/g, ''))
    }
    min = $('#'+fields[0]);
    if(min.val() == 'Any' || min.val() == ''){
      min = ranges[0];
    }else{
      min = parseFloat(min.val().replace(/[$,]/g, ''));
    }
    slider.setValue([min, max], false, false);
  });
}
setSlider = function(selectors, ranges, options, sliderField){
  if(options['selector']){
    $('#'+selectors[0]).editableSelect({filter: options['suggestions']});
    $('#'+selectors[1]).editableSelect({filter: options['suggestions']});
  }
  slideMinValue = $('#'+selectors[0]);
  if(slideMinValue.val() == ""){
    slideMinValue.val(ranges[0]);
  }
  slideValue = $('#'+selectors[1]);
  if(slideValue.val() == ""){
    slideValue.val(ranges[1]);
  }
  sliderRange = [parseFloat(slideMinValue.val().replace(/[$,]/g, '')), parseFloat(slideValue.val().replace(/[$,]/g, ''))];
  console.log(sliderRange);
  mySlider = new Slider('#'+sliderField, {
    id: 'slider12c',
    min: parseFloat(ranges[0]),
    max: parseFloat(ranges[1]),
    range: true,
    value: sliderRange,
    tooltip: 'hide'
  }).on('slide', function(ev) {
      $('#'+selectors[0]).text(formatDigits(ev[0], options['type']));
      $('#'+selectors[0]).val(formatDigits(ev[0], options['type']));
      $('#'+selectors[1]).text(formatDigits(ev[1], options['type']));
      $('#'+selectors[1]).val(formatDigits(ev[1], options['type']));
  }).on('slideStop', function(ev) {
      $('#'+selectors[0]).text(formatDigits(ev[0], options['type']));
      $('#'+selectors[0]).val(formatDigits(ev[0], options['type']));
      $('#'+selectors[1]).text(formatDigits(ev[1], options['type']));
      $('#'+selectors[1]).val(formatDigits(ev[1], options['type']));
  });
  focusListner('#'+selectors[0], options['type'], ranges[0]);
  focusListner('#'+selectors[1], options['type'], ranges[1]);
  $('#'+selectors[0]).blur();
  $('#'+selectors[1]).blur();
  setOnChangeListner(selectors, ranges, mySlider);
}
module Slide
  module Selector
    module Helpers
      module HelperMethods
        def slide_selector_tag(selectors, ranges, select_options, options = {})
          options[:suggestions] = false if options[:suggestions].nil?
          options[:slider_step] = 1 if options[:slider_step].nil?
          options[:value] = [select_options.keys.first, select_options.keys.last] if options[:value].nil?
          options[:type] = options[:type] == 'amount' ? '$' : ''
          options[:selector] = true if options[:selector].nil?
          selectors = selectors.map &:to_s
          "<div data-slide-selector=true data-options='{\"suggestions\": #{options[:suggestions]}, \"selector\": #{options[:selector]}, \"type\": \"#{options[:type]}\"}' >".html_safe+
          (if options[:selector]
            select_tag(selectors[0], options_for_select(select_options), value: options[:value][0])
          else
            text_field_tag(selectors[0], nil, value: options[:value][0])
          end)+
          text_field_tag(selectors[0]+'_'+selectors[1], nil, data: {'slider-step': options[:slider_step], 'slide-range': ranges.map(&:to_s)})+
          (if options[:selector]
            select_tag(selectors[1], options_for_select(select_options), value: options[:value][1])
          else
            text_field_tag(selectors[1], nil, value: options[:value][1])
          end)+
          "</div>".html_safe
        end
      end
    end
  end
end
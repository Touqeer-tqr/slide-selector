require "slide/selector/core/version"

module Slide
  module Selector
    class Engine < ::Rails::Engine
      class ActionView::Helpers::FormBuilder
        include ActionView::Helpers::TagHelper
        include ActionView::Helpers::FormTagHelper
        include ActionView::Helpers::FormOptionsHelper
        include ActionView::Helpers::CaptureHelper
        include ActionView::Helpers::AssetTagHelper
        def slide_selector(selectors, ranges, select_options, options = {})
          options[:suggestions] = false if options[:suggestions].nil?
          options[:slider_step] = 1 if options[:slider_step].nil?
          options[:selector] = true if options[:selector].nil?
          options[:type] = options[:type] == 'amount' ? '$' : ''
          selectors = selectors.map &:to_s
          get_select_field = lambda { |selector, select_type, value = nil|
            result = self.hidden_field(selector)
            if result.include?('value') || value.present?
              result = Hash.from_xml(result)['input']
              selected = value.present? ? {value => value} : {result['value'] => result['value']}
              return self.select(selector, options_for_select(select_options.merge(selected), selected.to_a.last))
            else
              selected = select_type == 'min' ? select_options.first : select_options.to_a.last
              return self.select(selector, options_for_select(select_options, selected))
            end
          }
          "<div class='#{options[:class]}' data-slide-selector=true data-options='{\"suggestions\": #{options[:suggestions]}, \"selector\": #{options[:selector]}, \"type\": \"#{options[:type]}\"}' >".html_safe+
          (if options[:selector]
            get_select_field.call(selectors[0], 'min', (options[:value][0] if options[:value].present?))
          elsif options[:value].present?
            self.text_field(selectors[0], value: options[:value][0])
          else
            self.text_field(selectors[0])
          end)+
          text_field_tag(selectors[0]+'_'+selectors[1], nil, data: {'slider-step': options[:slider_step], 'slide-range': ranges.map(&:to_s)})+
          (if options[:selector]
            get_select_field.call(selectors[1], 'max', (options[:value][1] if options[:value].present?))
          elsif options[:value].present?
            self.text_field(selectors[1], value: options[:value][1])
          else
            self.text_field(selectors[1])
          end)+
          "</div>".html_safe
        end
      end
    end
    ActiveSupport.on_load :action_view do
      require "slide/selector/helpers/helper_methods"
      ::ActionView::Base.send :include, Helpers::HelperMethods
    end
  end
end
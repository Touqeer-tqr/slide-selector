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
          options[:value] = [select_options.keys.first, select_options.keys.last] if options[:value].nil? && options[:selector]
          options[:type] = options[:type] == 'amount' ? '$' : ''
          selectors = selectors.map &:to_s
          get_select_field = lambda { |selector, select_type|
            result = self.hidden_field(selector)
            if result.include?('value') 
              result = Hash.from_xml(result)['input']
              selected = {result['value'] => result['value']}
              return self.select(selector, options_for_select(select_options.merge(selected), selected.to_a.last))
            else
              selected = select_type == 'min' ? select_options.first : select_options.to_a.last
              return self.select(selector, options_for_select(select_options, selected))
            end
          }
          (if options[:selector]
            get_select_field.call(selectors[0], 'min')
          else
            self.text_field(selectors[0])
          end)+
          text_field_tag(selectors[0]+'_'+selectors[1], nil, data: {'slider-step': options[:slider_step]})+
          (if options[:selector]
            get_select_field.call(selectors[1], 'max')
          else
            self.text_field(selectors[1])
          end)+
          generate_script(selectors, ranges, options).html_safe
        end
        def generate_script(selectors, ranges, options)
          return <<-SCRIPT
            <script type='text/javascript'>
              setSlider(#{selectors.map{ |field_name| object_name.to_s+'_'+field_name.to_s}}, #{ranges.map(&:to_s)}, #{options.to_json}, '#{selectors[0]+'_'+selectors[1]}')
            </script>
          SCRIPT
        end
      end
    end
    ActiveSupport.on_load :action_view do
      require "slide/selector/helpers/helper_methods"
      ::ActionView::Base.send :include, Helpers::HelperMethods
    end
  end
end
require "slide/selector/version"

module Slide
  module Selector
    class Engine < ::Rails::Engine
      class ActionView::Helpers::FormBuilder
        # http://stackoverflow.com/a/2625727/1935918
        # https://github.com/indrimuska/jquery-editable-select
        # https://github.com/seiyria/bootstrap-slider
        include ActionView::Helpers::TagHelper
        include ActionView::Helpers::FormTagHelper
        include ActionView::Helpers::FormOptionsHelper
        include ActionView::Helpers::CaptureHelper
        include ActionView::Helpers::AssetTagHelper
        def range_selector(selectors, ranges, select_options, options = {})
          options[:suggestions] = false if options[:suggestions].nil?
          options[:slider_step] = 1 if options[:slider_step].nil?
          options[:value] = [select_options.keys.first, select_options.keys.last] if options[:value].nil?
          options[:type] = options[:type] == 'amount' ? '$' : ''
          options[:selector] = true if options[:selector].nil?
          selectors = selectors.map &:to_s
          (if options[:selector]
            select_tag(selectors[0], options_for_select(select_options), value: options[:value][0])
          else
            text_field_tag(selectors[0], nil, value: options[:value][0])
          end)+
          text_field_tag(selectors[0]+'_'+selectors[1], nil, data: {'slider-step': options[:slider_step]})+
          (if options[:selector]
            select_tag(selectors[1], options_for_select(select_options), value: options[:value][1])
          else
            text_field_tag(selectors[1], nil, value: options[:value][1])
          end)+
          generate_script(selectors, ranges, options).html_safe
        end

        private
        def generate_script(selectors, ranges, options)
          return <<-SCRIPT
            <script type='text/javascript'>
              setSlider(#{selectors.map(&:to_s)}, #{ranges.map(&:to_s)}, #{options.to_json}, '#{selectors[0]+'_'+selectors[1]}')
            </script>
          SCRIPT
        end
      end
    end
  end
end

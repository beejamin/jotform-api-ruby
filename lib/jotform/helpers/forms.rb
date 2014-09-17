module JotForm
  module Helpers
    def render_form(form)
      capture_haml do
        haml_tag :form, {:method => 'post', :action => form.submission_url, :'accept-charset' => 'utf-8'} do |f|
          haml_tag :input, {:type => 'hidden', :name => 'formID', :value => form.id}
          haml_tag :div, {:class => 'form-structure'} do |h|
            render_questions(form)
          end
          haml_tag :input, {:type => 'hidden', :name => 'website', :value => ""}
          haml_tag :input, {:type => 'hidden', :name => 'simple_spc', :value => "#{form.id}-#{form.id}"}
        end
      end
    end

    def render_questions(form)
      form.questions.each do |question|

        type_class      = input_type(question)
        required_class  = 'required'  if question[:required]
        size_class      = 'short'     if question[:size].to_i < 6

        haml_tag :div, {:class => "field #{type_class} #{size_class} #{required_class}", :id => "field_#{question[:name]}"} do |h|
          if input_type(question) == 'checkbox' or input_type(question) == 'radio'
            render_input(question)
            render_label(question)
          else
            render_label(question)
            render_input(question)
          end
        end
      end
    end

    def input_type(question)
      case question[:type]
      when 'control_textbox'  then 'text'
      when 'control_dropdown' then 'select'
      when 'control_button'   then 'button'
      when 'control_textarea' then 'textarea'
      when 'control_checkbox' then 'checkbox'
      when 'control_radio'    then 'radio'
      when 'control_datetime' then 'datetime'
      end
    end

    def render_label(question)
      label_class = question[:subLabel].blank? ? '' : 'with-note'
      case input_type(question)
      when 'checkbox', 'radio'
        haml_tag :label, {:class => label_class, :for => "input_#{question[:qid]}"} do |h|
          haml_concat question[:options]
          haml_tag :span, question[:subLabel], {:class => 'note'} unless question[:subLabel].blank?
        end
      else
        unless input_type(question) == 'button'
          haml_tag :label, {:class => label_class, :for => "input_#{question[:qid]}"} do |h|
            haml_concat question[:text]
            haml_tag :span, question[:subLabel], {:class => 'note'} unless question[:subLabel].blank?
          end

          unless question[:hint].blank?
            haml_tag :label, {:class => 'hint', :for => "input_#{question[:qid]}"} do |h|
              haml_concat question[:hint]
            end
          end
        end
      end
    end

    def render_input(question)
      case input_type(question)
      when 'select'
        haml_tag :select, {:name => "q#{question[:qid]}_#{question[:name]}", :id => "input_#{question[:qid]}"} do |h|
          haml_tag :option, ' '
          question[:options].split('|').each do |o|
            haml_tag :option, o, {:value => o}
          end
        end
      when 'button'
        haml_tag :button, question[:text], {:type => 'submit', :id => "input_#{question[:qid]}"}
      when 'textarea'
        haml_tag :textarea, {:name => "q#{question[:qid]}_#{question[:name]}", :id => "input_#{question[:qid]}"}
      when 'checkbox'
        haml_tag :input, {:type => 'checkbox', :name => "q#{question[:qid]}_#{question[:name]}", :id => "input_#{question[:qid]}", :value => question[:options]}
      when 'radio'
        haml_tag :input, {:type => 'radio', :name => "q#{question[:qid]}_#{question[:name]}", :id => "input_#{question[:qid]}", :value => question[:options]}
      when 'datetime'
        haml_tag :input, {:type => 'date', :name => "q#{question[:qid]}_#{question[:name]}", :id => "input_#{question[:qid]}"}
      else
        haml_tag :input, {:type => 'text', :name => "q#{question[:qid]}_#{question[:name]}", :id => "input_#{question[:qid]}"}
      end
    end

  end #Helpers
end #::JotForm
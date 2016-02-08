# encoding: utf-8

#  Copyright (c) 2008-2016, Puzzle ITC GmbH. This file is part of
#  Cryptopus and licensed under the Affero General Public License version 3 or later.
#  See the COPYING file at the top-level directory or at
#  https://github.com/puzzle/cryptopus.

module ApplicationHelper

  def tooltip(content, options = {}, html_options = {}, *parameters_for_method_reference)
    html_options[:title] = options[:tooltip]
    html_options[:class] = html_options[:class] || 'tooltip'
    content_tag("span", content, html_options)
  end

  def render_menu
    unless @menu_to_render.nil?
      render(:partial => @menu_to_render)
    end
  end



  def nav_link(name, path)
    class_name = current_page?(path) ? 'active' : ''

    content_tag(:li, class: class_name) do
      link_to(name, path)
    end
  end

  def link_to_destroy(path, entry)
    entry_label = entry.label
    entry_class = entry.class.name.downcase
    label_key = "#{entry_class.pluralize}.confirm.delete"

    confirm = t(label_key, entry_class: entry_class, entry_label: entry_label, default: t("confirm.delete"))
    link_to image_tag("remove.svg"),
            path, data:{confirm: confirm},
            method: :delete
  end

  def labeled_check_box(f, attr, enabled = true)
    options = {}
    options[:disabled] = 'disabled' unless enabled
    label_tag(attr) do
      concat f.check_box(attr, options)
      concat t(".#{attr.to_s}")
    end
  end

  def current_translations
    @translations ||= I18n.backend.send(:translations)
    @translations[I18n.locale].with_indifferent_access
  end

  private
  def default_field_options
    {class: 'form-control'}
  end

end

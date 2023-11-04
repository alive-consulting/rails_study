module ApplicationHelper

  # awesome-fontアイコン
  def icon_tag(name)
    tag.i(class: "fas fa-fw fa-#{name}", style: 'aria-hidden: true')
  end    

end

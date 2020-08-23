module ApplicationHelper
  def format_card_text(description)
    if description.size > 100
      description = description[0..100] + '...'
    end
    description
  end

  def format_status(status)
    hash = {'New' => 'bg-blue text-white',
           'Blocked' => 'bg-red text-white',
           'In progress' => 'bg-purple text-white',
           'Fixed' => 'bg-green text-white'}

    "<span class='badge badge-pill #{hash[status]}'>#{status}</span>".html_safe
  end

  def format_tags(tags_arr)
    tags = tags_arr.map do |tag|
      tag.name
    end

    tags.join(', ')
  end

  def random_class_bg
    ['bg-blue text-white', 'bg-red text-white', 'bg-purple text-white', 'bg-green text-white', 'bg-orange text-white', 'bg-lilac text-white', 'bg-pink text-white', 'bg-yellow text-white'].sample
  end
end

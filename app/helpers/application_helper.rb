module ApplicationHelper
  def admin?
    if current_user.nil?
      false
    else
      current_user.admin
    end
  end

  def perm?(category,status, uid=current_user.id)
    if category.id == cat_main(category)
      perm = category.permissions.find_by(:user_id => uid) 
      if perm.nil?
        false
      else
        perm.status == status
      end
    else
      true
    end

  end


  def cat_main(category)
    if category.parent.name == 'root'
      category.id
    else
      cat_main(category.parent)
    end
  end

end

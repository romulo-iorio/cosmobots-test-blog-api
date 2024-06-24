class PostPolicy  < ApplicationPolicy
    def update?
        is_same_user? || current_user.is_admin?
    end

    def destroy?
        is_same_user? || current_user.is_admin?
    end

    private
        def is_same_user?
            puts(@post)
            @post.user_id == current_user.id
        end
end
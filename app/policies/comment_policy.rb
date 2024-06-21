class CommentPolicy  < ApplicationPolicy
    def update?
        comment.user == user || user.is_admin?
    end

    def destroy?
        comment.user == user || user.is_admin?
    end
end
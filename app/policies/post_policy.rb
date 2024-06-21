class PostPolicy  < ApplicationPolicy
    def update?
        post.user == user || user.is_admin?
    end

    def destroy?
        post.user == user || user.is_admin?
    end
end
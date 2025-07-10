# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

AdminUser.create!(email: 'admin@admin.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

AgeGroup.create([
  { name: "Kids", min_age: 0, max_age: 12 },
  { name: "Teens", min_age: 13, max_age: 17 },
  { name: "Adults", min_age: 18, max_age: 100 }
])

# Create an Organization
organization = Organization.find_or_create_by!(name: "Sample Organization") do |org|
  org.description = "A sample organization for testing access control and content filtering."
end

# Create sample Contents
contents = [
  { title: "Kids Movie", description: "A fun movie for kids.", content_rating: "G", organization_id: organization.id },
  { title: "Teen Adventure", description: "An exciting adventure for teens.", content_rating: "PG-13", organization_id: organization.id },
  { title: "Adult Drama", description: "A mature drama for adults.", content_rating: "R", organization_id: organization.id }
]

contents.each do |content_attrs|
  Content.find_or_create_by!(title: content_attrs[:title]) do |content|
    content.assign_attributes(content_attrs)
  end
end

if User.any? && !OrganizationMembership.exists?(user: User.first, organization: organization)
  OrganizationMembership.create!(user: User.first, organization: organization, role: "member")
end
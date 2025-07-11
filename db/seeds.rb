# seeds.rb file


# Create AdminUser for development
if Rails.env.development?
  AdminUser.find_or_create_by!(email: 'admin@admin.com') do |admin|
    admin.password = 'password'
    admin.password_confirmation = 'password'
  end
end

# Create Age Groups
AgeGroup.find_or_create_by!(name: "Kids") do |ag|
  ag.min_age = 0
  ag.max_age = 12
end

AgeGroup.find_or_create_by!(name: "Teens") do |ag|
  ag.min_age = 13
  ag.max_age = 17
end

AgeGroup.find_or_create_by!(name: "Adults") do |ag|
  ag.min_age = 18
  ag.max_age = 100
end

# Create One Main Organization
puts "🏢 Creating organization..."
organization = Organization.find_or_create_by!(name: "Educational Learning Center") do |org|
  org.description = "A comprehensive educational platform with age-appropriate content for kids, teens, and adults."
end

# Create Content for Different Age Groups
puts "📚 Creating age-specific content..."

# Clear existing content for this organization
organization.contents.destroy_all

# KIDS CONTENT (G-rated only) - What kids can see
kids_content = [
  {
    title: "ABC Learning Songs",
    description: "Fun alphabet songs with colorful animations to help children learn their ABCs through music and rhythm.",
    content_rating: "G"
  },
  {
    title: "Counting with Animals",
    description: "Learn numbers 1-10 with friendly farm animals in this interactive counting adventure.",
    content_rating: "G"
  }
]

# TEEN CONTENT (PG-13) - What teens can see (plus all G content above)
teen_content = [
  {
    title: "Introduction to Programming",
    description: "Learn basic coding concepts with Python through fun projects and interactive challenges.",
    content_rating: "PG-13"
  },
  {
    title: "Science Lab Experiments",
    description: "Exciting chemistry and physics experiments that demonstrate scientific principles safely at home.",
    content_rating: "PG-13"
  }
]

# ADULT CONTENT (R-rated) - What adults can see (plus all G and PG-13 content above)
adult_content = [
  {
    title: "Advanced Financial Planning",
    description: "Comprehensive investment strategies, retirement planning, and wealth management for financial independence.",
    content_rating: "R"
  },
  {
    title: "Business Leadership & Management",
    description: "Advanced management techniques, leadership psychology, and strategic business decision-making.",
    content_rating: "R"
  }
]

# Create all content
all_content = kids_content + teen_content + adult_content

all_content.each do |content_attrs|
  Content.find_or_create_by!(title: content_attrs[:title]) do |content|
    content.description = content_attrs[:description]
    content.content_rating = content_attrs[:content_rating]
    content.organization = organization
  end
end

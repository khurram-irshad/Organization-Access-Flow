# Organization Access Flow

A Rails application for organization-based access control and age-based participation rules. Features include user registration with age verification, content filtering by age group, admin and member roles, and parental consent for minors.

## Setup
1. Install dependencies:
   \`\`\`bash
   bundle install
   \`\`\`
2. Set up the database:
   \`\`\`bash
   rails db:setup
   \`\`\`
3. Run the server:
   \`\`\`bash
   rails server
   \`\`\`

## Features
- User registration with date of birth and parental consent for minors
- Age-based content filtering (G for Kids, G/PG-13 for Teens, all for Adults)
- Admin dashboard via ActiveAdmin
- Analytics for organization access

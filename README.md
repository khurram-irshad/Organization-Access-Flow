# Organization Access Flow

A Rails application for organization-based access control and age-based participation rules. Users can join organizations and access age-appropriate content based on their age group.

## Features

- **User Registration** with age verification
- **Age-Based Content Filtering**: 
  - Kids (under 13): G-rated content only
  - Teens (13-17): G and PG-13 content
  - Adults (18+): All content (G, PG-13, R)
- **Parental Consent** workflow for users under 13
- **Organization Management** with admin and member roles
- **Analytics Dashboard** for organization administrators

## Setup

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd organization_access_flow
   ```

2. **Install dependencies**
   ```bash
   bundle install
   ```

3. **Set up the database**
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
   ```

4. **Start the server**
   ```bash
   rails server
   ```

5. **Visit the application**
   ```
   http://localhost:8000
   ```

## Test Users

After running `rails db:seed`, you can test with different age groups:

- Create users with different birthdates to test age-based access
- Users under 13 will need parental consent approval
- Join the "Educational Learning Center" organization to see content

## Technologies Used

- Ruby on Rails 8.0
- PostgreSQL
- Devise (Authentication)
- Pundit (Authorization)
- Rolify (Role Management)
- Turbo Rails (Page Accelaration)
- Stimulus (javascript Framework)
- Propshaft (Asset Pipeline)
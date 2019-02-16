require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride
use BookClubController
use LogsController
use MeetingsController
use UsersController
use UserMeetingssController
run ApplicationController
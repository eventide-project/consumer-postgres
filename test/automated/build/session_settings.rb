require_relative '../automated_init'

context "Build" do
  context "Session Settings Argument" do
    category = Controls::Category.example

    session_settings = ::MessageStore::Postgres::Settings.instance

    context "Argument Is A Session" do
      consumer = Controls::Consumer::Example.build(category, session_settings: session_settings)

      session = consumer.session

      test "Constructs a session from the session settings" do
        assert(session.host == session_settings.get(:host))
      end
    end

    context "Argument Is A Data Source" do
      settings_data = session_settings.data

      consumer = Controls::Consumer::Example.build(category, session_settings: settings_data)

      session = consumer.session

      test "Constructs a session from the settings data source" do
        assert(session.host == settings_data['host'])
      end
    end
  end
end

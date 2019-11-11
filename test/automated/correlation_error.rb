require_relative './automated_init'

context "Correlation Error" do
  category = Controls::Category.example

  context "Correlation is a Stream Rather than a Category" do
    correlation = Controls::StreamName.example

    test "Is an error" do
      assert_raises MessageStore::Correlation::Error do

        Actor::Supervisor.start do
          Controls::Consumer::Example.start(
            category,
            correlation: correlation
          )
        end

      end
    end
  end
end

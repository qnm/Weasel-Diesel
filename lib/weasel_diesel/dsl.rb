# Extending the top level module to add some helpers
#
# @api public
class WeaselDiesel
  module DSL
    private

    # Base DSL method called to describe a service
    #
    # @param [String] url The url of the service to add.
    # @yield [WeaselDiesel] The newly created service.
    # @return [Array] The services already defined
    # @example Describing a basic service
    #   describe_service "hello-world.xml" do |service|
    #     # describe the service
    #   end
    #
    # @api public
    def describe_service(url, &block)
      service = WeaselDiesel.new(url)
      yield service

      service.sync_input_param_doc
      WSList.add(service)

      service
    end

  end
end

# Extend the main object with the DSL methods. This allows top-level calls
# without polluting the object inheritance tree.
self.extend WeaselDiesel::DSL
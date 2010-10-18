module RiCal
  class Component
    class Calendar < Component
      
      def tz_info_source? #:nodoc:
        @tz_source == 'TZINFO' || timezones.empty?
      end
    end
  end
end

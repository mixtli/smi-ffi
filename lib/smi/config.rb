module Smi
  class Config
    class << self
      def init(name = nil)
        Wrapper.smiInit(name)
      end
      
      def exit
        Wrapper.smiExit
      end
      
      def error_level=(level)
        Wrapper.smiSetErrorLevel(level)
      end
      def get_path
        Wrapper.smiGetPath()
      end
      
      def get_flags
        Wrapper.smiGetFlags()
      end
      
      def set_flags(flags)
        Wrapper.smiSetFlags(flags)
      end
      
      def load_module(m)
        Wrapper.smiLoadModule(m)
      end
      
      def is_loaded?(m)
        Wrapper.smiIsLoaded(m)
      end
      
      def set_path(p)
        Wrapper.smiSetPath(p)
      end
      
      def set_severity(pattern, severity)
        Wrapper.smiSetSeverity(pattern, severity)
      end
      
      def read_config(filename, tag)
        Wrapper.smiReadConfig(filename, tag)
      end
      
      def set_error_handler(&block)
        Wrapper.smiSetErrorHandler(block)
      end

    end
  end
end

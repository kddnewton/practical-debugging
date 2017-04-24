GCRuns =
  Struct.new(:minor, :major) do
    def self.build
      new(*GC.stat.values_at(:minor_gc_count, :major_gc_count))
    end

    def -(other)
      new(minor - other.minor, major - other.major)
    end
  end

GC.start



#!/usr/bin/env ruby

require_relative './.loader'

SIMPLE_TIMES = 10_000
CACHED_TIMES = 10_000

def random_payload
  DataGenerator.instance.random_payload
end

def generate_data
  DataGenerator.instance.generate
end

def drop_data
  DataGenerator.instance.drop
end
drop_data # ensure all data are empty

Benchmark.bmbm(20) do |x|

  x.report("data generation") { generate_data }

  x.report("simple example") do
    SIMPLE_TIMES.times do
      SimpleExample.instance.create_message random_payload
    end
  end

  x.report("cached example") do
    CacheExample.instance.generate_cache

    CACHED_TIMES.times do
      CacheExample.instance.create_message random_payload
    end
  end

  x.report("data drop") { drop_data }

end

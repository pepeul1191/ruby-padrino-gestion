threads_count_min = ENV.fetch("RAILS_MAX_THREADS") { 0 }.to_i
threads_count_max = ENV.fetch("RAILS_MAX_THREADS") { 20 }.to_i
threads threads_count_min, threads_count_max

port        ENV.fetch("PORT") { 3000 }

environment ENV.fetch("RAILS_ENV") { "development" }

workers ENV.fetch("WEB_CONCURRENCY") { 5 }

plugin :tmp_restart

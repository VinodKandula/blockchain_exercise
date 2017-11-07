Thread.abort_on_exception = true

def every(seconds, random_max_sleep=0)
  Thread.new do
    r = Random.new(Time.now.to_i)
    loop do
      random_sleep = random_max_sleep > 0 ? r.rand(random_max_sleep) : 0
      sleep seconds + random_sleep
      yield
    end
  end
end

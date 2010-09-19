module StatsHelper
  def browser_count(browser)
      h @browsercounts[browser] || "0"
  end
  
  def os_count(os)
      h @oscounts[os] || "0"
  end
end

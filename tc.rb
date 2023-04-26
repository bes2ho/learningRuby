def time_calc()
    # start_time = ARGV.shift
    m_total, s_total = ARGV.shift.split('.').map(&:to_i)
    h_total = 0
    count = 1
    puts sprintf("%d\t%02d:%02d:%02d", count, h_total, m_total, s_total)
    count +=1

    while play_time = ARGV.shift
        m, s = play_time.split('.').map(&:to_i)
        h_total, s_total = (h_total*3600 + (m_total + m)*60 + s_total + s).divmod(3600)
        m_total, s_total = s_total.divmod(60)
        puts sprintf("%d\t%02d:%02d:%02d.0", count, h_total, m_total, s_total)
        count +=1
    end
end

puts "empty" if ARGV.empty?
time_calc()

class Bob
  def hey(remark)
    @remark = remark
    if yelled_at?
      'Whoa, chill out!'
    elsif asked_question?
      'Sure.'
    elsif getting_silent_treatment?
      'Fine. Be that way!'
    else
      'Whatever.'
    end
  end

  private

  def yelled_at?
    @remark =~ /[A-Z]/ && @remark.upcase == @remark
  end

  def asked_question?
    @remark.end_with?('?')
  end

  def getting_silent_treatment?
    @remark.strip.empty?
  end
end

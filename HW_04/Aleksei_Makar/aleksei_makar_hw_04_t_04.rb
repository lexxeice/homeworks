def task_4_4(string)
  return false unless string.class == String

  string.downcase == string.downcase.reverse
end

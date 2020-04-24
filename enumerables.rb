module Enumerable
  # rubocop:disable Style/For
  
  def new_method
  end
  
  def my_each
    return to_enum(:my_each) unless block_given?

    for i in 0...size
      yield(to_a[i])
    end
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    for i in 0...size
      yield(to_a[i], i)
    end
    nil
  end

  # rubocop:enable Style/For
  def my_select
    return to_enum(:my_select) unless block_given?

    res = []
    my_each do |x|
      res.append(x) if yield(x)
    end
    res
  end

  # rubocop: disable Style/CaseEquality, Style/IfInsideElse
  def my_all?(args = nil)
    res = true
    my_each do |x|
      if block_given?
        res = false unless yield(x)
      elsif !args
        res = false unless x
      else
        res = false unless args === x
      end
    end
    res
  end

  def my_any?(args = nil)
    res = false
    my_each do |x|
      if block_given?
        res = true if yield(x)
      elsif !args
        res = true if x
      else
        res = true if args === x
      end
    end
    res
  end

  def my_none?(args = nil)
    res = true
    my_each do |x|
      if block_given?
        res = false if yield(x)
      elsif !args
        res = false if x
      else
        res = false if args === x
      end
    end
    res
  end

  # rubocop: enable Style/CaseEquality, Style/IfInsideElse
  def my_count(args = nil)
    mcount = 0
    if block_given?
      my_each { |x| mcount += 1 if yield(x) }
    else
      return size if args.nil?

      if args
        my_each { |x| mcount += 1 if x == args }
      end
    end
    mcount
  end

  def my_map(args = nil)
    return to_enum(:my_map) unless block_given?

    res = []
    if args
      my_each { |x| res.append(args.call(x)) }
    else
      my_each { |x| res.append(yield(x)) }
    end
    res
  end

  def my_inject(*args) # rubocop:disable Metrics/CyclomaticComplexity
    res = args[0] if args[0].is_a?(Integer)
    operator = args[0].is_a?(Symbol) ? args[0] : args[1]
    li = is_a?(Range) ? to_a : self
    if operator

      li.my_each { |item| res = res ? res.send(operator, item) : item }
      return res
    end
    my_each { |item| res = res ? yield(res, item) : item }

    res
  end
end

def multiply_els(arr)
  arr.my_inject(:*)
end

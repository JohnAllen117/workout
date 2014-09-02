class Workout
  attr_accessor :id, :date, :type, :duration, :calories_burned

  def initialize(id, date, exercises)
    @id = id
    @date = date
    @exercises = exercises
    @type = get_type(@exercises)
    @duration = calc_time(@exercises)
    @calories_burned = calc_calories(@exercises)
  end

  def get_type(exercises)
    cardio_count = 0
    strength_count = 0
    other_count = 0
    exercises.each do |set|
      if set[:category] == "cardio"
        cardio_count += 1
      elsif set[:category] == "strength"
        strength_count += 1
      else
        other_count += 1
      end
    end
    total_workouts = cardio_count + strength_count
    cardio_percent = cardio_count / total_workouts.to_f
    strength_percent = strength_count / total_workouts.to_f
    if cardio_percent >= 0.5
      return "cardio"
    elsif strength_percent >= 0.5
      return "strength"
    else
      "other"
    end
  end

  def calc_time(exercises)
    duration = 0.0
    exercises.each do |set|
      duration += set[:duration_in_min]
    end
    duration
  end
  def calc_calories(exercises)
    calories = 0.0
    exercises.each do |set|
      if set[:category] == "cardio" && set[:intensity] == "high"
        calories += (10 * set[:duration_in_min])
      elsif set[:category] == "cardio" && set[:intensity] == "medium"
        calories += (8 * set[:duration_in_min])
      elsif set[:intensity] == "low"
        calories += (5 * set[:duration_in_min])
      else
        calories += (6 * set[:duration_in_min])
      end
    end
    calories
  end
end

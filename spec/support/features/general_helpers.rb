module Features
  module GeneralHelpers
    def ensure_on(path)
      visit(path) unless current_path == path
    end
  end
end
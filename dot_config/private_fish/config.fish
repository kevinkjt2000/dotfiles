if type -q direnv
  eval (direnv hook fish)
end

if type -q starship
  starship init fish | source
end

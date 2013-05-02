class TeamKind < ClassyEnum::Base
end

class TeamKind::Staging < TeamKind
end

class TeamKind::Base < TeamKind
end

class TeamKind::Field < TeamKind
end

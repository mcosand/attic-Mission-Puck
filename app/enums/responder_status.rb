class ResponderStatus < ClassyEnum::Base
end

class ResponderStatus::Unknown < ResponderStatus
end

class ResponderStatus::Activated < ResponderStatus
end

class ResponderStatus::Enroute < ResponderStatus
end

class ResponderStatus::Signedin < ResponderStatus
end

class ResponderStatus::Assigned < ResponderStatus
end

class ResponderStatus::Unavailable < ResponderStatus
end

class ResponderStatus::Signedout < ResponderStatus
end

class ResponderStatus::Cleared < ResponderStatus
end

"""
    boundary_check(initxy, dx, dy) -> Tuple{Array{Float64,1}, String}

Confirm the next coordinates after initxy with unit displacement vectors dx, dy.

Resolve collisions with escape boundaries, sensors, and walls.
"""
function boundary_check(initxy::Array{Float64,1}, dx::Float64, dy::Float64)
    proposedxy, endinglayer = evaluate_proposed(initxy, dx, dy)
    initx, inity = initxy
    propx, propy = proposedxy
    endingstepsize = STEP_SIZE_DICT[ endinglayer ]

    if inwalls(propx, propy)
        return wallcases(initxy, dx, dy, endingstepsize)
    elseif !inescapebounds(propx, propy)
        return undef, "escape"
    elseif insensor(proposedxy)
        return undef, sensorcases(initx)
    else
        return proposedxy, "no collision"
    end
end

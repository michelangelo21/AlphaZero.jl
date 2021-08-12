# One action, random +1/-1 observation, one timestep long, obs-dependent +1/-1 reward every time: 
#If my agent can learn the value in (1.) but not this one - meaning it can learn a constant 
#reward but not a predictable one! - it must be that backpropagation through my network is broken. 
import AlphaZero.GI

struct GameSpec <: GI.AbstractGameSpec end

mutable struct GameEnv <: GI.AbstractGameEnv 
  terminated :: Bool
end

const INITSTATE = (; terminated=false)

GI.init(::GameSpec, state=INITSTATE) = GameEnv(state.terminated)

GI.spec(::GameEnv) = GameSpec()

GI.two_players(::GameSpec) = false


const ACTIONS = collect(1:1)

GI.actions(::GameSpec) = ACTIONS

GI.actions_mask(g::GameEnv) = [true]

GI.current_state(g::GameEnv) = (; terminated=g.terminated)

GI.white_playing(g::GameEnv) = true

GI.game_terminated(g::GameEnv) = g.terminated

GI.white_reward(g::GameEnv) = rand([-1.,1.])

function GI.play!(g::GameEnv, action)
  g.terminated = true
end

GI.vectorize_state(::GameSpec, state) = Float32[!state.terminated]
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

play_types = [
    {
        code: 'goal', name: 'Goal'
    }, {
        code: 'corner', name: 'Corner Kick'
    }, {
        code: 'yellow', name: 'Yellow Card'
    }, {
        code: 'red', name: 'Red Card'
    }, {
        code: 'offside', name: 'Offside'
    }, {
        code: 'foul', name: 'Foul'
    }, {
        code: 'pen', name: 'Penalty'
    }, {
        code: 'sub', name: 'Substitution'
    }, {
        code: 'var', name: 'V.A.R.'
    }
]
PlayType.create(play_types)
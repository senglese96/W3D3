# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
c = User.create(email: 'stupidstuff@whocares.com')
d = User.create(email: 'holycowwhy@ohno.com')
e = User.create(email: 'fakeristheshiznit@skt.org')

ShortenedUrl.destroy_all
f = ShortenedUrl.create_short_url(c, 'antidisestablishmentarianismisbad.com')
g = ShortenedUrl.create_short_url(e, 'riceeggschickenspoonhelpimtrappedinaconveniencestoreneartheseaisels.com')

Visit.destroy_all
v = Visit.record_visit!(d, g)
w = Visit.record_visit!(c, f)
x = Visit.record_visit!(d, g)
y = Visit.record_visit!(e, f)
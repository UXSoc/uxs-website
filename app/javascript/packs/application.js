import '../application.scss'
import Rails from 'rails-ujs'
import Turbolinks from 'turbolinks'
import { fab } from '@fortawesome/free-brands-svg-icons'
import { library, dom } from '@fortawesome/fontawesome-svg-core'
import { far } from '@fortawesome/free-regular-svg-icons'
import { fas } from '@fortawesome/free-solid-svg-icons'
import { Application } from 'stimulus'
import { definitionsFromContext } from 'stimulus/webpack-helpers'

const application = Application.start()
const context = require.context('./controllers', true, /\.js$/)

Rails.start()
Turbolinks.start()
application.load(definitionsFromContext(context))

document.addEventListener('turbolinks:load', () => {
  library.add(fab, far, fas)
  dom.i2svg()
})

// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import DayFocusController from "./day_focus_controller"
application.register("day-focus", DayFocusController)

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import NavbarController from "./navbar_controller"
application.register("navbar", NavbarController)

import SlimSelectController from "./slim_select_controller"
application.register("slim-select", SlimSelectController)

import TomSelectController from "./tom_select_controller"
application.register("tom-select", TomSelectController)

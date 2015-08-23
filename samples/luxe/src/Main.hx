
import luxe.Input;

import hxgamejolt.GameJolt;


class Main extends luxe.Game {

    override function config(config:luxe.AppConfig) {

        return config;

    } //config

    override function ready() {

        GameJolt.init({
            
        });

    } //ready

    override function onkeyup( e:KeyEvent ) {

        if(e.keycode == Key.escape) {
            Luxe.shutdown();
        }

    } //onkeyup

    override function update(dt:Float) {

    } //update


} //Main

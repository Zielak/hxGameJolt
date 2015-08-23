
import haxe.io.Bytes;
import haxe.io.BytesData;
import luxe.Input;

import hxgamejolt.GameJolt;

class Main extends luxe.Game {

    override function config(config:luxe.AppConfig) {

        return config;

    } //config

    override function ready() {


        var keystring = KeyPrivate.key; // This converts the ByteArray to a string.
        var gameid = 87950; // Replace it with your game ID, visible if you go to http://gamejolt.com/dashboard/ -> Click on your game under "Manage Games" -> Click on "Game API" in the menu and "API Settings".

        GameJolt.init({
            GameID: gameid,
            PrivateKey: keystring,
        });
        GameJolt.authUser('zielak', '0471f3', authorized);

    } //ready

    override function onkeyup( e:KeyEvent ) {

        if(e.keycode == Key.escape) {
            Luxe.shutdown();
        }

    } //onkeyup

    override function update(dt:Float) {

    } //update







    function authorized(data:Dynamic) {
        
    }

} //Main


import haxe.io.Bytes;
import haxe.io.BytesData;

import hxgamejolt.GameJolt;

import luxe.Input;
import luxe.Text;
import luxe.Color;

import mint.Button;
import mint.Canvas;
import mint.TextEdit;
import mint.Window;
import mint.render.luxe.LuxeMintRender;
import mint.render.luxe.Convert;

class Main extends luxe.Game {


    var rendering: LuxeMintRender;
    var canvas: Canvas;


    var login_window: Window;
    var text_user: TextEdit;
    var text_token: TextEdit;
    var login_btn: Button;
    var cancel_btn: Button;



    var trophies_window: Window;
    var trophies_list: mint.List;

    override function config(config:luxe.AppConfig) {

        return config;

    } //config

    override function ready() {

        init_login_ui();

        var keystring = KeyPrivate.key; // This converts the ByteArray to a string.
        var gameid = 87950; // Replace it with your game ID, visible if you go to http://gamejolt.com/dashboard/ -> Click on your game under "Manage Games" -> Click on "Game API" in the menu and "API Settings".

        GameJolt.init({
            GameID: gameid,
            PrivateKey: keystring,
        });

    } //ready



    override function onrender() {

        canvas.render();

    } // onrender

    override function update(dt:Float) {

        canvas.update(dt);

    } //update

    override function onmousemove(e) {
        canvas.mousemove( Convert.mouse_event(e) );
    } //onmousemove

    override function onmousewheel(e) {
        canvas.mousewheel( Convert.mouse_event(e) );
    }

    override function onmouseup(e) {
        canvas.mouseup( Convert.mouse_event(e) );
    }

    override function onmousedown(e) {
        canvas.mousedown( Convert.mouse_event(e) );
    }

    override function onkeydown(e:luxe.Input.KeyEvent) {
        canvas.keydown( Convert.key_event(e) );

        if(e.keycode == Key.key_i){
            GameJolt.fetchAvatarImage( function(data){ trace('fetchAvatarImage: ${data}'); } );
        }
    }

    override function ontextinput(e:luxe.Input.TextEvent) {
        canvas.textinput( Convert.text_event(e) );
    }


    override function onkeyup(e:luxe.Input.KeyEvent) {

        canvas.keyup( Convert.key_event(e) );

        if(e.keycode == Key.escape) {
            Luxe.shutdown();
        }

    } //onkeyup





    function init_login_ui() {

        var w_w:Float = 256;
        var w_h:Float = 150;

        rendering = new LuxeMintRender();

        canvas = new mint.Canvas({
            name:'canvas',
            rendering: rendering,
            options: { color:new Color(1,1,1,0.0) },
            x: 0, y:0, w: 960, h: 640
        });

        login_window = new mint.Window({
            parent: canvas,
            name: 'window',
            title: 'Login to GameJolt',
            options: {
                color:new Color().rgb(0x121212),
                color_titlebar:new Color().rgb(0x191919),
                label: { color:new Color().rgb(0x06b4fb) },
                close_button: { color:new Color().rgb(0x06b4fb) },
            },
            x:Luxe.screen.w/2 - w_w/2, y:Luxe.screen.h/2 - w_h/2, w:w_w, h: w_h,
            w_min: w_w, h_min:w_h,
            collapsible: false,
            moveable: false,
        });

        text_user = new mint.TextEdit({
            parent: login_window, name: 'text_user', text: 'zielak', renderable: true,
            x: 10, y:32, w: w_w - 20 , h: 26,
            text_size: 18,
        });

        text_token = new mint.TextEdit({
            parent: login_window, name: 'text_token', text: 'whatever', renderable: true,
            x: 10, y: 64, w: w_w - 20, h: 26,
            text_size: 18,
            display_char: '#',
        });

        login_btn = new mint.Button({
            parent: login_window, name: 'login_btn', text: 'LOGIN', renderable: true,
            x: 10, y: 100, w: w_w*0.65-20, h: 36, text_size: 18,
            options: { label: { color:new Color().rgb(0xCBFE00) } },
            onclick: function(e,c) {
                GameJolt.authUser(text_user.text, text_token.text, authorized);
                login_btn.visible = false;
                cancel_btn.visible = false;
                trace('e = ${e}');
            }
        });

        cancel_btn = new mint.Button({
            parent: login_window, name: 'cancel_btn', text: 'cancel', renderable: true,
            x: 20+login_btn.w, y: 100, w: w_w*0.35-10, h: 36, text_size: 18,
            options: { label: { color:new Color().rgb(0x9dca63) } },
            onclick: function(e,c) {
                login_window.close();
            }
        });

    }



    function init_trophies_ui() {

        trophies_window = new Window({
            parent: canvas,
            name: 'trophies_window',
            title: 'Trophies',
            options: {
                color:new Color().rgb(0x121600),
                color_titlebar:new Color().rgb(0x191919),
                label: { color:new Color().rgb(0xFBBF06) },
                close_button: { color:new Color().rgb(0xFBBF06) },
            },
            x:Luxe.screen.w/4, y:Luxe.screen.h/2 - 400/2, w:200, h: 400,
            w_min: 200, h_min:100,
            collapsible: false,
            moveable: true,
        });


        trophies_list = new mint.List({
            parent: trophies_window,
            name: 'trophies_list',
            options: { view: { color:new Color().rgb(0x19191c) } },
            x: 1, y: 30, w: 198, h: 300
        });


        GameJolt.fetchTrophy( GameJolt.TROPHIES_MISSING, add_trophies );


    }

    function add_trophies(data:Dynamic) {
        
        trace(data);
        trace('got Trophies?');

    }

    function authorized(data:Dynamic) {
        trace('authorized: ${data}');
        if(data == true){
            login_window.close();
            init_trophies_ui();
        }else{
            login_btn.visible = true;
            cancel_btn.visible = true;
        }
    }

} //Main

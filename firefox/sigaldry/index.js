// Use a custom new tab page.  Mostly adapted from snippets taken from these sources:
// http://git.agenedia.com/firefox-add-ons/newtaboverride/blob/master/src/index.js
// http://sidhant.io/bling-blink-blink/
// https://github.com/TigerKid001/Blink/blob/master/data/js/NewTabSetter.js
(function() {
   /* Get the URL to the start page.  This method is obviously bad:
   const newTabPage = 'file:///home/casi/dotfiles/startpage/index.html';
    * This one works but the whole page needs to be packaged with the add-on inside the
    * `data` subdirectory:
   const self = require('sdk/self');
   const newTabPage = self.data.url('index.html');
    * This method should be okay: */
   const url    = require('sdk/url');
   const system = require('sdk/system');
   const {join} = require('sdk/io/file');
   // const home = system.env.HOME;
   const home = system.pathFor('Home');
   const newTabPage = url.fromFilename(join(home, 'dotfiles', 'startpage', 'index.html'));
   // console.log(newTabPage);

   // TODO: just use the home page that can be set in the Firefox preferences as the new
   // tab page (`browser.startup.homepage`)?

   // Override the URL loaded in new tabs.
   const newTabUrl = require('resource:///modules/NewTabURL.jsm').NewTabURL;
   newTabUrl.override(newTabPage);

   // Keep the address bar (also called location bar, URL bar, Awesome Bar, ...) clear
   // when opening the custom new tab page.
   // https://developer.mozilla.org/en-US/Add-ons/SDK/Tutorials/Chrome_Authority
   const {Cc, Ci} = require('chrome');
   const windowMediator = Cc['@mozilla.org/appshell/window-mediator;1']
                          .getService(Ci.nsIWindowMediator);
   let windows = windowMediator.getEnumerator(null);
   while (windows.hasMoreElements()) {
      let window = windows.getNext();
      if (window.gInitialPages.indexOf(newTabPage) == -1)
         window.gInitialPages.push(newTabPage);
   }
})();

// vim: tw=90 sts=-1 sw=3 et

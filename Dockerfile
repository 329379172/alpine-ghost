FROM ghost                                                                                                       
COPY ./fonts.css content/themes/casper/assets/css/fonts.css                                                                                             
COPY ./monokai_sublime.min.css content/themes/casper/assets/css/monokai_sublime.min.css                                                                 
COPY ./highlight.min.js content/themes/casper/assets/js/highlight.min.js                                                                                
COPY ./jquery.min.js content/themes/casper/assets/js/jquery.min.js                                                                                      

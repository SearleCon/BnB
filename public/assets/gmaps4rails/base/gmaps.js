(function(){this.Gmaps={triggerOldOnload:function(){if(typeof window.Gmaps.oldOnload=="function")return window.Gmaps.oldOnload()},loadMaps:function(){var e,t,n,r;n=window.Gmaps,r=[];for(e in n)t=n[e],/^load_/.test(e)?r.push(window.Gmaps[e]()):r.push(void 0);return r}}}).call(this);
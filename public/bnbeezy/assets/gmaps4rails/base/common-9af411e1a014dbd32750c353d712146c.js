(function(){var e,t=[].indexOf||function(e){for(var t=0,n=this.length;t<n;t++)if(t in this&&this[t]===e)return t;return-1};e=["extended","included"],this.Gmaps4Rails={},this.Gmaps4Rails.Common=function(){function n(){}return n.extend=function(n){var r,i,s;for(r in n)i=n[r],t.call(e,r)<0&&(this[r]=i);return(s=n.extended)!=null&&s.apply(this),this},n.include=function(n){var r,i,s;for(r in n)i=n[r],t.call(e,r)<0&&(this.prototype[r]=i);return(s=n.included)!=null&&s.apply(this),this},n.prototype.exists=function(e){return e!==""&&typeof e!="undefined"},n.prototype.mergeObjects=function(e,t){return this.constructor.mergeObjects(e,t)},n.mergeObjects=function(e,t){var n,r,i;n={};for(r in e)i=e[r],n[r]=i;for(r in t)i=t[r],n[r]==null&&(n[r]=i);return n},n.mergeWith=function(e){var t,n,r;r=[];for(t in e)n=e[t],this[t]==null?r.push(this[t]=n):r.push(void 0);return r},n.prototype.random=function(){return Math.random()*2-1},n}()}).call(this);
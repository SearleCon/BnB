(function(){var e,t=[].indexOf||function(e){for(var t=0,n=this.length;t<n;t++)if(t in this&&this[t]===e)return t;return-1};e=["extended","included"],this.Gmaps4Rails={},this.Gmaps4Rails.Common=function(){function n(){}return n.extend=function(n){var r,i,s;for(r in n)i=n[r],t.call(e,r)<0&&(this[r]=i);return(s=n.extended)!=null&&s.apply(this),this},n.include=function(n){var r,i,s;for(r in n)i=n[r],t.call(e,r)<0&&(this.prototype[r]=i);return(s=n.included)!=null&&s.apply(this),this},n.prototype.exists=function(e){return e!==""&&typeof e!="undefined"},n.prototype.mergeObjects=function(e,t){return this.constructor.mergeObjects(e,t)},n.mergeObjects=function(e,t){var n,r,i;n={};for(r in e)i=e[r],n[r]=i;for(r in t)i=t[r],n[r]==null&&(n[r]=i);return n},n.mergeWith=function(e){var t,n,r;r=[];for(t in e)n=e[t],this[t]==null?r.push(this[t]=n):r.push(void 0);return r},n.prototype.random=function(){return Math.random()*2-1},n}()}).call(this),function(){this.Gmaps4Rails.Configuration={setConf:function(){return this.CONF!=null?this.mergeObjects(this.CONF,this.DEFAULT_CONF):this.DEFAULT_CONF}}}.call(this),function(){this.Gmaps={triggerOldOnload:function(){if(typeof window.Gmaps.oldOnload=="function")return window.Gmaps.oldOnload()},loadMaps:function(){var e,t,n,r;n=window.Gmaps,r=[];for(e in n)t=n[e],/^load_/.test(e)?r.push(window.Gmaps[e]()):r.push(void 0);return r}}}.call(this),function(){this.Gmaps4Rails.Circle={},this.Gmaps4Rails.Circle.Class={DEFAULT_CONF:{fillColor:"#00AAFF",fillOpacity:.35,strokeColor:"#FFAA00",strokeOpacity:.8,strokeWeight:2,clickable:!1,zIndex:null}}}.call(this),function(){this.Gmaps4Rails.Kml={},this.Gmaps4Rails.Kml.Instance={DEFAULT_CONF:{clickable:!0,preserveViewport:!1,suppressInfoWindows:!1}}}.call(this),function(){this.Gmaps4Rails.Map={DEFAULT_CONF:{id:"map",draggable:!0,detect_location:!1,center_on_user:!1,center_latitude:0,center_longitude:0,zoom:7,maxZoom:null,minZoom:null,auto_adjust:!0,auto_zoom:!0,bounds:[],raw:{}},adjustToBounds:function(){return this.boundsObject=this.createLatLngBounds(),this.extendBoundsWithMarkers(),this.extendBoundsWithPolylines(),this.extendBoundsWithPolygons(),this.extendBoundsWithCircles(),this.extendBoundsWithLatLng(),this.adaptToBounds()},extendBoundsWithMarkers:function(){var e,t,n,r,i;r=this.controller.markers,i=[];for(t=0,n=r.length;t<n;t++)e=r[t],e.isVisible()?i.push(this.extendBoundsWithMarker(e)):i.push(void 0);return i},extendBoundsWithPolylines:function(){var e,t,n,r,i;r=this.controller.polylines,i=[];for(t=0,n=r.length;t<n;t++)e=r[t],i.push(this.extendBoundsWithPolyline(e));return i},extendBoundsWithPolygons:function(){var e,t,n,r,i;r=this.controller.polygons,i=[];for(t=0,n=r.length;t<n;t++)e=r[t],i.push(this.extendBoundsWithPolygon(e));return i},extendBoundsWithCircles:function(){var e,t,n,r,i;r=this.controller.circles,i=[];for(t=0,n=r.length;t<n;t++)e=r[t],i.push(this.extendBoundsWithCircle(e));return i},extendBoundsWithLatLng:function(){var e,t,n,r,i;r=this.options.bounds,i=[];for(t=0,n=r.length;t<n;t++)e=r[t],i.push(this.extendBound(e));return i},autoAdjustRequested:function(){return this.options.auto_adjust||this.options.bounds.length>0}}}.call(this),function(){this.Gmaps4Rails.Marker={},this.Gmaps4Rails.Marker.Class={DEFAULT_CONF:{title:null,picture:null,width:22,length:32,draggable:!1,do_clustering:!1,randomize:!1,max_random_distance:100,list_container:null,offset:0,raw:{}}},this.Gmaps4Rails.Marker.Instance={getMap:function(){return this.controller.getMapObject()}}}.call(this),function(){this.Gmaps4Rails.Polygon={},this.Gmaps4Rails.Polygon.Class={DEFAULT_CONF:{strokeColor:"#FFAA00",strokeOpacity:.8,strokeWeight:2,fillColor:"#000000",fillOpacity:.35,clickable:!1}}}.call(this),function(){this.Gmaps4Rails.Polyline={},this.Gmaps4Rails.Polyline.Class={DEFAULT_CONF:{strokeColor:"#FF0000",strokeOpacity:1,strokeWeight:2,clickable:!1,zIndex:null,icons:null}}}.call(this),function(){this.Gmaps4Rails.CircleController={addCircles:function(e){var t,n,r,i;i=[];for(n=0,r=e.length;n<r;n++)t=e[n],i.push(this.circles.push(this.createCircle(t)));return i},replaceCircles:function(e){return this.clearCircles(),this.addCircles(e),this.adjustMapToBounds()},clearCircles:function(){var e,t,n,r;r=this.circles;for(t=0,n=r.length;t<n;t++)e=r[t],e.clear();return this.circles=[]},showCircles:function(){var e,t,n,r,i;r=this.circles,i=[];for(t=0,n=r.length;t<n;t++)e=r[t],i.push(e.show());return i},hideCircles:function(){var e,t,n,r,i;r=this.circles,i=[];for(t=0,n=r.length;t<n;t++)e=r[t],i.push(e.hide());return i}}}.call(this),function(){this.Gmaps4Rails.KmlController={addKml:function(e){var t,n,r,i;i=[];for(n=0,r=e.length;n<r;n++)t=e[n],i.push(this.kmls.push(this.createKml(t)));return i}}}.call(this),function(){this.Gmaps4Rails.MarkerController={addMarkers:function(e){var t,n,r,i,s,o,u,a;this.markerClusterer!=null&&this.clearClusterer();for(t=u=0,a=e.length;u<a;t=++u)s=e[t],n=s.lat,i=s.lng,this.markers_conf.randomize&&(r=this.randomize(n,i),n=r[0],i=r[1]),o=this.createMarker({marker_picture:s.picture?s.picture:this.markers_conf.picture,marker_width:s.width?s.width:this.markers_conf.width,marker_height:s.height?s.height:this.markers_conf.length,marker_title:s.title?s.title:null,marker_anchor:s.marker_anchor?s.marker_anchor:null,shadow_anchor:s.shadow_anchor?s.shadow_anchor:null,shadow_picture:s.shadow_picture?s.shadow_picture:null,shadow_width:s.shadow_width?s.shadow_width:null,shadow_height:s.shadow_height?s.shadow_height:null,marker_draggable:s.draggable?s.draggable:this.markers_conf.draggable,rich_marker:s.rich_marker?s.rich_marker:null,zindex:s.zindex?s.zindex:null,lat:n,lng:i,index:t}),Gmaps4Rails.Common.mergeWith.call(o,s),o.createInfoWindow(),this.markers.push(o);return this.clusterize()},replaceMarkers:function(e){return this.clearMarkers(),this.markers=[],this.boundsObject=this.createLatLngBounds(),this.addMarkers(e)},clearMarkers:function(){var e,t,n,r;this.markerClusterer!=null&&this.clearClusterer(),r=this.markers;for(t=0,n=r.length;t<n;t++)e=r[t],e.clear();return this.markers=[]},showMarkers:function(){var e,t,n,r,i;r=this.markers,i=[];for(t=0,n=r.length;t<n;t++)e=r[t],i.push(e.show());return i},hideMarkers:function(){var e,t,n,r,i;r=this.markers,i=[];for(t=0,n=r.length;t<n;t++)e=r[t],i.push(e.hide());return i},randomize:function(e,t){var n,r,i,s;return i=this.markers_conf.max_random_distance*this.random(),s=this.markers_conf.max_random_distance*this.random(),n=parseFloat(e)+180/Math.PI*(s/6378137),r=parseFloat(t)+90/Math.PI*(i/6378137)/Math.cos(e),[n,r]}}}.call(this),function(){this.Gmaps4Rails.PolygonController={addPolygons:function(e){var t,n,r,i;i=[];for(n=0,r=e.length;n<r;n++)t=e[n],i.push(this.polygons.push(this.createPolygon(t)));return i},replacePolygons:function(e){return this.clearPolygons(),this.addPolygons(e),this.adjustMapToBounds()},clearPolygons:function(){var e,t,n,r;r=this.polygons;for(t=0,n=r.length;t<n;t++)e=r[t],e.clear();return this.polygons=[]},showPolygons:function(){var e,t,n,r,i;r=this.polygons,i=[];for(t=0,n=r.length;t<n;t++)e=r[t],i.push(e.show());return i},hidePolygons:function(){var e,t,n,r,i;r=this.polygons,i=[];for(t=0,n=r.length;t<n;t++)e=r[t],i.push(e.hide());return i}}}.call(this),function(){this.Gmaps4Rails.PolylineController={replacePolylines:function(e){return this.clearPolylines(),this.addPolylines(e),this.adjustMapToBounds()},clearPolylines:function(){var e,t,n,r;r=this.polylines;for(t=0,n=r.length;t<n;t++)e=r[t],e.clear();return this.polylines=[]},addPolylines:function(e){var t,n,r,i;i=[];for(n=0,r=e.length;n<r;n++)t=e[n],i.push(this.polylines.push(this.createPolyline(t)));return i},showPolylines:function(){var e,t,n,r,i;r=this.polylines,i=[];for(t=0,n=r.length;t<n;t++)e=r[t],i.push(e.show());return i},hidePolylines:function(){var e,t,n,r,i;r=this.polylines,i=[];for(t=0,n=r.length;t<n;t++)e=r[t],i.push(e.hide());return i}}}.call(this),function(){Gmaps4Rails.Interfaces||(Gmaps4Rails.Interfaces={}),Gmaps4Rails.Interfaces.Basic={clear:function(){throw"clear should be implemented"},show:function(){throw"show should be implemented"},hide:function(){throw"hide should be implemented"},isVisible:function(){throw"hide should be implemented"}}}.call(this),function(){Gmaps4Rails.Interfaces||(Gmaps4Rails.Interfaces={}),Gmaps4Rails.Interfaces.Controller={getModule:function(){throw"getModule should be implemented in controller"},createClusterer:function(e){throw"createClusterer should be implemented in controller"},clearClusterer:function(){throw"clearClusterer should be implemented in controller"}}}.call(this),function(){Gmaps4Rails.Interfaces||(Gmaps4Rails.Interfaces={}),Gmaps4Rails.Interfaces.Map={extendBoundsWithMarker:function(e){throw"extendBoundsWithMarker should be implemented in controller"},extendBoundsWithPolyline:function(e){throw"extendBoundsWithPolyline should be implemented in controller"},extendBoundsWithPolygon:function(e){throw"extendBoundsWithPolygon should be implemented in controller"},extendBoundsWithCircle:function(e){throw"extendBoundsWithCircle should be implemented in controller"},extendBound:function(e){throw"extendBound should be implemented in controller"},adaptToBounds:function(){throw"adaptToBounds should be implemented in controller"},fitBounds:function(){throw"fitBounds should be implemented in controller"},centerMapOnUser:function(e){throw"centerMapOnUser should be implemented in controller"}}}.call(this),function(){Gmaps4Rails.Interfaces||(Gmaps4Rails.Interfaces={}),Gmaps4Rails.Interfaces.Marker={createInfoWindow:function(){throw"createInfoWindow should be implemented in marker"},clear:function(){throw"clear should be implemented in marker"},show:function(){throw"show should be implemented in marker"},hide:function(){throw"hide should be implemented in marker"}}}.call(this),function(){var e={}.hasOwnProperty,t=function(t,n){function i(){this.constructor=t}for(var r in n)e.call(n,r)&&(t[r]=n[r]);return i.prototype=n.prototype,t.prototype=new i,t.__super__=n.prototype,t};this.Gmaps4Rails.BaseController=function(e){function n(){this.rootModule=this.getModule(),this.rootModule.Marker!=null&&(this.markers_conf=this.rootModule.Marker.setConf()),this.rootModule.Polyline!=null&&(this.polylines_conf=this.rootModule.Polyline.setConf()),this.rootModule.Polygon!=null&&(this.polygons_conf=this.rootModule.Polygon.setConf()),this.rootModule.Circle!=null&&(this.circles_conf=this.rootModule.Circle.setConf())}return t(n,e),n.include(Gmaps4Rails.MarkerController),n.include(Gmaps4Rails.PolylineController),n.include(Gmaps4Rails.PolygonController),n.include(Gmaps4Rails.CircleController),n.include(Gmaps4Rails.KmlController),n.include(Gmaps4Rails.Interfaces.Controller),n.prototype.visibleInfoWindow=null,n.prototype.userLocation=null,n.prototype.afterMapInitialization=function(){return!1},n.prototype.geolocationSuccess=function(){return!1},n.prototype.geolocationFailure=function(){return!1},n.prototype.callback=function(){return!1},n.prototype.customClusterer=function(){return!1},n.prototype.infobox=function(){return!1},n.prototype.jsTemplate=!1,n.prototype.map_options={},n.prototype.markers=[],n.prototype.boundsObject=null,n.prototype.polygons=[],n.prototype.polylines=[],n.prototype.circles=[],n.prototype.markerClusterer=null,n.prototype.markerImages=[],n.prototype.kmls=[],n.prototype.rootModule=null,n.prototype.createMap=function(){return new this.rootModule.Map(this.map_options,this)},n.prototype.createMarker=function(e){return new this.rootModule.Marker(e,this)},n.prototype.createPolyline=function(e){return new this.rootModule.Polyline(e,this)},n.prototype.createPolygon=function(e){return new this.rootModule.Polygon(e,this)},n.prototype.createCircle=function(e){return new this.rootModule.Circle(e,this)},n.prototype.createKml=function(e){return new this.rootModule.Kml(e,this)},n.prototype.initialize=function(){var e,t;t=this.map_options.detect_location||this.map_options.center_on_user,e=this.map_options.center_on_user,this.map=this.createMap(),this.afterMapInitialization(),delete this.map_options;if(t)return this.findUserLocation(this,e)},n.prototype.getMapObject=function(){return this.map.serviceObject},n.prototype.adjustMapToBounds=function(){if(this.map.autoAdjustRequested())return this.map.adjustToBounds()},n.prototype.clusterize=function(){var e,t,n,r,i;if(this.markers_conf.do_clustering){this.markerClusterer!=null&&this.clearClusterer(),t=[],i=this.markers;for(n=0,r=i.length;n<r;n++)e=i[n],t.push(e.serviceObject);return this.markerClusterer=this.createClusterer(t)}},n.prototype.findUserLocation=function(e,t){var n,r;return navigator.geolocation?(r=function(n){e.userLocation=e.createLatLng(n.coords.latitude,n.coords.longitude),e.geolocationSuccess();if(t)return e.map.centerMapOnUser(e.userLocation)},n=function(t){return e.geolocationFailure(!0)},navigator.geolocation.getCurrentPosition(r,n)):e.geolocationFailure(!1)},n}(Gmaps4Rails.Common)}.call(this),function(){}.call(this),function(){Gmaps4Rails.Google={},Gmaps4Rails.Google.Shared={createPoint:function(e,t){return new google.maps.Point(e,t)},createSize:function(e,t){return new google.maps.Size(e,t)},createLatLng:function(e,t){return new google.maps.LatLng(e,t)},createLatLngBounds:function(){return new google.maps.LatLngBounds},clear:function(){return this.serviceObject.setMap(null)},show:function(){return this.serviceObject.setVisible(!0)},hide:function(){return this.serviceObject.setVisible(!1)},isVisible:function(){return this.serviceObject.getVisible()}}}.call(this),function(){var e={}.hasOwnProperty,t=function(t,n){function i(){this.constructor=t}for(var r in n)e.call(n,r)&&(t[r]=n[r]);return i.prototype=n.prototype,t.prototype=new i,t.__super__=n.prototype,t};this.Gmaps4Rails.Google.Circle=function(e){function n(e,t){var n,r;this.controller=t,e===this.controller.circles[0]&&(e.strokeColor!=null&&(this.controller.circles_conf.strokeColor=e.strokeColor),e.strokeOpacity!=null&&(this.controller.circles_conf.strokeOpacity=e.strokeOpacity),e.strokeWeight!=null&&(this.controller.circles_conf.strokeWeight=e.strokeWeight),e.fillColor!=null&&(this.controller.circles_conf.fillColor=e.fillColor),e.fillOpacity!=null&&(this.controller.circles_conf.fillOpacity=e.fillOpacity)),e.lat!=null&&e.lng!=null&&(n={center:this.createLatLng(e.lat,e.lng),strokeColor:e.strokeColor||this.controller.circles_conf.strokeColor,strokeOpacity:e.strokeOpacity||this.controller.circles_conf.strokeOpacity,strokeWeight:e.strokeWeight||this.controller.circles_conf.strokeWeight,fillOpacity:e.fillOpacity||this.controller.circles_conf.fillOpacity,fillColor:e.fillColor||this.controller.circles_conf.fillColor,clickable:e.clickable||this.controller.circles_conf.clickable,zIndex:e.zIndex||this.controller.circles_conf.zIndex,radius:e.radius},r=this.mergeObjects(this.controller.circles_conf.raw,n),this.serviceObject=new google.maps.Circle(r),this.serviceObject.setMap(this.controller.getMapObject()))}return t(n,e),n.include(Gmaps4Rails.Interfaces.Basic),n.include(Gmaps4Rails.Google.Shared),n.extend(Gmaps4Rails.Circle.Class),n.extend(Gmaps4Rails.Configuration),n}(Gmaps4Rails.Common)}.call(this),function(){var e={}.hasOwnProperty,t=function(t,n){function i(){this.constructor=t}for(var r in n)e.call(n,r)&&(t[r]=n[r]);return i.prototype=n.prototype,t.prototype=new i,t.__super__=n.prototype,t};this.Gmaps4Rails.Google.Kml=function(e){function n(e,t){var n;this.controller=t,this.options=e.options||{},this.options=this.mergeObjects(this.options,this.DEFAULT_CONF),n=new google.maps.KmlLayer(e.url,this.options),n.setMap(this.controller.getMapObject()),this.serviceObject=n}return t(n,e),n.include(Gmaps4Rails.Interfaces.Basic),n.include(Gmaps4Rails.Google.Shared),n.include(Gmaps4Rails.Kml.Instance),n}(Gmaps4Rails.Common)}.call(this),function(){var e={}.hasOwnProperty,t=function(t,n){function i(){this.constructor=t}for(var r in n)e.call(n,r)&&(t[r]=n[r]);return i.prototype=n.prototype,t.prototype=new i,t.__super__=n.prototype,t};Gmaps4Rails.Google.Map=function(e){function n(e,t){var n,r,i;this.controller=t,n=this.setConf(),this.options=this.mergeObjects(e,n),r={maxZoom:this.options.maxZoom,minZoom:this.options.minZoom,zoom:this.options.zoom,center:this.createLatLng(this.options.center_latitude,this.options.center_longitude),mapTypeId:google.maps.MapTypeId[this.options.type],mapTypeControl:this.options.mapTypeControl,disableDefaultUI:this.options.disableDefaultUI,disableDoubleClickZoom:this.options.disableDoubleClickZoom,draggable:this.options.draggable},i=this.mergeObjects(e.raw,r),this.serviceObject=new google.maps.Map(document.getElementById(this.options.id),i)}return t(n,e),n.include(Gmaps4Rails.Interfaces.Map),n.include(Gmaps4Rails.Map),n.include(Gmaps4Rails.Google.Shared),n.include(Gmaps4Rails.Configuration),n.prototype.CONF={disableDefaultUI:!1,disableDoubleClickZoom:!1,type:"ROADMAP",mapTypeControl:null},n.prototype.extendBoundsWithMarker=function(e){return this.boundsObject.extend(e.serviceObject.position)},n.prototype.extendBoundsWithPolyline=function(e){var t,n,r,i,s;n=e.serviceObject.latLngs.getArray()[0].getArray(),s=[];for(r=0,i=n.length;r<i;r++)t=n[r],s.push(this.boundsObject.extend(t));return s},n.prototype.extendBoundsWithPolygon=function(e){var t,n,r,i,s;n=e.serviceObject.latLngs.getArray()[0].getArray(),s=[];for(r=0,i=n.length;r<i;r++)t=n[r],s.push(this.boundsObject.extend(t));return s},n.prototype.extendBoundsWithCircle=function(e){return this.boundsObject.extend(e.serviceObject.getBounds().getNorthEast()),this.boundsObject.extend(e.serviceObject.getBounds().getSouthWest())},n.prototype.extendBound=function(e){return this.boundsObject.extend(this.createLatLng(e.lat,e.lng))},n.prototype.adaptToBounds=function(){var e;return this.options.auto_zoom?this.fitBounds():(e=this.boundsObject.getCenter(),this.options.center_latitude=e.lat(),this.options.center_longitude=e.lng(),this.serviceObject.setCenter(e))},n.prototype.fitBounds=function(){if(!this.boundsObject.isEmpty())return this.serviceObject.fitBounds(this.boundsObject)},n.prototype.centerMapOnUser=function(e){return this.serviceObject.setCenter(e)},n}(Gmaps4Rails.Common)}.call(this),function(){var e={}.hasOwnProperty,t=function(t,n){function i(){this.constructor=t}for(var r in n)e.call(n,r)&&(t[r]=n[r]);return i.prototype=n.prototype,t.prototype=new i,t.__super__=n.prototype,t};Gmaps4Rails.Google.Marker=function(e){function n(e,t){var n;this.controller=t,n=this.createLatLng(e.lat,e.lng),this._isBasicMarker(e)?this._createBasicMarker(n,e):e.rich_marker!=null?this._createRichMarker(n,e):this._createMarker(n,e)}return t(n,e),n.include(Gmaps4Rails.Interfaces.Marker),n.include(Gmaps4Rails.Google.Shared),n.include(Gmaps4Rails.Marker.Instance),n.extend(Gmaps4Rails.Marker.Class),n.extend(Gmaps4Rails.Configuration),n.CONF={clusterer_gridSize:50,clusterer_maxZoom:5,custom_cluster_pictures:null,custom_infowindow_class:null,raw:{}},n.prototype.createInfoWindow=function(){var e;if(typeof this.controller.jsTemplate=="function"||this.description!=null)return typeof this.controller.jsTemplate=="function"&&(this.description=this.controller.jsTemplate(this)),this.controller.markers_conf.custom_infowindow_class!=null?(e=document.createElement("div"),e.setAttribute("class",this.controller.markers_conf.custom_infowindow_class),e.innerHTML=this.description,this.infowindow=new InfoBox(this.infobox(e)),google.maps.event.addListener(this.serviceObject,"click",this._openInfowindow())):(this.infowindow=new google.maps.InfoWindow({content:this.description}),google.maps.event.addListener(this.serviceObject,"click",this._openInfowindow()))},n.prototype._createBasicMarker=function(e,t){var n,r;return n={position:e,map:this.getMap(),title:t.marker_title,draggable:t.marker_draggable,zIndex:t.zindex},r=this.mergeObjects(this.controller.markers_conf.raw,n),this.serviceObject=new google.maps.Marker(r)},n.prototype._createRichMarker=function(e,t){var n,r;return this.serviceObject=new RichMarker({position:e,map:this.getMap(),draggable:t.marker_draggable,content:t.rich_marker,flat:((n=t.marker_anchor!=null)!=null?n:t.marker_anchor[1])?void 0:!1,anchor:((r=t.marker_anchor!=null)!=null?r:t.marker_anchor[0])?void 0:null,zIndex:t.zindex})},n.prototype._createMarker=function(e,t){var n,r,i,s,o,u;return r=this._createImageAnchorPosition(t.marker_anchor),o=this._createImageAnchorPosition(t.shadow_anchor),i=this._createOrRetrieveImage(t.marker_picture,t.marker_width,t.marker_height,r),u=this._createOrRetrieveImage(t.shadow_picture,t.shadow_width,t.shadow_height,o),n={position:e,map:this.getMap(),icon:i,title:t.marker_title,draggable:t.marker_draggable,shadow:u,zIndex:t.zindex},s=this.mergeObjects(this.controller.markers_conf.raw,n),this.serviceObject=new google.maps.Marker(s)},n.prototype._includeMarkerImage=function(e){var t,n,r,i,s;s=this.controller.markerImages;for(t=r=0,i=s.length;r<i;t=++r){n=s[t];if(n.url===e)return t}return!1},n.prototype._createOrRetrieveImage=function(e,t,n,r){var i,s;return typeof e=="undefined"||e===""||e===null?null:(s=this._includeMarkerImage(e))?typeof s=="number"?this.controller.markerImages[s]:!1:(i=this._createMarkerImage(e,this.createSize(t,n),null,r,null),this.controller.markerImages.push(i),i)},n.prototype._isBasicMarker=function(e){return e.marker_picture==null&&e.rich_marker==null},n.prototype._createMarkerImage=function(e,t,n,r,i){return new google.maps.MarkerImage(e,t,n,r,i)},n.prototype._createImageAnchorPosition=function(e){return e===null?null:this.createPoint(e[0],e[1])},n.prototype._openInfowindow=function(){var e;return e=this,function(){return e.controller._closeVisibleInfoWindow(),e.infowindow.open(e.getMap(),e.serviceObject),e.controller._setVisibleInfoWindow(e.infowindow)}},n}(Gmaps4Rails.Common)}.call(this),function(){var e={}.hasOwnProperty,t=function(t,n){function i(){this.constructor=t}for(var r in n)e.call(n,r)&&(t[r]=n[r]);return i.prototype=n.prototype,t.prototype=new i,t.__super__=n.prototype,t};this.Gmaps4Rails.Google.Polygon=function(e){function n(e,t){var n,r,i,s,o,u,a,f,l,c,h,p,d,v;this.controller=t,f=[];for(d=0,v=e.length;d<v;d++)u=e[d],s=this.createLatLng(u.lat,u.lng),f.push(s),u===e[0]&&(l=u.strokeColor||this.controller.polygons_conf.strokeColor,c=u.strokeOpacity||this.controller.polygons_conf.strokeOpacity,h=u.strokeWeight||this.controller.polygons_conf.strokeWeight,r=u.fillColor||this.controller.polygons_conf.fillColor,i=u.fillOpacity||this.controller.polygons_conf.fillOpacity,n=u.clickable||this.controller.polygons_conf.clickable,p=u.zIndex||this.controller.polygons_conf.zIndex);a={path:f,strokeColor:l,strokeOpacity:c,strokeWeight:h,clickable:n,zIndex:p},o=this.mergeObjects(t.polygons_conf.raw,a),this.serviceObject=new google.maps.Polygon(o),this.serviceObject.setMap(t.getMapObject())}return t(n,e),n.include(Gmaps4Rails.Interfaces.Basic),n.include(Gmaps4Rails.Google.Shared),n.extend(Gmaps4Rails.Polygon.Class),n.extend(Gmaps4Rails.Configuration),n}(Gmaps4Rails.Common)}.call(this),function(){var e={}.hasOwnProperty,t=function(t,n){function i(){this.constructor=t}for(var r in n)e.call(n,r)&&(t[r]=n[r]);return i.prototype=n.prototype,t.prototype=new i,t.__super__=n.prototype,t};this.Gmaps4Rails.Google.Polyline=function(e){function n(e,t){var n,r,i,s,o,u,a,f,l,c,h,p,d,v,m,g;f=[];for(d=0,m=e.length;d<m;d++){i=e[d];if(i.coded_array!=null){r=new google.maps.geometry.encoding.decodePath(i.coded_array);for(v=0,g=r.length;v<g;v++)u=r[v],f.push(u)}else i===e[0]&&(l=i.strokeColor||t.polylines_conf.strokeColor,c=i.strokeOpacity||t.polylines_conf.strokeOpacity,h=i.strokeWeight||t.polylines_conf.strokeWeight,n=i.clickable||t.polylines_conf.clickable,p=i.zIndex||t.polylines_conf.zIndex,s=i.icons||t.polylines_conf.icons),i.lat!=null&&i.lng!=null&&f.push(this.createLatLng(i.lat,i.lng))}a={path:f,strokeColor:l,strokeOpacity:c,strokeWeight:h,clickable:n,zIndex:p,icons:s},o=this.mergeObjects(t.polylines_conf.raw,a),this.serviceObject=new google.maps.Polyline(o),this.serviceObject.setMap(t.getMapObject())}return t(n,e),n.include(Gmaps4Rails.Interfaces.Basic),n.include(Gmaps4Rails.Google.Shared),n.extend(Gmaps4Rails.Polyline.Class),n.extend(Gmaps4Rails.Configuration),n}(Gmaps4Rails.Common)}.call(this),function(){var e={}.hasOwnProperty,t=function(t,n){function i(){this.constructor=t}for(var r in n)e.call(n,r)&&(t[r]=n[r]);return i.prototype=n.prototype,t.prototype=new i,t.__super__=n.prototype,t};this.Gmaps4RailsGoogle=function(e){function n(){n.__super__.constructor.apply(this,arguments),this.markerImages=[]}return t(n,e),n.include(Gmaps4Rails.Google.Shared),n.prototype.getModule=function(){return Gmaps4Rails.Google},n.prototype.createClusterer=function(e){return new MarkerClusterer(this.getMapObject(),e,{maxZoom:this.markers_conf.clusterer_maxZoom,gridSize:this.markers_conf.clusterer_gridSize,styles:this.customClusterer()})},n.prototype.clearClusterer=function(){return this.markerClusterer.clearMarkers()},n.prototype.clusterize=function(){var e,t,n,r,i;if(this.markers_conf.do_clustering){this.markerClusterer!=null&&this.clearClusterer(),t=[],i=this.markers;for(n=0,r=i.length;n<r;n++)e=i[n],t.push(e.serviceObject);return this.markerClusterer=this.createClusterer(t)}},n.prototype._closeVisibleInfoWindow=function(){if(this.visibleInfowindow!=null)return this.visibleInfowindow.close()},n.prototype._setVisibleInfoWindow=function(e){return this.visibleInfowindow=e},n}(Gmaps4Rails.BaseController)}.call(this),function(){}.call(this);
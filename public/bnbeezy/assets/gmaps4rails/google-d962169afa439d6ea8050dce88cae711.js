(function(){Gmaps4Rails.Google={},Gmaps4Rails.Google.Shared={createPoint:function(e,t){return new google.maps.Point(e,t)},createSize:function(e,t){return new google.maps.Size(e,t)},createLatLng:function(e,t){return new google.maps.LatLng(e,t)},createLatLngBounds:function(){return new google.maps.LatLngBounds},clear:function(){return this.serviceObject.setMap(null)},show:function(){return this.serviceObject.setVisible(!0)},hide:function(){return this.serviceObject.setVisible(!1)},isVisible:function(){return this.serviceObject.getVisible()}}}).call(this),function(){var e={}.hasOwnProperty,t=function(t,n){function i(){this.constructor=t}for(var r in n)e.call(n,r)&&(t[r]=n[r]);return i.prototype=n.prototype,t.prototype=new i,t.__super__=n.prototype,t};this.Gmaps4Rails.Google.Circle=function(e){function n(e,t){var n,r;this.controller=t,e===this.controller.circles[0]&&(e.strokeColor!=null&&(this.controller.circles_conf.strokeColor=e.strokeColor),e.strokeOpacity!=null&&(this.controller.circles_conf.strokeOpacity=e.strokeOpacity),e.strokeWeight!=null&&(this.controller.circles_conf.strokeWeight=e.strokeWeight),e.fillColor!=null&&(this.controller.circles_conf.fillColor=e.fillColor),e.fillOpacity!=null&&(this.controller.circles_conf.fillOpacity=e.fillOpacity)),e.lat!=null&&e.lng!=null&&(n={center:this.createLatLng(e.lat,e.lng),strokeColor:e.strokeColor||this.controller.circles_conf.strokeColor,strokeOpacity:e.strokeOpacity||this.controller.circles_conf.strokeOpacity,strokeWeight:e.strokeWeight||this.controller.circles_conf.strokeWeight,fillOpacity:e.fillOpacity||this.controller.circles_conf.fillOpacity,fillColor:e.fillColor||this.controller.circles_conf.fillColor,clickable:e.clickable||this.controller.circles_conf.clickable,zIndex:e.zIndex||this.controller.circles_conf.zIndex,radius:e.radius},r=this.mergeObjects(this.controller.circles_conf.raw,n),this.serviceObject=new google.maps.Circle(r),this.serviceObject.setMap(this.controller.getMapObject()))}return t(n,e),n.include(Gmaps4Rails.Interfaces.Basic),n.include(Gmaps4Rails.Google.Shared),n.extend(Gmaps4Rails.Circle.Class),n.extend(Gmaps4Rails.Configuration),n}(Gmaps4Rails.Common)}.call(this),function(){var e={}.hasOwnProperty,t=function(t,n){function i(){this.constructor=t}for(var r in n)e.call(n,r)&&(t[r]=n[r]);return i.prototype=n.prototype,t.prototype=new i,t.__super__=n.prototype,t};this.Gmaps4Rails.Google.Kml=function(e){function n(e,t){var n;this.controller=t,this.options=e.options||{},this.options=this.mergeObjects(this.options,this.DEFAULT_CONF),n=new google.maps.KmlLayer(e.url,this.options),n.setMap(this.controller.getMapObject()),this.serviceObject=n}return t(n,e),n.include(Gmaps4Rails.Interfaces.Basic),n.include(Gmaps4Rails.Google.Shared),n.include(Gmaps4Rails.Kml.Instance),n}(Gmaps4Rails.Common)}.call(this),function(){var e={}.hasOwnProperty,t=function(t,n){function i(){this.constructor=t}for(var r in n)e.call(n,r)&&(t[r]=n[r]);return i.prototype=n.prototype,t.prototype=new i,t.__super__=n.prototype,t};Gmaps4Rails.Google.Map=function(e){function n(e,t){var n,r,i;this.controller=t,n=this.setConf(),this.options=this.mergeObjects(e,n),r={maxZoom:this.options.maxZoom,minZoom:this.options.minZoom,zoom:this.options.zoom,center:this.createLatLng(this.options.center_latitude,this.options.center_longitude),mapTypeId:google.maps.MapTypeId[this.options.type],mapTypeControl:this.options.mapTypeControl,disableDefaultUI:this.options.disableDefaultUI,disableDoubleClickZoom:this.options.disableDoubleClickZoom,draggable:this.options.draggable},i=this.mergeObjects(e.raw,r),this.serviceObject=new google.maps.Map(document.getElementById(this.options.id),i)}return t(n,e),n.include(Gmaps4Rails.Interfaces.Map),n.include(Gmaps4Rails.Map),n.include(Gmaps4Rails.Google.Shared),n.include(Gmaps4Rails.Configuration),n.prototype.CONF={disableDefaultUI:!1,disableDoubleClickZoom:!1,type:"ROADMAP",mapTypeControl:null},n.prototype.extendBoundsWithMarker=function(e){return this.boundsObject.extend(e.serviceObject.position)},n.prototype.extendBoundsWithPolyline=function(e){var t,n,r,i,s;n=e.serviceObject.latLngs.getArray()[0].getArray(),s=[];for(r=0,i=n.length;r<i;r++)t=n[r],s.push(this.boundsObject.extend(t));return s},n.prototype.extendBoundsWithPolygon=function(e){var t,n,r,i,s;n=e.serviceObject.latLngs.getArray()[0].getArray(),s=[];for(r=0,i=n.length;r<i;r++)t=n[r],s.push(this.boundsObject.extend(t));return s},n.prototype.extendBoundsWithCircle=function(e){return this.boundsObject.extend(e.serviceObject.getBounds().getNorthEast()),this.boundsObject.extend(e.serviceObject.getBounds().getSouthWest())},n.prototype.extendBound=function(e){return this.boundsObject.extend(this.createLatLng(e.lat,e.lng))},n.prototype.adaptToBounds=function(){var e;return this.options.auto_zoom?this.fitBounds():(e=this.boundsObject.getCenter(),this.options.center_latitude=e.lat(),this.options.center_longitude=e.lng(),this.serviceObject.setCenter(e))},n.prototype.fitBounds=function(){if(!this.boundsObject.isEmpty())return this.serviceObject.fitBounds(this.boundsObject)},n.prototype.centerMapOnUser=function(e){return this.serviceObject.setCenter(e)},n}(Gmaps4Rails.Common)}.call(this),function(){var e={}.hasOwnProperty,t=function(t,n){function i(){this.constructor=t}for(var r in n)e.call(n,r)&&(t[r]=n[r]);return i.prototype=n.prototype,t.prototype=new i,t.__super__=n.prototype,t};Gmaps4Rails.Google.Marker=function(e){function n(e,t){var n;this.controller=t,n=this.createLatLng(e.lat,e.lng),this._isBasicMarker(e)?this._createBasicMarker(n,e):e.rich_marker!=null?this._createRichMarker(n,e):this._createMarker(n,e)}return t(n,e),n.include(Gmaps4Rails.Interfaces.Marker),n.include(Gmaps4Rails.Google.Shared),n.include(Gmaps4Rails.Marker.Instance),n.extend(Gmaps4Rails.Marker.Class),n.extend(Gmaps4Rails.Configuration),n.CONF={clusterer_gridSize:50,clusterer_maxZoom:5,custom_cluster_pictures:null,custom_infowindow_class:null,raw:{}},n.prototype.createInfoWindow=function(){var e;if(typeof this.controller.jsTemplate=="function"||this.description!=null)return typeof this.controller.jsTemplate=="function"&&(this.description=this.controller.jsTemplate(this)),this.controller.markers_conf.custom_infowindow_class!=null?(e=document.createElement("div"),e.setAttribute("class",this.controller.markers_conf.custom_infowindow_class),e.innerHTML=this.description,this.infowindow=new InfoBox(this.infobox(e)),google.maps.event.addListener(this.serviceObject,"click",this._openInfowindow())):(this.infowindow=new google.maps.InfoWindow({content:this.description}),google.maps.event.addListener(this.serviceObject,"click",this._openInfowindow()))},n.prototype._createBasicMarker=function(e,t){var n,r;return n={position:e,map:this.getMap(),title:t.marker_title,draggable:t.marker_draggable,zIndex:t.zindex},r=this.mergeObjects(this.controller.markers_conf.raw,n),this.serviceObject=new google.maps.Marker(r)},n.prototype._createRichMarker=function(e,t){var n,r;return this.serviceObject=new RichMarker({position:e,map:this.getMap(),draggable:t.marker_draggable,content:t.rich_marker,flat:((n=t.marker_anchor!=null)!=null?n:t.marker_anchor[1])?void 0:!1,anchor:((r=t.marker_anchor!=null)!=null?r:t.marker_anchor[0])?void 0:null,zIndex:t.zindex})},n.prototype._createMarker=function(e,t){var n,r,i,s,o,u;return r=this._createImageAnchorPosition(t.marker_anchor),o=this._createImageAnchorPosition(t.shadow_anchor),i=this._createOrRetrieveImage(t.marker_picture,t.marker_width,t.marker_height,r),u=this._createOrRetrieveImage(t.shadow_picture,t.shadow_width,t.shadow_height,o),n={position:e,map:this.getMap(),icon:i,title:t.marker_title,draggable:t.marker_draggable,shadow:u,zIndex:t.zindex},s=this.mergeObjects(this.controller.markers_conf.raw,n),this.serviceObject=new google.maps.Marker(s)},n.prototype._includeMarkerImage=function(e){var t,n,r,i,s;s=this.controller.markerImages;for(t=r=0,i=s.length;r<i;t=++r){n=s[t];if(n.url===e)return t}return!1},n.prototype._createOrRetrieveImage=function(e,t,n,r){var i,s;return typeof e=="undefined"||e===""||e===null?null:(s=this._includeMarkerImage(e))?typeof s=="number"?this.controller.markerImages[s]:!1:(i=this._createMarkerImage(e,this.createSize(t,n),null,r,null),this.controller.markerImages.push(i),i)},n.prototype._isBasicMarker=function(e){return e.marker_picture==null&&e.rich_marker==null},n.prototype._createMarkerImage=function(e,t,n,r,i){return new google.maps.MarkerImage(e,t,n,r,i)},n.prototype._createImageAnchorPosition=function(e){return e===null?null:this.createPoint(e[0],e[1])},n.prototype._openInfowindow=function(){var e;return e=this,function(){return e.controller._closeVisibleInfoWindow(),e.infowindow.open(e.getMap(),e.serviceObject),e.controller._setVisibleInfoWindow(e.infowindow)}},n}(Gmaps4Rails.Common)}.call(this),function(){var e={}.hasOwnProperty,t=function(t,n){function i(){this.constructor=t}for(var r in n)e.call(n,r)&&(t[r]=n[r]);return i.prototype=n.prototype,t.prototype=new i,t.__super__=n.prototype,t};this.Gmaps4Rails.Google.Polygon=function(e){function n(e,t){var n,r,i,s,o,u,a,f,l,c,h,p,d,v;this.controller=t,f=[];for(d=0,v=e.length;d<v;d++)u=e[d],s=this.createLatLng(u.lat,u.lng),f.push(s),u===e[0]&&(l=u.strokeColor||this.controller.polygons_conf.strokeColor,c=u.strokeOpacity||this.controller.polygons_conf.strokeOpacity,h=u.strokeWeight||this.controller.polygons_conf.strokeWeight,r=u.fillColor||this.controller.polygons_conf.fillColor,i=u.fillOpacity||this.controller.polygons_conf.fillOpacity,n=u.clickable||this.controller.polygons_conf.clickable,p=u.zIndex||this.controller.polygons_conf.zIndex);a={path:f,strokeColor:l,strokeOpacity:c,strokeWeight:h,clickable:n,zIndex:p},o=this.mergeObjects(t.polygons_conf.raw,a),this.serviceObject=new google.maps.Polygon(o),this.serviceObject.setMap(t.getMapObject())}return t(n,e),n.include(Gmaps4Rails.Interfaces.Basic),n.include(Gmaps4Rails.Google.Shared),n.extend(Gmaps4Rails.Polygon.Class),n.extend(Gmaps4Rails.Configuration),n}(Gmaps4Rails.Common)}.call(this),function(){var e={}.hasOwnProperty,t=function(t,n){function i(){this.constructor=t}for(var r in n)e.call(n,r)&&(t[r]=n[r]);return i.prototype=n.prototype,t.prototype=new i,t.__super__=n.prototype,t};this.Gmaps4Rails.Google.Polyline=function(e){function n(e,t){var n,r,i,s,o,u,a,f,l,c,h,p,d,v,m,g;f=[];for(d=0,m=e.length;d<m;d++){i=e[d];if(i.coded_array!=null){r=new google.maps.geometry.encoding.decodePath(i.coded_array);for(v=0,g=r.length;v<g;v++)u=r[v],f.push(u)}else i===e[0]&&(l=i.strokeColor||t.polylines_conf.strokeColor,c=i.strokeOpacity||t.polylines_conf.strokeOpacity,h=i.strokeWeight||t.polylines_conf.strokeWeight,n=i.clickable||t.polylines_conf.clickable,p=i.zIndex||t.polylines_conf.zIndex,s=i.icons||t.polylines_conf.icons),i.lat!=null&&i.lng!=null&&f.push(this.createLatLng(i.lat,i.lng))}a={path:f,strokeColor:l,strokeOpacity:c,strokeWeight:h,clickable:n,zIndex:p,icons:s},o=this.mergeObjects(t.polylines_conf.raw,a),this.serviceObject=new google.maps.Polyline(o),this.serviceObject.setMap(t.getMapObject())}return t(n,e),n.include(Gmaps4Rails.Interfaces.Basic),n.include(Gmaps4Rails.Google.Shared),n.extend(Gmaps4Rails.Polyline.Class),n.extend(Gmaps4Rails.Configuration),n}(Gmaps4Rails.Common)}.call(this),function(){var e={}.hasOwnProperty,t=function(t,n){function i(){this.constructor=t}for(var r in n)e.call(n,r)&&(t[r]=n[r]);return i.prototype=n.prototype,t.prototype=new i,t.__super__=n.prototype,t};this.Gmaps4RailsGoogle=function(e){function n(){n.__super__.constructor.apply(this,arguments),this.markerImages=[]}return t(n,e),n.include(Gmaps4Rails.Google.Shared),n.prototype.getModule=function(){return Gmaps4Rails.Google},n.prototype.createClusterer=function(e){return new MarkerClusterer(this.getMapObject(),e,{maxZoom:this.markers_conf.clusterer_maxZoom,gridSize:this.markers_conf.clusterer_gridSize,styles:this.customClusterer()})},n.prototype.clearClusterer=function(){return this.markerClusterer.clearMarkers()},n.prototype.clusterize=function(){var e,t,n,r,i;if(this.markers_conf.do_clustering){this.markerClusterer!=null&&this.clearClusterer(),t=[],i=this.markers;for(n=0,r=i.length;n<r;n++)e=i[n],t.push(e.serviceObject);return this.markerClusterer=this.createClusterer(t)}},n.prototype._closeVisibleInfoWindow=function(){if(this.visibleInfowindow!=null)return this.visibleInfowindow.close()},n.prototype._setVisibleInfoWindow=function(e){return this.visibleInfowindow=e},n}(Gmaps4Rails.BaseController)}.call(this),function(){}.call(this);
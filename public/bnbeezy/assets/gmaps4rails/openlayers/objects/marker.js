(function(){var e={}.hasOwnProperty,t=function(t,n){function i(){this.constructor=t}for(var r in n)e.call(n,r)&&(t[r]=n[r]);return i.prototype=n.prototype,t.prototype=new i,t.__super__=n.prototype,t};this.Gmaps4Rails.Openlayers.Marker=function(e){function n(e,t){this.controller=t,this.controller._createMarkersLayer(),this._createMarkerStyle(e),this._isBasicMarker(e)?this._styleForBasicMarker(e):this._styleForCustomMarker(e),this.serviceObject=new OpenLayers.Feature.Vector(this.createPoint(e.lat,e.lng),null,this.style_mark),this.serviceObject.geometry.transform(new OpenLayers.Projection("EPSG:4326"),new OpenLayers.Projection("EPSG:900913")),this.controller.markersLayer.addFeatures([this.serviceObject])}return t(n,e),n.include(Gmaps4Rails.Interfaces.Marker),n.include(Gmaps4Rails.Openlayers.Shared),n.include(Gmaps4Rails.Marker.Instance),n.extend(Gmaps4Rails.Marker.Class),n.extend(Gmaps4Rails.Configuration),n.prototype.createInfoWindow=function(){if(this.description!=null)return this.serviceObject.infoWindow=this.description},n.prototype.isVisible=function(){return!0},n.prototype._isBasicMarker=function(e){return e.marker_picture==null},n.prototype._createMarkerStyle=function(e){return this.style_mark=OpenLayers.Util.extend({},OpenLayers.Feature.Vector.style["default"]),this.style_mark.fillOpacity=1,this.style_mark.graphicTitle=e.marker_title},n.prototype._styleForBasicMarker=function(e){return this.style_mark.graphicHeight=30,this.style_mark.externalGraphic="http://openlayers.org/dev/img/marker-blue.png"},n.prototype._styleForCustomMarker=function(e){this.style_mark.graphicWidth=e.marker_width,this.style_mark.graphicHeight=e.marker_height,this.style_mark.externalGraphic=e.marker_picture,e.marker_anchor!=null&&(this.style_mark.graphicXOffset=e.marker_anchor[0],this.style_mark.graphicYOffset=e.marker_anchor[1]);if(e.shadow_picture!=null){this.style_mark.backgroundGraphic=e.shadow_picture,this.style_mark.backgroundWidth=e.shadow_width,this.style_mark.backgroundHeight=e.shadow_height;if(e.shadow_anchor!=null)return this.style_mark.backgroundXOffset=e.shadow_anchor[0],this.style_mark.backgroundYOffset=e.shadow_anchor[1]}},n}(Gmaps4Rails.Common)}).call(this);
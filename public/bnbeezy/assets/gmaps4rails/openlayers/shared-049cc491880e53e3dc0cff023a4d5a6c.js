(function(){Gmaps4Rails.Openlayers={},Gmaps4Rails.Openlayers.Shared={createPoint:function(e,t){return new OpenLayers.Geometry.Point(t,e)},createLatLng:function(e,t){return(new OpenLayers.LonLat(t,e)).transform(new OpenLayers.Projection("EPSG:4326"),new OpenLayers.Projection("EPSG:900913"))},createAnchor:function(e){return e===null?null:new OpenLayers.Pixel(e[0],e[1])},createSize:function(e,t){return new OpenLayers.Size(e,t)},createLatLngBounds:function(){return new OpenLayers.Bounds}}}).call(this);
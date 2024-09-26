Shader "Effects/Mobile/Distortion/ParticlesCutOut" {
	Properties {
		_TintColor ("Tint Color", Vector) = (1,1,1,1)
		_MainTex ("Base (RGB) Gloss (A)", 2D) = "black" {}
		_CutOut ("CutOut (A)", 2D) = "black" {}
		_BumpMap ("Normalmap", 2D) = "bump" {}
		_ColorStrength ("Color Strength", Float) = 1
		_BumpAmt ("Distortion", Float) = 10
		_InvFade ("Soft Particles Factor", Range(0, 10)) = 1
	}
	SubShader {
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Opaque" }
		Pass {
			Name "BASE"
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "ALWAYS" "QUEUE" = "Transparent" "RenderType" = "Opaque" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZClip Off
			ZWrite Off
			Cull Off
			Fog {
				Mode Off
			}
			GpuProgramID 13537
			Program "vp" {
				SubProgram "gles hw_tier00 " {
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _CutOut_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec2 xlv_TEXCOORD2;
					varying highp vec2 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec4 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
					  tmpvar_1.xy = ((tmpvar_2.xy + tmpvar_2.w) * 0.5);
					  tmpvar_1.zw = tmpvar_2.zw;
					  gl_Position = tmpvar_2;
					  xlv_TEXCOORD0 = tmpvar_1;
					  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD3 = ((_glesMultiTexCoord0.xy * _CutOut_ST.xy) + _CutOut_ST.zw);
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform sampler2D _CutOut;
					uniform sampler2D _BumpMap;
					uniform highp float _BumpAmt;
					uniform highp float _ColorStrength;
					uniform sampler2D _GrabTextureMobile;
					uniform highp vec4 _GrabTextureMobile_TexelSize;
					uniform lowp vec4 _TintColor;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec2 xlv_TEXCOORD2;
					varying highp vec2 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR;
					void main ()
					{
					  mediump vec4 tmpvar_1;
					  highp vec4 tmpvar_2;
					  tmpvar_2.zw = xlv_TEXCOORD0.zw;
					  lowp vec4 emission_3;
					  mediump vec4 col_4;
					  mediump vec2 bump_5;
					  lowp vec2 tmpvar_6;
					  tmpvar_6 = ((texture2D (_BumpMap, xlv_TEXCOORD1).xyz * 2.0) - 1.0).xy;
					  bump_5 = tmpvar_6;
					  tmpvar_2.xy = (((bump_5 * _BumpAmt) * (_GrabTextureMobile_TexelSize.xy * xlv_TEXCOORD0.z)) + xlv_TEXCOORD0.xy);
					  lowp vec4 tmpvar_7;
					  tmpvar_7 = texture2DProj (_GrabTextureMobile, tmpvar_2);
					  col_4 = tmpvar_7;
					  lowp vec4 tmpvar_8;
					  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD2) * xlv_COLOR);
					  highp vec4 tmpvar_9;
					  tmpvar_9 = ((col_4 * xlv_COLOR) + ((tmpvar_8 * _ColorStrength) * _TintColor));
					  emission_3.xyz = tmpvar_9.xyz;
					  emission_3.w = ((_TintColor.w * xlv_COLOR.w) * (texture2D (_CutOut, xlv_TEXCOORD3) * xlv_COLOR).w);
					  tmpvar_1 = emission_3;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _CutOut_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec2 xlv_TEXCOORD2;
					varying highp vec2 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec4 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
					  tmpvar_1.xy = ((tmpvar_2.xy + tmpvar_2.w) * 0.5);
					  tmpvar_1.zw = tmpvar_2.zw;
					  gl_Position = tmpvar_2;
					  xlv_TEXCOORD0 = tmpvar_1;
					  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD3 = ((_glesMultiTexCoord0.xy * _CutOut_ST.xy) + _CutOut_ST.zw);
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform sampler2D _CutOut;
					uniform sampler2D _BumpMap;
					uniform highp float _BumpAmt;
					uniform highp float _ColorStrength;
					uniform sampler2D _GrabTextureMobile;
					uniform highp vec4 _GrabTextureMobile_TexelSize;
					uniform lowp vec4 _TintColor;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec2 xlv_TEXCOORD2;
					varying highp vec2 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR;
					void main ()
					{
					  mediump vec4 tmpvar_1;
					  highp vec4 tmpvar_2;
					  tmpvar_2.zw = xlv_TEXCOORD0.zw;
					  lowp vec4 emission_3;
					  mediump vec4 col_4;
					  mediump vec2 bump_5;
					  lowp vec2 tmpvar_6;
					  tmpvar_6 = ((texture2D (_BumpMap, xlv_TEXCOORD1).xyz * 2.0) - 1.0).xy;
					  bump_5 = tmpvar_6;
					  tmpvar_2.xy = (((bump_5 * _BumpAmt) * (_GrabTextureMobile_TexelSize.xy * xlv_TEXCOORD0.z)) + xlv_TEXCOORD0.xy);
					  lowp vec4 tmpvar_7;
					  tmpvar_7 = texture2DProj (_GrabTextureMobile, tmpvar_2);
					  col_4 = tmpvar_7;
					  lowp vec4 tmpvar_8;
					  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD2) * xlv_COLOR);
					  highp vec4 tmpvar_9;
					  tmpvar_9 = ((col_4 * xlv_COLOR) + ((tmpvar_8 * _ColorStrength) * _TintColor));
					  emission_3.xyz = tmpvar_9.xyz;
					  emission_3.w = ((_TintColor.w * xlv_COLOR.w) * (texture2D (_CutOut, xlv_TEXCOORD3) * xlv_COLOR).w);
					  tmpvar_1 = emission_3;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _CutOut_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec2 xlv_TEXCOORD2;
					varying highp vec2 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec4 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
					  tmpvar_1.xy = ((tmpvar_2.xy + tmpvar_2.w) * 0.5);
					  tmpvar_1.zw = tmpvar_2.zw;
					  gl_Position = tmpvar_2;
					  xlv_TEXCOORD0 = tmpvar_1;
					  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD3 = ((_glesMultiTexCoord0.xy * _CutOut_ST.xy) + _CutOut_ST.zw);
					  xlv_COLOR = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform sampler2D _CutOut;
					uniform sampler2D _BumpMap;
					uniform highp float _BumpAmt;
					uniform highp float _ColorStrength;
					uniform sampler2D _GrabTextureMobile;
					uniform highp vec4 _GrabTextureMobile_TexelSize;
					uniform lowp vec4 _TintColor;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec2 xlv_TEXCOORD2;
					varying highp vec2 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR;
					void main ()
					{
					  mediump vec4 tmpvar_1;
					  highp vec4 tmpvar_2;
					  tmpvar_2.zw = xlv_TEXCOORD0.zw;
					  lowp vec4 emission_3;
					  mediump vec4 col_4;
					  mediump vec2 bump_5;
					  lowp vec2 tmpvar_6;
					  tmpvar_6 = ((texture2D (_BumpMap, xlv_TEXCOORD1).xyz * 2.0) - 1.0).xy;
					  bump_5 = tmpvar_6;
					  tmpvar_2.xy = (((bump_5 * _BumpAmt) * (_GrabTextureMobile_TexelSize.xy * xlv_TEXCOORD0.z)) + xlv_TEXCOORD0.xy);
					  lowp vec4 tmpvar_7;
					  tmpvar_7 = texture2DProj (_GrabTextureMobile, tmpvar_2);
					  col_4 = tmpvar_7;
					  lowp vec4 tmpvar_8;
					  tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD2) * xlv_COLOR);
					  highp vec4 tmpvar_9;
					  tmpvar_9 = ((col_4 * xlv_COLOR) + ((tmpvar_8 * _ColorStrength) * _TintColor));
					  emission_3.xyz = tmpvar_9.xyz;
					  emission_3.w = ((_TintColor.w * xlv_COLOR.w) * (texture2D (_CutOut, xlv_TEXCOORD3) * xlv_COLOR).w);
					  tmpvar_1 = emission_3;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _BumpMap_ST;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _CutOut_ST;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					in mediump vec4 in_COLOR0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec2 vs_TEXCOORD2;
					out highp vec2 vs_TEXCOORD3;
					out mediump vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    u_xlat0.xy = u_xlat0.ww + u_xlat0.xy;
					    vs_TEXCOORD0.zw = u_xlat0.zw;
					    vs_TEXCOORD0.xy = u_xlat0.xy * vec2(0.5, 0.5);
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _CutOut_ST.xy + _CutOut_ST.zw;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	float _BumpAmt;
					uniform 	float _ColorStrength;
					uniform 	vec4 _GrabTextureMobile_TexelSize;
					uniform 	mediump vec4 _TintColor;
					uniform lowp sampler2D _BumpMap;
					uniform lowp sampler2D _GrabTextureMobile;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _CutOut;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec2 vs_TEXCOORD2;
					in highp vec2 vs_TEXCOORD3;
					in mediump vec4 vs_COLOR0;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					mediump float u_xlat16_0;
					lowp vec3 u_xlat10_0;
					mediump vec2 u_xlat16_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					void main()
					{
					    u_xlat10_0.xy = texture(_BumpMap, vs_TEXCOORD1.xy).xy;
					    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.xy = u_xlat16_1.xy * vec2(_BumpAmt);
					    u_xlat0.xy = u_xlat0.xy * _GrabTextureMobile_TexelSize.xy;
					    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD0.zz + vs_TEXCOORD0.xy;
					    u_xlat0.xy = u_xlat0.xy / vs_TEXCOORD0.ww;
					    u_xlat10_0.xyz = texture(_GrabTextureMobile, u_xlat0.xy).xyz;
					    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat16_2.xyz * vec3(vec3(_ColorStrength, _ColorStrength, _ColorStrength));
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz + u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    u_xlat10_0.x = texture(_CutOut, vs_TEXCOORD3.xy).w;
					    u_xlat16_0 = u_xlat10_0.x * vs_COLOR0.w;
					    u_xlat16_1.x = vs_COLOR0.w * _TintColor.w;
					    SV_Target0.w = u_xlat16_0 * u_xlat16_1.x;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _BumpMap_ST;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _CutOut_ST;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					in mediump vec4 in_COLOR0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec2 vs_TEXCOORD2;
					out highp vec2 vs_TEXCOORD3;
					out mediump vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    u_xlat0.xy = u_xlat0.ww + u_xlat0.xy;
					    vs_TEXCOORD0.zw = u_xlat0.zw;
					    vs_TEXCOORD0.xy = u_xlat0.xy * vec2(0.5, 0.5);
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _CutOut_ST.xy + _CutOut_ST.zw;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	float _BumpAmt;
					uniform 	float _ColorStrength;
					uniform 	vec4 _GrabTextureMobile_TexelSize;
					uniform 	mediump vec4 _TintColor;
					uniform lowp sampler2D _BumpMap;
					uniform lowp sampler2D _GrabTextureMobile;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _CutOut;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec2 vs_TEXCOORD2;
					in highp vec2 vs_TEXCOORD3;
					in mediump vec4 vs_COLOR0;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					mediump float u_xlat16_0;
					lowp vec3 u_xlat10_0;
					mediump vec2 u_xlat16_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					void main()
					{
					    u_xlat10_0.xy = texture(_BumpMap, vs_TEXCOORD1.xy).xy;
					    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.xy = u_xlat16_1.xy * vec2(_BumpAmt);
					    u_xlat0.xy = u_xlat0.xy * _GrabTextureMobile_TexelSize.xy;
					    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD0.zz + vs_TEXCOORD0.xy;
					    u_xlat0.xy = u_xlat0.xy / vs_TEXCOORD0.ww;
					    u_xlat10_0.xyz = texture(_GrabTextureMobile, u_xlat0.xy).xyz;
					    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat16_2.xyz * vec3(vec3(_ColorStrength, _ColorStrength, _ColorStrength));
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz + u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    u_xlat10_0.x = texture(_CutOut, vs_TEXCOORD3.xy).w;
					    u_xlat16_0 = u_xlat10_0.x * vs_COLOR0.w;
					    u_xlat16_1.x = vs_COLOR0.w * _TintColor.w;
					    SV_Target0.w = u_xlat16_0 * u_xlat16_1.x;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _BumpMap_ST;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _CutOut_ST;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					in mediump vec4 in_COLOR0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec2 vs_TEXCOORD2;
					out highp vec2 vs_TEXCOORD3;
					out mediump vec4 vs_COLOR0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    u_xlat0.xy = u_xlat0.ww + u_xlat0.xy;
					    vs_TEXCOORD0.zw = u_xlat0.zw;
					    vs_TEXCOORD0.xy = u_xlat0.xy * vec2(0.5, 0.5);
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _CutOut_ST.xy + _CutOut_ST.zw;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	float _BumpAmt;
					uniform 	float _ColorStrength;
					uniform 	vec4 _GrabTextureMobile_TexelSize;
					uniform 	mediump vec4 _TintColor;
					uniform lowp sampler2D _BumpMap;
					uniform lowp sampler2D _GrabTextureMobile;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _CutOut;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec2 vs_TEXCOORD2;
					in highp vec2 vs_TEXCOORD3;
					in mediump vec4 vs_COLOR0;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					mediump float u_xlat16_0;
					lowp vec3 u_xlat10_0;
					mediump vec2 u_xlat16_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec3 u_xlat10_2;
					void main()
					{
					    u_xlat10_0.xy = texture(_BumpMap, vs_TEXCOORD1.xy).xy;
					    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.xy = u_xlat16_1.xy * vec2(_BumpAmt);
					    u_xlat0.xy = u_xlat0.xy * _GrabTextureMobile_TexelSize.xy;
					    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD0.zz + vs_TEXCOORD0.xy;
					    u_xlat0.xy = u_xlat0.xy / vs_TEXCOORD0.ww;
					    u_xlat10_0.xyz = texture(_GrabTextureMobile, u_xlat0.xy).xyz;
					    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
					    u_xlat16_2.xyz = u_xlat10_2.xyz * vs_COLOR0.xyz;
					    u_xlat2.xyz = u_xlat16_2.xyz * vec3(vec3(_ColorStrength, _ColorStrength, _ColorStrength));
					    u_xlat2.xyz = u_xlat2.xyz * _TintColor.xyz;
					    u_xlat0.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz + u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    u_xlat10_0.x = texture(_CutOut, vs_TEXCOORD3.xy).w;
					    u_xlat16_0 = u_xlat10_0.x * vs_COLOR0.w;
					    u_xlat16_1.x = vs_COLOR0.w * _TintColor.w;
					    SV_Target0.w = u_xlat16_0 * u_xlat16_1.x;
					    return;
					}
					
					#endif"
				}
				SubProgram "vulkan hw_tier00 " {
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 1
					; Bound: 150
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Vertex %4 "main" %11 %79 %95 %108 %110 %120 %130 %141 %142 
					                                                      OpDecorate %11 Location 11 
					                                                      OpDecorate %16 ArrayStride 16 
					                                                      OpDecorate %17 ArrayStride 17 
					                                                      OpMemberDecorate %18 0 Offset 18 
					                                                      OpMemberDecorate %18 1 Offset 18 
					                                                      OpMemberDecorate %18 2 Offset 18 
					                                                      OpMemberDecorate %18 3 Offset 18 
					                                                      OpMemberDecorate %18 4 Offset 18 
					                                                      OpDecorate %18 Block 
					                                                      OpDecorate %20 DescriptorSet 20 
					                                                      OpDecorate %20 Binding 20 
					                                                      OpMemberDecorate %77 0 BuiltIn 77 
					                                                      OpMemberDecorate %77 1 BuiltIn 77 
					                                                      OpMemberDecorate %77 2 BuiltIn 77 
					                                                      OpDecorate %77 Block 
					                                                      OpDecorate %95 Location 95 
					                                                      OpDecorate %108 Location 108 
					                                                      OpDecorate %110 Location 110 
					                                                      OpDecorate %120 Location 120 
					                                                      OpDecorate %130 Location 130 
					                                                      OpDecorate %141 RelaxedPrecision 
					                                                      OpDecorate %141 Location 141 
					                                                      OpDecorate %142 RelaxedPrecision 
					                                                      OpDecorate %142 Location 142 
					                                                      OpDecorate %143 RelaxedPrecision 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 4 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_4* %9 = OpVariable Private 
					                                              %10 = OpTypePointer Input %7 
					                                 Input f32_4* %11 = OpVariable Input 
					                                              %14 = OpTypeInt 32 0 
					                                          u32 %15 = OpConstant 4 
					                                              %16 = OpTypeArray %7 %15 
					                                              %17 = OpTypeArray %7 %15 
					                                              %18 = OpTypeStruct %16 %17 %7 %7 %7 
					                                              %19 = OpTypePointer Uniform %18 
					Uniform struct {f32_4[4]; f32_4[4]; f32_4; f32_4; f32_4;}* %20 = OpVariable Uniform 
					                                              %21 = OpTypeInt 32 1 
					                                          i32 %22 = OpConstant 0 
					                                          i32 %23 = OpConstant 1 
					                                              %24 = OpTypePointer Uniform %7 
					                                          i32 %35 = OpConstant 2 
					                                          i32 %44 = OpConstant 3 
					                               Private f32_4* %48 = OpVariable Private 
					                                          u32 %75 = OpConstant 1 
					                                              %76 = OpTypeArray %6 %75 
					                                              %77 = OpTypeStruct %7 %6 %76 
					                                              %78 = OpTypePointer Output %77 
					         Output struct {f32_4; f32; f32[1];}* %79 = OpVariable Output 
					                                              %81 = OpTypePointer Output %7 
					                                              %83 = OpTypeVector %6 2 
					                                          f32 %86 = OpConstant 3.674022E-40 
					                                          f32 %87 = OpConstant 3.674022E-40 
					                                        f32_2 %88 = OpConstantComposite %86 %87 
					                                Output f32_4* %95 = OpVariable Output 
					                                         f32 %102 = OpConstant 3.674022E-40 
					                                       f32_2 %103 = OpConstantComposite %102 %102 
					                                             %107 = OpTypePointer Output %83 
					                               Output f32_2* %108 = OpVariable Output 
					                                             %109 = OpTypePointer Input %83 
					                                Input f32_2* %110 = OpVariable Input 
					                               Output f32_2* %120 = OpVariable Output 
					                               Output f32_2* %130 = OpVariable Output 
					                                         i32 %132 = OpConstant 4 
					                               Output f32_4* %141 = OpVariable Output 
					                                Input f32_4* %142 = OpVariable Input 
					                                             %144 = OpTypePointer Output %6 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                        f32_4 %12 = OpLoad %11 
					                                        f32_4 %13 = OpVectorShuffle %12 %12 1 1 1 1 
					                               Uniform f32_4* %25 = OpAccessChain %20 %22 %23 
					                                        f32_4 %26 = OpLoad %25 
					                                        f32_4 %27 = OpFMul %13 %26 
					                                                      OpStore %9 %27 
					                               Uniform f32_4* %28 = OpAccessChain %20 %22 %22 
					                                        f32_4 %29 = OpLoad %28 
					                                        f32_4 %30 = OpLoad %11 
					                                        f32_4 %31 = OpVectorShuffle %30 %30 0 0 0 0 
					                                        f32_4 %32 = OpFMul %29 %31 
					                                        f32_4 %33 = OpLoad %9 
					                                        f32_4 %34 = OpFAdd %32 %33 
					                                                      OpStore %9 %34 
					                               Uniform f32_4* %36 = OpAccessChain %20 %22 %35 
					                                        f32_4 %37 = OpLoad %36 
					                                        f32_4 %38 = OpLoad %11 
					                                        f32_4 %39 = OpVectorShuffle %38 %38 2 2 2 2 
					                                        f32_4 %40 = OpFMul %37 %39 
					                                        f32_4 %41 = OpLoad %9 
					                                        f32_4 %42 = OpFAdd %40 %41 
					                                                      OpStore %9 %42 
					                                        f32_4 %43 = OpLoad %9 
					                               Uniform f32_4* %45 = OpAccessChain %20 %22 %44 
					                                        f32_4 %46 = OpLoad %45 
					                                        f32_4 %47 = OpFAdd %43 %46 
					                                                      OpStore %9 %47 
					                                        f32_4 %49 = OpLoad %9 
					                                        f32_4 %50 = OpVectorShuffle %49 %49 1 1 1 1 
					                               Uniform f32_4* %51 = OpAccessChain %20 %23 %23 
					                                        f32_4 %52 = OpLoad %51 
					                                        f32_4 %53 = OpFMul %50 %52 
					                                                      OpStore %48 %53 
					                               Uniform f32_4* %54 = OpAccessChain %20 %23 %22 
					                                        f32_4 %55 = OpLoad %54 
					                                        f32_4 %56 = OpLoad %9 
					                                        f32_4 %57 = OpVectorShuffle %56 %56 0 0 0 0 
					                                        f32_4 %58 = OpFMul %55 %57 
					                                        f32_4 %59 = OpLoad %48 
					                                        f32_4 %60 = OpFAdd %58 %59 
					                                                      OpStore %48 %60 
					                               Uniform f32_4* %61 = OpAccessChain %20 %23 %35 
					                                        f32_4 %62 = OpLoad %61 
					                                        f32_4 %63 = OpLoad %9 
					                                        f32_4 %64 = OpVectorShuffle %63 %63 2 2 2 2 
					                                        f32_4 %65 = OpFMul %62 %64 
					                                        f32_4 %66 = OpLoad %48 
					                                        f32_4 %67 = OpFAdd %65 %66 
					                                                      OpStore %48 %67 
					                               Uniform f32_4* %68 = OpAccessChain %20 %23 %44 
					                                        f32_4 %69 = OpLoad %68 
					                                        f32_4 %70 = OpLoad %9 
					                                        f32_4 %71 = OpVectorShuffle %70 %70 3 3 3 3 
					                                        f32_4 %72 = OpFMul %69 %71 
					                                        f32_4 %73 = OpLoad %48 
					                                        f32_4 %74 = OpFAdd %72 %73 
					                                                      OpStore %9 %74 
					                                        f32_4 %80 = OpLoad %9 
					                                Output f32_4* %82 = OpAccessChain %79 %22 
					                                                      OpStore %82 %80 
					                                        f32_4 %84 = OpLoad %9 
					                                        f32_2 %85 = OpVectorShuffle %84 %84 0 1 
					                                        f32_2 %89 = OpFMul %85 %88 
					                                        f32_4 %90 = OpLoad %9 
					                                        f32_2 %91 = OpVectorShuffle %90 %90 3 3 
					                                        f32_2 %92 = OpFAdd %89 %91 
					                                        f32_4 %93 = OpLoad %9 
					                                        f32_4 %94 = OpVectorShuffle %93 %92 4 5 2 3 
					                                                      OpStore %9 %94 
					                                        f32_4 %96 = OpLoad %9 
					                                        f32_2 %97 = OpVectorShuffle %96 %96 2 3 
					                                        f32_4 %98 = OpLoad %95 
					                                        f32_4 %99 = OpVectorShuffle %98 %97 0 1 4 5 
					                                                      OpStore %95 %99 
					                                       f32_4 %100 = OpLoad %9 
					                                       f32_2 %101 = OpVectorShuffle %100 %100 0 1 
					                                       f32_2 %104 = OpFMul %101 %103 
					                                       f32_4 %105 = OpLoad %95 
					                                       f32_4 %106 = OpVectorShuffle %105 %104 4 5 2 3 
					                                                      OpStore %95 %106 
					                                       f32_2 %111 = OpLoad %110 
					                              Uniform f32_4* %112 = OpAccessChain %20 %35 
					                                       f32_4 %113 = OpLoad %112 
					                                       f32_2 %114 = OpVectorShuffle %113 %113 0 1 
					                                       f32_2 %115 = OpFMul %111 %114 
					                              Uniform f32_4* %116 = OpAccessChain %20 %35 
					                                       f32_4 %117 = OpLoad %116 
					                                       f32_2 %118 = OpVectorShuffle %117 %117 2 3 
					                                       f32_2 %119 = OpFAdd %115 %118 
					                                                      OpStore %108 %119 
					                                       f32_2 %121 = OpLoad %110 
					                              Uniform f32_4* %122 = OpAccessChain %20 %44 
					                                       f32_4 %123 = OpLoad %122 
					                                       f32_2 %124 = OpVectorShuffle %123 %123 0 1 
					                                       f32_2 %125 = OpFMul %121 %124 
					                              Uniform f32_4* %126 = OpAccessChain %20 %44 
					                                       f32_4 %127 = OpLoad %126 
					                                       f32_2 %128 = OpVectorShuffle %127 %127 2 3 
					                                       f32_2 %129 = OpFAdd %125 %128 
					                                                      OpStore %120 %129 
					                                       f32_2 %131 = OpLoad %110 
					                              Uniform f32_4* %133 = OpAccessChain %20 %132 
					                                       f32_4 %134 = OpLoad %133 
					                                       f32_2 %135 = OpVectorShuffle %134 %134 0 1 
					                                       f32_2 %136 = OpFMul %131 %135 
					                              Uniform f32_4* %137 = OpAccessChain %20 %132 
					                                       f32_4 %138 = OpLoad %137 
					                                       f32_2 %139 = OpVectorShuffle %138 %138 2 3 
					                                       f32_2 %140 = OpFAdd %136 %139 
					                                                      OpStore %130 %140 
					                                       f32_4 %143 = OpLoad %142 
					                                                      OpStore %141 %143 
					                                 Output f32* %145 = OpAccessChain %79 %22 %75 
					                                         f32 %146 = OpLoad %145 
					                                         f32 %147 = OpFNegate %146 
					                                 Output f32* %148 = OpAccessChain %79 %22 %75 
					                                                      OpStore %148 %147 
					                                                      OpReturn
					                                                      OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 1
					; Bound: 159
					; Schema: 0
					                                                     OpCapability Shader 
					                                              %1 = OpExtInstImport "GLSL.std.450" 
					                                                     OpMemoryModel Logical GLSL450 
					                                                     OpEntryPoint Fragment %4 "main" %17 %61 %86 %92 %124 %130 
					                                                     OpExecutionMode %4 OriginUpperLeft 
					                                                     OpDecorate %9 RelaxedPrecision 
					                                                     OpDecorate %13 RelaxedPrecision 
					                                                     OpDecorate %13 DescriptorSet 13 
					                                                     OpDecorate %13 Binding 13 
					                                                     OpDecorate %14 RelaxedPrecision 
					                                                     OpDecorate %17 Location 17 
					                                                     OpDecorate %21 RelaxedPrecision 
					                                                     OpDecorate %25 RelaxedPrecision 
					                                                     OpDecorate %26 RelaxedPrecision 
					                                                     OpDecorate %27 RelaxedPrecision 
					                                                     OpDecorate %30 RelaxedPrecision 
					                                                     OpDecorate %33 RelaxedPrecision 
					                                                     OpDecorate %35 RelaxedPrecision 
					                                                     OpMemberDecorate %36 0 Offset 36 
					                                                     OpMemberDecorate %36 1 Offset 36 
					                                                     OpMemberDecorate %36 2 Offset 36 
					                                                     OpMemberDecorate %36 3 RelaxedPrecision 
					                                                     OpMemberDecorate %36 3 Offset 36 
					                                                     OpDecorate %36 Block 
					                                                     OpDecorate %38 DescriptorSet 38 
					                                                     OpDecorate %38 Binding 38 
					                                                     OpDecorate %44 RelaxedPrecision 
					                                                     OpDecorate %45 RelaxedPrecision 
					                                                     OpDecorate %61 Location 61 
					                                                     OpDecorate %77 RelaxedPrecision 
					                                                     OpDecorate %77 DescriptorSet 77 
					                                                     OpDecorate %77 Binding 77 
					                                                     OpDecorate %78 RelaxedPrecision 
					                                                     OpDecorate %82 RelaxedPrecision 
					                                                     OpDecorate %83 RelaxedPrecision 
					                                                     OpDecorate %84 RelaxedPrecision 
					                                                     OpDecorate %84 DescriptorSet 84 
					                                                     OpDecorate %84 Binding 84 
					                                                     OpDecorate %85 RelaxedPrecision 
					                                                     OpDecorate %86 Location 86 
					                                                     OpDecorate %89 RelaxedPrecision 
					                                                     OpDecorate %90 RelaxedPrecision 
					                                                     OpDecorate %91 RelaxedPrecision 
					                                                     OpDecorate %92 RelaxedPrecision 
					                                                     OpDecorate %92 Location 92 
					                                                     OpDecorate %93 RelaxedPrecision 
					                                                     OpDecorate %94 RelaxedPrecision 
					                                                     OpDecorate %95 RelaxedPrecision 
					                                                     OpDecorate %97 RelaxedPrecision 
					                                                     OpDecorate %105 RelaxedPrecision 
					                                                     OpDecorate %106 RelaxedPrecision 
					                                                     OpDecorate %107 RelaxedPrecision 
					                                                     OpDecorate %108 RelaxedPrecision 
					                                                     OpDecorate %109 RelaxedPrecision 
					                                                     OpDecorate %110 RelaxedPrecision 
					                                                     OpDecorate %114 RelaxedPrecision 
					                                                     OpDecorate %115 RelaxedPrecision 
					                                                     OpDecorate %117 RelaxedPrecision 
					                                                     OpDecorate %118 RelaxedPrecision 
					                                                     OpDecorate %119 RelaxedPrecision 
					                                                     OpDecorate %120 RelaxedPrecision 
					                                                     OpDecorate %124 RelaxedPrecision 
					                                                     OpDecorate %124 Location 124 
					                                                     OpDecorate %128 RelaxedPrecision 
					                                                     OpDecorate %128 DescriptorSet 128 
					                                                     OpDecorate %128 Binding 128 
					                                                     OpDecorate %129 RelaxedPrecision 
					                                                     OpDecorate %130 Location 130 
					                                                     OpDecorate %135 RelaxedPrecision 
					                                                     OpDecorate %139 RelaxedPrecision 
					                                                     OpDecorate %141 RelaxedPrecision 
					                                                     OpDecorate %144 RelaxedPrecision 
					                                                     OpDecorate %145 RelaxedPrecision 
					                                                     OpDecorate %147 RelaxedPrecision 
					                                                     OpDecorate %149 RelaxedPrecision 
					                                                     OpDecorate %150 RelaxedPrecision 
					                                                     OpDecorate %152 RelaxedPrecision 
					                                                     OpDecorate %154 RelaxedPrecision 
					                                                     OpDecorate %155 RelaxedPrecision 
					                                              %2 = OpTypeVoid 
					                                              %3 = OpTypeFunction %2 
					                                              %6 = OpTypeFloat 32 
					                                              %7 = OpTypeVector %6 3 
					                                              %8 = OpTypePointer Private %7 
					                               Private f32_3* %9 = OpVariable Private 
					                                             %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                             %11 = OpTypeSampledImage %10 
					                                             %12 = OpTypePointer UniformConstant %11 
					 UniformConstant read_only Texture2DSampled* %13 = OpVariable UniformConstant 
					                                             %15 = OpTypeVector %6 2 
					                                             %16 = OpTypePointer Input %15 
					                                Input f32_2* %17 = OpVariable Input 
					                                             %19 = OpTypeVector %6 4 
					                                             %24 = OpTypePointer Private %15 
					                              Private f32_2* %25 = OpVariable Private 
					                                         f32 %28 = OpConstant 3.674022E-40 
					                                       f32_2 %29 = OpConstantComposite %28 %28 
					                                         f32 %31 = OpConstant 3.674022E-40 
					                                       f32_2 %32 = OpConstantComposite %31 %31 
					                              Private f32_3* %34 = OpVariable Private 
					                                             %36 = OpTypeStruct %6 %6 %19 %19 
					                                             %37 = OpTypePointer Uniform %36 
					   Uniform struct {f32; f32; f32_4; f32_4;}* %38 = OpVariable Uniform 
					                                             %39 = OpTypeInt 32 1 
					                                         i32 %40 = OpConstant 0 
					                                             %41 = OpTypePointer Uniform %6 
					                                         i32 %50 = OpConstant 2 
					                                             %51 = OpTypePointer Uniform %19 
					                                             %60 = OpTypePointer Input %19 
					                                Input f32_4* %61 = OpVariable Input 
					 UniformConstant read_only Texture2DSampled* %77 = OpVariable UniformConstant 
					                              Private f32_3* %83 = OpVariable Private 
					 UniformConstant read_only Texture2DSampled* %84 = OpVariable UniformConstant 
					                                Input f32_2* %86 = OpVariable Input 
					                              Private f32_3* %90 = OpVariable Private 
					                                Input f32_4* %92 = OpVariable Input 
					                              Private f32_3* %96 = OpVariable Private 
					                                         i32 %98 = OpConstant 1 
					                                        i32 %112 = OpConstant 3 
					                                            %123 = OpTypePointer Output %19 
					                              Output f32_4* %124 = OpVariable Output 
					UniformConstant read_only Texture2DSampled* %128 = OpVariable UniformConstant 
					                               Input f32_2* %130 = OpVariable Input 
					                                            %133 = OpTypeInt 32 0 
					                                        u32 %134 = OpConstant 3 
					                                        u32 %136 = OpConstant 0 
					                                            %137 = OpTypePointer Private %6 
					                               Private f32* %139 = OpVariable Private 
					                                            %142 = OpTypePointer Input %6 
					                                            %156 = OpTypePointer Output %6 
					                                         void %4 = OpFunction None %3 
					                                              %5 = OpLabel 
					                  read_only Texture2DSampled %14 = OpLoad %13 
					                                       f32_2 %18 = OpLoad %17 
					                                       f32_4 %20 = OpImageSampleImplicitLod %14 %18 
					                                       f32_2 %21 = OpVectorShuffle %20 %20 0 1 
					                                       f32_3 %22 = OpLoad %9 
					                                       f32_3 %23 = OpVectorShuffle %22 %21 3 4 2 
					                                                     OpStore %9 %23 
					                                       f32_3 %26 = OpLoad %9 
					                                       f32_2 %27 = OpVectorShuffle %26 %26 0 1 
					                                       f32_2 %30 = OpFMul %27 %29 
					                                       f32_2 %33 = OpFAdd %30 %32 
					                                                     OpStore %25 %33 
					                                       f32_2 %35 = OpLoad %25 
					                                Uniform f32* %42 = OpAccessChain %38 %40 
					                                         f32 %43 = OpLoad %42 
					                                       f32_2 %44 = OpCompositeConstruct %43 %43 
					                                       f32_2 %45 = OpFMul %35 %44 
					                                       f32_3 %46 = OpLoad %34 
					                                       f32_3 %47 = OpVectorShuffle %46 %45 3 4 2 
					                                                     OpStore %34 %47 
					                                       f32_3 %48 = OpLoad %34 
					                                       f32_2 %49 = OpVectorShuffle %48 %48 0 1 
					                              Uniform f32_4* %52 = OpAccessChain %38 %50 
					                                       f32_4 %53 = OpLoad %52 
					                                       f32_2 %54 = OpVectorShuffle %53 %53 0 1 
					                                       f32_2 %55 = OpFMul %49 %54 
					                                       f32_3 %56 = OpLoad %34 
					                                       f32_3 %57 = OpVectorShuffle %56 %55 3 4 2 
					                                                     OpStore %34 %57 
					                                       f32_3 %58 = OpLoad %34 
					                                       f32_2 %59 = OpVectorShuffle %58 %58 0 1 
					                                       f32_4 %62 = OpLoad %61 
					                                       f32_2 %63 = OpVectorShuffle %62 %62 2 2 
					                                       f32_2 %64 = OpFMul %59 %63 
					                                       f32_4 %65 = OpLoad %61 
					                                       f32_2 %66 = OpVectorShuffle %65 %65 0 1 
					                                       f32_2 %67 = OpFAdd %64 %66 
					                                       f32_3 %68 = OpLoad %34 
					                                       f32_3 %69 = OpVectorShuffle %68 %67 3 4 2 
					                                                     OpStore %34 %69 
					                                       f32_3 %70 = OpLoad %34 
					                                       f32_2 %71 = OpVectorShuffle %70 %70 0 1 
					                                       f32_4 %72 = OpLoad %61 
					                                       f32_2 %73 = OpVectorShuffle %72 %72 3 3 
					                                       f32_2 %74 = OpFDiv %71 %73 
					                                       f32_3 %75 = OpLoad %34 
					                                       f32_3 %76 = OpVectorShuffle %75 %74 3 4 2 
					                                                     OpStore %34 %76 
					                  read_only Texture2DSampled %78 = OpLoad %77 
					                                       f32_3 %79 = OpLoad %34 
					                                       f32_2 %80 = OpVectorShuffle %79 %79 0 1 
					                                       f32_4 %81 = OpImageSampleImplicitLod %78 %80 
					                                       f32_3 %82 = OpVectorShuffle %81 %81 0 1 2 
					                                                     OpStore %9 %82 
					                  read_only Texture2DSampled %85 = OpLoad %84 
					                                       f32_2 %87 = OpLoad %86 
					                                       f32_4 %88 = OpImageSampleImplicitLod %85 %87 
					                                       f32_3 %89 = OpVectorShuffle %88 %88 0 1 2 
					                                                     OpStore %83 %89 
					                                       f32_3 %91 = OpLoad %83 
					                                       f32_4 %93 = OpLoad %92 
					                                       f32_3 %94 = OpVectorShuffle %93 %93 0 1 2 
					                                       f32_3 %95 = OpFMul %91 %94 
					                                                     OpStore %90 %95 
					                                       f32_3 %97 = OpLoad %90 
					                                Uniform f32* %99 = OpAccessChain %38 %98 
					                                        f32 %100 = OpLoad %99 
					                               Uniform f32* %101 = OpAccessChain %38 %98 
					                                        f32 %102 = OpLoad %101 
					                               Uniform f32* %103 = OpAccessChain %38 %98 
					                                        f32 %104 = OpLoad %103 
					                                      f32_3 %105 = OpCompositeConstruct %100 %102 %104 
					                                        f32 %106 = OpCompositeExtract %105 0 
					                                        f32 %107 = OpCompositeExtract %105 1 
					                                        f32 %108 = OpCompositeExtract %105 2 
					                                      f32_3 %109 = OpCompositeConstruct %106 %107 %108 
					                                      f32_3 %110 = OpFMul %97 %109 
					                                                     OpStore %96 %110 
					                                      f32_3 %111 = OpLoad %96 
					                             Uniform f32_4* %113 = OpAccessChain %38 %112 
					                                      f32_4 %114 = OpLoad %113 
					                                      f32_3 %115 = OpVectorShuffle %114 %114 0 1 2 
					                                      f32_3 %116 = OpFMul %111 %115 
					                                                     OpStore %96 %116 
					                                      f32_3 %117 = OpLoad %9 
					                                      f32_4 %118 = OpLoad %92 
					                                      f32_3 %119 = OpVectorShuffle %118 %118 0 1 2 
					                                      f32_3 %120 = OpFMul %117 %119 
					                                      f32_3 %121 = OpLoad %96 
					                                      f32_3 %122 = OpFAdd %120 %121 
					                                                     OpStore %34 %122 
					                                      f32_3 %125 = OpLoad %34 
					                                      f32_4 %126 = OpLoad %124 
					                                      f32_4 %127 = OpVectorShuffle %126 %125 4 5 6 3 
					                                                     OpStore %124 %127 
					                 read_only Texture2DSampled %129 = OpLoad %128 
					                                      f32_2 %131 = OpLoad %130 
					                                      f32_4 %132 = OpImageSampleImplicitLod %129 %131 
					                                        f32 %135 = OpCompositeExtract %132 3 
					                               Private f32* %138 = OpAccessChain %9 %136 
					                                                     OpStore %138 %135 
					                               Private f32* %140 = OpAccessChain %9 %136 
					                                        f32 %141 = OpLoad %140 
					                                 Input f32* %143 = OpAccessChain %92 %134 
					                                        f32 %144 = OpLoad %143 
					                                        f32 %145 = OpFMul %141 %144 
					                                                     OpStore %139 %145 
					                                 Input f32* %146 = OpAccessChain %92 %134 
					                                        f32 %147 = OpLoad %146 
					                               Uniform f32* %148 = OpAccessChain %38 %112 %134 
					                                        f32 %149 = OpLoad %148 
					                                        f32 %150 = OpFMul %147 %149 
					                               Private f32* %151 = OpAccessChain %25 %136 
					                                                     OpStore %151 %150 
					                                        f32 %152 = OpLoad %139 
					                               Private f32* %153 = OpAccessChain %25 %136 
					                                        f32 %154 = OpLoad %153 
					                                        f32 %155 = OpFMul %152 %154 
					                                Output f32* %157 = OpAccessChain %124 %134 
					                                                     OpStore %157 %155 
					                                                     OpReturn
					                                                     OpFunctionEnd"
				}
				SubProgram "vulkan hw_tier01 " {
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 1
					; Bound: 150
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Vertex %4 "main" %11 %79 %95 %108 %110 %120 %130 %141 %142 
					                                                      OpDecorate %11 Location 11 
					                                                      OpDecorate %16 ArrayStride 16 
					                                                      OpDecorate %17 ArrayStride 17 
					                                                      OpMemberDecorate %18 0 Offset 18 
					                                                      OpMemberDecorate %18 1 Offset 18 
					                                                      OpMemberDecorate %18 2 Offset 18 
					                                                      OpMemberDecorate %18 3 Offset 18 
					                                                      OpMemberDecorate %18 4 Offset 18 
					                                                      OpDecorate %18 Block 
					                                                      OpDecorate %20 DescriptorSet 20 
					                                                      OpDecorate %20 Binding 20 
					                                                      OpMemberDecorate %77 0 BuiltIn 77 
					                                                      OpMemberDecorate %77 1 BuiltIn 77 
					                                                      OpMemberDecorate %77 2 BuiltIn 77 
					                                                      OpDecorate %77 Block 
					                                                      OpDecorate %95 Location 95 
					                                                      OpDecorate %108 Location 108 
					                                                      OpDecorate %110 Location 110 
					                                                      OpDecorate %120 Location 120 
					                                                      OpDecorate %130 Location 130 
					                                                      OpDecorate %141 RelaxedPrecision 
					                                                      OpDecorate %141 Location 141 
					                                                      OpDecorate %142 RelaxedPrecision 
					                                                      OpDecorate %142 Location 142 
					                                                      OpDecorate %143 RelaxedPrecision 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 4 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_4* %9 = OpVariable Private 
					                                              %10 = OpTypePointer Input %7 
					                                 Input f32_4* %11 = OpVariable Input 
					                                              %14 = OpTypeInt 32 0 
					                                          u32 %15 = OpConstant 4 
					                                              %16 = OpTypeArray %7 %15 
					                                              %17 = OpTypeArray %7 %15 
					                                              %18 = OpTypeStruct %16 %17 %7 %7 %7 
					                                              %19 = OpTypePointer Uniform %18 
					Uniform struct {f32_4[4]; f32_4[4]; f32_4; f32_4; f32_4;}* %20 = OpVariable Uniform 
					                                              %21 = OpTypeInt 32 1 
					                                          i32 %22 = OpConstant 0 
					                                          i32 %23 = OpConstant 1 
					                                              %24 = OpTypePointer Uniform %7 
					                                          i32 %35 = OpConstant 2 
					                                          i32 %44 = OpConstant 3 
					                               Private f32_4* %48 = OpVariable Private 
					                                          u32 %75 = OpConstant 1 
					                                              %76 = OpTypeArray %6 %75 
					                                              %77 = OpTypeStruct %7 %6 %76 
					                                              %78 = OpTypePointer Output %77 
					         Output struct {f32_4; f32; f32[1];}* %79 = OpVariable Output 
					                                              %81 = OpTypePointer Output %7 
					                                              %83 = OpTypeVector %6 2 
					                                          f32 %86 = OpConstant 3.674022E-40 
					                                          f32 %87 = OpConstant 3.674022E-40 
					                                        f32_2 %88 = OpConstantComposite %86 %87 
					                                Output f32_4* %95 = OpVariable Output 
					                                         f32 %102 = OpConstant 3.674022E-40 
					                                       f32_2 %103 = OpConstantComposite %102 %102 
					                                             %107 = OpTypePointer Output %83 
					                               Output f32_2* %108 = OpVariable Output 
					                                             %109 = OpTypePointer Input %83 
					                                Input f32_2* %110 = OpVariable Input 
					                               Output f32_2* %120 = OpVariable Output 
					                               Output f32_2* %130 = OpVariable Output 
					                                         i32 %132 = OpConstant 4 
					                               Output f32_4* %141 = OpVariable Output 
					                                Input f32_4* %142 = OpVariable Input 
					                                             %144 = OpTypePointer Output %6 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                        f32_4 %12 = OpLoad %11 
					                                        f32_4 %13 = OpVectorShuffle %12 %12 1 1 1 1 
					                               Uniform f32_4* %25 = OpAccessChain %20 %22 %23 
					                                        f32_4 %26 = OpLoad %25 
					                                        f32_4 %27 = OpFMul %13 %26 
					                                                      OpStore %9 %27 
					                               Uniform f32_4* %28 = OpAccessChain %20 %22 %22 
					                                        f32_4 %29 = OpLoad %28 
					                                        f32_4 %30 = OpLoad %11 
					                                        f32_4 %31 = OpVectorShuffle %30 %30 0 0 0 0 
					                                        f32_4 %32 = OpFMul %29 %31 
					                                        f32_4 %33 = OpLoad %9 
					                                        f32_4 %34 = OpFAdd %32 %33 
					                                                      OpStore %9 %34 
					                               Uniform f32_4* %36 = OpAccessChain %20 %22 %35 
					                                        f32_4 %37 = OpLoad %36 
					                                        f32_4 %38 = OpLoad %11 
					                                        f32_4 %39 = OpVectorShuffle %38 %38 2 2 2 2 
					                                        f32_4 %40 = OpFMul %37 %39 
					                                        f32_4 %41 = OpLoad %9 
					                                        f32_4 %42 = OpFAdd %40 %41 
					                                                      OpStore %9 %42 
					                                        f32_4 %43 = OpLoad %9 
					                               Uniform f32_4* %45 = OpAccessChain %20 %22 %44 
					                                        f32_4 %46 = OpLoad %45 
					                                        f32_4 %47 = OpFAdd %43 %46 
					                                                      OpStore %9 %47 
					                                        f32_4 %49 = OpLoad %9 
					                                        f32_4 %50 = OpVectorShuffle %49 %49 1 1 1 1 
					                               Uniform f32_4* %51 = OpAccessChain %20 %23 %23 
					                                        f32_4 %52 = OpLoad %51 
					                                        f32_4 %53 = OpFMul %50 %52 
					                                                      OpStore %48 %53 
					                               Uniform f32_4* %54 = OpAccessChain %20 %23 %22 
					                                        f32_4 %55 = OpLoad %54 
					                                        f32_4 %56 = OpLoad %9 
					                                        f32_4 %57 = OpVectorShuffle %56 %56 0 0 0 0 
					                                        f32_4 %58 = OpFMul %55 %57 
					                                        f32_4 %59 = OpLoad %48 
					                                        f32_4 %60 = OpFAdd %58 %59 
					                                                      OpStore %48 %60 
					                               Uniform f32_4* %61 = OpAccessChain %20 %23 %35 
					                                        f32_4 %62 = OpLoad %61 
					                                        f32_4 %63 = OpLoad %9 
					                                        f32_4 %64 = OpVectorShuffle %63 %63 2 2 2 2 
					                                        f32_4 %65 = OpFMul %62 %64 
					                                        f32_4 %66 = OpLoad %48 
					                                        f32_4 %67 = OpFAdd %65 %66 
					                                                      OpStore %48 %67 
					                               Uniform f32_4* %68 = OpAccessChain %20 %23 %44 
					                                        f32_4 %69 = OpLoad %68 
					                                        f32_4 %70 = OpLoad %9 
					                                        f32_4 %71 = OpVectorShuffle %70 %70 3 3 3 3 
					                                        f32_4 %72 = OpFMul %69 %71 
					                                        f32_4 %73 = OpLoad %48 
					                                        f32_4 %74 = OpFAdd %72 %73 
					                                                      OpStore %9 %74 
					                                        f32_4 %80 = OpLoad %9 
					                                Output f32_4* %82 = OpAccessChain %79 %22 
					                                                      OpStore %82 %80 
					                                        f32_4 %84 = OpLoad %9 
					                                        f32_2 %85 = OpVectorShuffle %84 %84 0 1 
					                                        f32_2 %89 = OpFMul %85 %88 
					                                        f32_4 %90 = OpLoad %9 
					                                        f32_2 %91 = OpVectorShuffle %90 %90 3 3 
					                                        f32_2 %92 = OpFAdd %89 %91 
					                                        f32_4 %93 = OpLoad %9 
					                                        f32_4 %94 = OpVectorShuffle %93 %92 4 5 2 3 
					                                                      OpStore %9 %94 
					                                        f32_4 %96 = OpLoad %9 
					                                        f32_2 %97 = OpVectorShuffle %96 %96 2 3 
					                                        f32_4 %98 = OpLoad %95 
					                                        f32_4 %99 = OpVectorShuffle %98 %97 0 1 4 5 
					                                                      OpStore %95 %99 
					                                       f32_4 %100 = OpLoad %9 
					                                       f32_2 %101 = OpVectorShuffle %100 %100 0 1 
					                                       f32_2 %104 = OpFMul %101 %103 
					                                       f32_4 %105 = OpLoad %95 
					                                       f32_4 %106 = OpVectorShuffle %105 %104 4 5 2 3 
					                                                      OpStore %95 %106 
					                                       f32_2 %111 = OpLoad %110 
					                              Uniform f32_4* %112 = OpAccessChain %20 %35 
					                                       f32_4 %113 = OpLoad %112 
					                                       f32_2 %114 = OpVectorShuffle %113 %113 0 1 
					                                       f32_2 %115 = OpFMul %111 %114 
					                              Uniform f32_4* %116 = OpAccessChain %20 %35 
					                                       f32_4 %117 = OpLoad %116 
					                                       f32_2 %118 = OpVectorShuffle %117 %117 2 3 
					                                       f32_2 %119 = OpFAdd %115 %118 
					                                                      OpStore %108 %119 
					                                       f32_2 %121 = OpLoad %110 
					                              Uniform f32_4* %122 = OpAccessChain %20 %44 
					                                       f32_4 %123 = OpLoad %122 
					                                       f32_2 %124 = OpVectorShuffle %123 %123 0 1 
					                                       f32_2 %125 = OpFMul %121 %124 
					                              Uniform f32_4* %126 = OpAccessChain %20 %44 
					                                       f32_4 %127 = OpLoad %126 
					                                       f32_2 %128 = OpVectorShuffle %127 %127 2 3 
					                                       f32_2 %129 = OpFAdd %125 %128 
					                                                      OpStore %120 %129 
					                                       f32_2 %131 = OpLoad %110 
					                              Uniform f32_4* %133 = OpAccessChain %20 %132 
					                                       f32_4 %134 = OpLoad %133 
					                                       f32_2 %135 = OpVectorShuffle %134 %134 0 1 
					                                       f32_2 %136 = OpFMul %131 %135 
					                              Uniform f32_4* %137 = OpAccessChain %20 %132 
					                                       f32_4 %138 = OpLoad %137 
					                                       f32_2 %139 = OpVectorShuffle %138 %138 2 3 
					                                       f32_2 %140 = OpFAdd %136 %139 
					                                                      OpStore %130 %140 
					                                       f32_4 %143 = OpLoad %142 
					                                                      OpStore %141 %143 
					                                 Output f32* %145 = OpAccessChain %79 %22 %75 
					                                         f32 %146 = OpLoad %145 
					                                         f32 %147 = OpFNegate %146 
					                                 Output f32* %148 = OpAccessChain %79 %22 %75 
					                                                      OpStore %148 %147 
					                                                      OpReturn
					                                                      OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 1
					; Bound: 159
					; Schema: 0
					                                                     OpCapability Shader 
					                                              %1 = OpExtInstImport "GLSL.std.450" 
					                                                     OpMemoryModel Logical GLSL450 
					                                                     OpEntryPoint Fragment %4 "main" %17 %61 %86 %92 %124 %130 
					                                                     OpExecutionMode %4 OriginUpperLeft 
					                                                     OpDecorate %9 RelaxedPrecision 
					                                                     OpDecorate %13 RelaxedPrecision 
					                                                     OpDecorate %13 DescriptorSet 13 
					                                                     OpDecorate %13 Binding 13 
					                                                     OpDecorate %14 RelaxedPrecision 
					                                                     OpDecorate %17 Location 17 
					                                                     OpDecorate %21 RelaxedPrecision 
					                                                     OpDecorate %25 RelaxedPrecision 
					                                                     OpDecorate %26 RelaxedPrecision 
					                                                     OpDecorate %27 RelaxedPrecision 
					                                                     OpDecorate %30 RelaxedPrecision 
					                                                     OpDecorate %33 RelaxedPrecision 
					                                                     OpDecorate %35 RelaxedPrecision 
					                                                     OpMemberDecorate %36 0 Offset 36 
					                                                     OpMemberDecorate %36 1 Offset 36 
					                                                     OpMemberDecorate %36 2 Offset 36 
					                                                     OpMemberDecorate %36 3 RelaxedPrecision 
					                                                     OpMemberDecorate %36 3 Offset 36 
					                                                     OpDecorate %36 Block 
					                                                     OpDecorate %38 DescriptorSet 38 
					                                                     OpDecorate %38 Binding 38 
					                                                     OpDecorate %44 RelaxedPrecision 
					                                                     OpDecorate %45 RelaxedPrecision 
					                                                     OpDecorate %61 Location 61 
					                                                     OpDecorate %77 RelaxedPrecision 
					                                                     OpDecorate %77 DescriptorSet 77 
					                                                     OpDecorate %77 Binding 77 
					                                                     OpDecorate %78 RelaxedPrecision 
					                                                     OpDecorate %82 RelaxedPrecision 
					                                                     OpDecorate %83 RelaxedPrecision 
					                                                     OpDecorate %84 RelaxedPrecision 
					                                                     OpDecorate %84 DescriptorSet 84 
					                                                     OpDecorate %84 Binding 84 
					                                                     OpDecorate %85 RelaxedPrecision 
					                                                     OpDecorate %86 Location 86 
					                                                     OpDecorate %89 RelaxedPrecision 
					                                                     OpDecorate %90 RelaxedPrecision 
					                                                     OpDecorate %91 RelaxedPrecision 
					                                                     OpDecorate %92 RelaxedPrecision 
					                                                     OpDecorate %92 Location 92 
					                                                     OpDecorate %93 RelaxedPrecision 
					                                                     OpDecorate %94 RelaxedPrecision 
					                                                     OpDecorate %95 RelaxedPrecision 
					                                                     OpDecorate %97 RelaxedPrecision 
					                                                     OpDecorate %105 RelaxedPrecision 
					                                                     OpDecorate %106 RelaxedPrecision 
					                                                     OpDecorate %107 RelaxedPrecision 
					                                                     OpDecorate %108 RelaxedPrecision 
					                                                     OpDecorate %109 RelaxedPrecision 
					                                                     OpDecorate %110 RelaxedPrecision 
					                                                     OpDecorate %114 RelaxedPrecision 
					                                                     OpDecorate %115 RelaxedPrecision 
					                                                     OpDecorate %117 RelaxedPrecision 
					                                                     OpDecorate %118 RelaxedPrecision 
					                                                     OpDecorate %119 RelaxedPrecision 
					                                                     OpDecorate %120 RelaxedPrecision 
					                                                     OpDecorate %124 RelaxedPrecision 
					                                                     OpDecorate %124 Location 124 
					                                                     OpDecorate %128 RelaxedPrecision 
					                                                     OpDecorate %128 DescriptorSet 128 
					                                                     OpDecorate %128 Binding 128 
					                                                     OpDecorate %129 RelaxedPrecision 
					                                                     OpDecorate %130 Location 130 
					                                                     OpDecorate %135 RelaxedPrecision 
					                                                     OpDecorate %139 RelaxedPrecision 
					                                                     OpDecorate %141 RelaxedPrecision 
					                                                     OpDecorate %144 RelaxedPrecision 
					                                                     OpDecorate %145 RelaxedPrecision 
					                                                     OpDecorate %147 RelaxedPrecision 
					                                                     OpDecorate %149 RelaxedPrecision 
					                                                     OpDecorate %150 RelaxedPrecision 
					                                                     OpDecorate %152 RelaxedPrecision 
					                                                     OpDecorate %154 RelaxedPrecision 
					                                                     OpDecorate %155 RelaxedPrecision 
					                                              %2 = OpTypeVoid 
					                                              %3 = OpTypeFunction %2 
					                                              %6 = OpTypeFloat 32 
					                                              %7 = OpTypeVector %6 3 
					                                              %8 = OpTypePointer Private %7 
					                               Private f32_3* %9 = OpVariable Private 
					                                             %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                             %11 = OpTypeSampledImage %10 
					                                             %12 = OpTypePointer UniformConstant %11 
					 UniformConstant read_only Texture2DSampled* %13 = OpVariable UniformConstant 
					                                             %15 = OpTypeVector %6 2 
					                                             %16 = OpTypePointer Input %15 
					                                Input f32_2* %17 = OpVariable Input 
					                                             %19 = OpTypeVector %6 4 
					                                             %24 = OpTypePointer Private %15 
					                              Private f32_2* %25 = OpVariable Private 
					                                         f32 %28 = OpConstant 3.674022E-40 
					                                       f32_2 %29 = OpConstantComposite %28 %28 
					                                         f32 %31 = OpConstant 3.674022E-40 
					                                       f32_2 %32 = OpConstantComposite %31 %31 
					                              Private f32_3* %34 = OpVariable Private 
					                                             %36 = OpTypeStruct %6 %6 %19 %19 
					                                             %37 = OpTypePointer Uniform %36 
					   Uniform struct {f32; f32; f32_4; f32_4;}* %38 = OpVariable Uniform 
					                                             %39 = OpTypeInt 32 1 
					                                         i32 %40 = OpConstant 0 
					                                             %41 = OpTypePointer Uniform %6 
					                                         i32 %50 = OpConstant 2 
					                                             %51 = OpTypePointer Uniform %19 
					                                             %60 = OpTypePointer Input %19 
					                                Input f32_4* %61 = OpVariable Input 
					 UniformConstant read_only Texture2DSampled* %77 = OpVariable UniformConstant 
					                              Private f32_3* %83 = OpVariable Private 
					 UniformConstant read_only Texture2DSampled* %84 = OpVariable UniformConstant 
					                                Input f32_2* %86 = OpVariable Input 
					                              Private f32_3* %90 = OpVariable Private 
					                                Input f32_4* %92 = OpVariable Input 
					                              Private f32_3* %96 = OpVariable Private 
					                                         i32 %98 = OpConstant 1 
					                                        i32 %112 = OpConstant 3 
					                                            %123 = OpTypePointer Output %19 
					                              Output f32_4* %124 = OpVariable Output 
					UniformConstant read_only Texture2DSampled* %128 = OpVariable UniformConstant 
					                               Input f32_2* %130 = OpVariable Input 
					                                            %133 = OpTypeInt 32 0 
					                                        u32 %134 = OpConstant 3 
					                                        u32 %136 = OpConstant 0 
					                                            %137 = OpTypePointer Private %6 
					                               Private f32* %139 = OpVariable Private 
					                                            %142 = OpTypePointer Input %6 
					                                            %156 = OpTypePointer Output %6 
					                                         void %4 = OpFunction None %3 
					                                              %5 = OpLabel 
					                  read_only Texture2DSampled %14 = OpLoad %13 
					                                       f32_2 %18 = OpLoad %17 
					                                       f32_4 %20 = OpImageSampleImplicitLod %14 %18 
					                                       f32_2 %21 = OpVectorShuffle %20 %20 0 1 
					                                       f32_3 %22 = OpLoad %9 
					                                       f32_3 %23 = OpVectorShuffle %22 %21 3 4 2 
					                                                     OpStore %9 %23 
					                                       f32_3 %26 = OpLoad %9 
					                                       f32_2 %27 = OpVectorShuffle %26 %26 0 1 
					                                       f32_2 %30 = OpFMul %27 %29 
					                                       f32_2 %33 = OpFAdd %30 %32 
					                                                     OpStore %25 %33 
					                                       f32_2 %35 = OpLoad %25 
					                                Uniform f32* %42 = OpAccessChain %38 %40 
					                                         f32 %43 = OpLoad %42 
					                                       f32_2 %44 = OpCompositeConstruct %43 %43 
					                                       f32_2 %45 = OpFMul %35 %44 
					                                       f32_3 %46 = OpLoad %34 
					                                       f32_3 %47 = OpVectorShuffle %46 %45 3 4 2 
					                                                     OpStore %34 %47 
					                                       f32_3 %48 = OpLoad %34 
					                                       f32_2 %49 = OpVectorShuffle %48 %48 0 1 
					                              Uniform f32_4* %52 = OpAccessChain %38 %50 
					                                       f32_4 %53 = OpLoad %52 
					                                       f32_2 %54 = OpVectorShuffle %53 %53 0 1 
					                                       f32_2 %55 = OpFMul %49 %54 
					                                       f32_3 %56 = OpLoad %34 
					                                       f32_3 %57 = OpVectorShuffle %56 %55 3 4 2 
					                                                     OpStore %34 %57 
					                                       f32_3 %58 = OpLoad %34 
					                                       f32_2 %59 = OpVectorShuffle %58 %58 0 1 
					                                       f32_4 %62 = OpLoad %61 
					                                       f32_2 %63 = OpVectorShuffle %62 %62 2 2 
					                                       f32_2 %64 = OpFMul %59 %63 
					                                       f32_4 %65 = OpLoad %61 
					                                       f32_2 %66 = OpVectorShuffle %65 %65 0 1 
					                                       f32_2 %67 = OpFAdd %64 %66 
					                                       f32_3 %68 = OpLoad %34 
					                                       f32_3 %69 = OpVectorShuffle %68 %67 3 4 2 
					                                                     OpStore %34 %69 
					                                       f32_3 %70 = OpLoad %34 
					                                       f32_2 %71 = OpVectorShuffle %70 %70 0 1 
					                                       f32_4 %72 = OpLoad %61 
					                                       f32_2 %73 = OpVectorShuffle %72 %72 3 3 
					                                       f32_2 %74 = OpFDiv %71 %73 
					                                       f32_3 %75 = OpLoad %34 
					                                       f32_3 %76 = OpVectorShuffle %75 %74 3 4 2 
					                                                     OpStore %34 %76 
					                  read_only Texture2DSampled %78 = OpLoad %77 
					                                       f32_3 %79 = OpLoad %34 
					                                       f32_2 %80 = OpVectorShuffle %79 %79 0 1 
					                                       f32_4 %81 = OpImageSampleImplicitLod %78 %80 
					                                       f32_3 %82 = OpVectorShuffle %81 %81 0 1 2 
					                                                     OpStore %9 %82 
					                  read_only Texture2DSampled %85 = OpLoad %84 
					                                       f32_2 %87 = OpLoad %86 
					                                       f32_4 %88 = OpImageSampleImplicitLod %85 %87 
					                                       f32_3 %89 = OpVectorShuffle %88 %88 0 1 2 
					                                                     OpStore %83 %89 
					                                       f32_3 %91 = OpLoad %83 
					                                       f32_4 %93 = OpLoad %92 
					                                       f32_3 %94 = OpVectorShuffle %93 %93 0 1 2 
					                                       f32_3 %95 = OpFMul %91 %94 
					                                                     OpStore %90 %95 
					                                       f32_3 %97 = OpLoad %90 
					                                Uniform f32* %99 = OpAccessChain %38 %98 
					                                        f32 %100 = OpLoad %99 
					                               Uniform f32* %101 = OpAccessChain %38 %98 
					                                        f32 %102 = OpLoad %101 
					                               Uniform f32* %103 = OpAccessChain %38 %98 
					                                        f32 %104 = OpLoad %103 
					                                      f32_3 %105 = OpCompositeConstruct %100 %102 %104 
					                                        f32 %106 = OpCompositeExtract %105 0 
					                                        f32 %107 = OpCompositeExtract %105 1 
					                                        f32 %108 = OpCompositeExtract %105 2 
					                                      f32_3 %109 = OpCompositeConstruct %106 %107 %108 
					                                      f32_3 %110 = OpFMul %97 %109 
					                                                     OpStore %96 %110 
					                                      f32_3 %111 = OpLoad %96 
					                             Uniform f32_4* %113 = OpAccessChain %38 %112 
					                                      f32_4 %114 = OpLoad %113 
					                                      f32_3 %115 = OpVectorShuffle %114 %114 0 1 2 
					                                      f32_3 %116 = OpFMul %111 %115 
					                                                     OpStore %96 %116 
					                                      f32_3 %117 = OpLoad %9 
					                                      f32_4 %118 = OpLoad %92 
					                                      f32_3 %119 = OpVectorShuffle %118 %118 0 1 2 
					                                      f32_3 %120 = OpFMul %117 %119 
					                                      f32_3 %121 = OpLoad %96 
					                                      f32_3 %122 = OpFAdd %120 %121 
					                                                     OpStore %34 %122 
					                                      f32_3 %125 = OpLoad %34 
					                                      f32_4 %126 = OpLoad %124 
					                                      f32_4 %127 = OpVectorShuffle %126 %125 4 5 6 3 
					                                                     OpStore %124 %127 
					                 read_only Texture2DSampled %129 = OpLoad %128 
					                                      f32_2 %131 = OpLoad %130 
					                                      f32_4 %132 = OpImageSampleImplicitLod %129 %131 
					                                        f32 %135 = OpCompositeExtract %132 3 
					                               Private f32* %138 = OpAccessChain %9 %136 
					                                                     OpStore %138 %135 
					                               Private f32* %140 = OpAccessChain %9 %136 
					                                        f32 %141 = OpLoad %140 
					                                 Input f32* %143 = OpAccessChain %92 %134 
					                                        f32 %144 = OpLoad %143 
					                                        f32 %145 = OpFMul %141 %144 
					                                                     OpStore %139 %145 
					                                 Input f32* %146 = OpAccessChain %92 %134 
					                                        f32 %147 = OpLoad %146 
					                               Uniform f32* %148 = OpAccessChain %38 %112 %134 
					                                        f32 %149 = OpLoad %148 
					                                        f32 %150 = OpFMul %147 %149 
					                               Private f32* %151 = OpAccessChain %25 %136 
					                                                     OpStore %151 %150 
					                                        f32 %152 = OpLoad %139 
					                               Private f32* %153 = OpAccessChain %25 %136 
					                                        f32 %154 = OpLoad %153 
					                                        f32 %155 = OpFMul %152 %154 
					                                Output f32* %157 = OpAccessChain %124 %134 
					                                                     OpStore %157 %155 
					                                                     OpReturn
					                                                     OpFunctionEnd"
				}
				SubProgram "vulkan hw_tier02 " {
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 1
					; Bound: 150
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Vertex %4 "main" %11 %79 %95 %108 %110 %120 %130 %141 %142 
					                                                      OpDecorate %11 Location 11 
					                                                      OpDecorate %16 ArrayStride 16 
					                                                      OpDecorate %17 ArrayStride 17 
					                                                      OpMemberDecorate %18 0 Offset 18 
					                                                      OpMemberDecorate %18 1 Offset 18 
					                                                      OpMemberDecorate %18 2 Offset 18 
					                                                      OpMemberDecorate %18 3 Offset 18 
					                                                      OpMemberDecorate %18 4 Offset 18 
					                                                      OpDecorate %18 Block 
					                                                      OpDecorate %20 DescriptorSet 20 
					                                                      OpDecorate %20 Binding 20 
					                                                      OpMemberDecorate %77 0 BuiltIn 77 
					                                                      OpMemberDecorate %77 1 BuiltIn 77 
					                                                      OpMemberDecorate %77 2 BuiltIn 77 
					                                                      OpDecorate %77 Block 
					                                                      OpDecorate %95 Location 95 
					                                                      OpDecorate %108 Location 108 
					                                                      OpDecorate %110 Location 110 
					                                                      OpDecorate %120 Location 120 
					                                                      OpDecorate %130 Location 130 
					                                                      OpDecorate %141 RelaxedPrecision 
					                                                      OpDecorate %141 Location 141 
					                                                      OpDecorate %142 RelaxedPrecision 
					                                                      OpDecorate %142 Location 142 
					                                                      OpDecorate %143 RelaxedPrecision 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 4 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_4* %9 = OpVariable Private 
					                                              %10 = OpTypePointer Input %7 
					                                 Input f32_4* %11 = OpVariable Input 
					                                              %14 = OpTypeInt 32 0 
					                                          u32 %15 = OpConstant 4 
					                                              %16 = OpTypeArray %7 %15 
					                                              %17 = OpTypeArray %7 %15 
					                                              %18 = OpTypeStruct %16 %17 %7 %7 %7 
					                                              %19 = OpTypePointer Uniform %18 
					Uniform struct {f32_4[4]; f32_4[4]; f32_4; f32_4; f32_4;}* %20 = OpVariable Uniform 
					                                              %21 = OpTypeInt 32 1 
					                                          i32 %22 = OpConstant 0 
					                                          i32 %23 = OpConstant 1 
					                                              %24 = OpTypePointer Uniform %7 
					                                          i32 %35 = OpConstant 2 
					                                          i32 %44 = OpConstant 3 
					                               Private f32_4* %48 = OpVariable Private 
					                                          u32 %75 = OpConstant 1 
					                                              %76 = OpTypeArray %6 %75 
					                                              %77 = OpTypeStruct %7 %6 %76 
					                                              %78 = OpTypePointer Output %77 
					         Output struct {f32_4; f32; f32[1];}* %79 = OpVariable Output 
					                                              %81 = OpTypePointer Output %7 
					                                              %83 = OpTypeVector %6 2 
					                                          f32 %86 = OpConstant 3.674022E-40 
					                                          f32 %87 = OpConstant 3.674022E-40 
					                                        f32_2 %88 = OpConstantComposite %86 %87 
					                                Output f32_4* %95 = OpVariable Output 
					                                         f32 %102 = OpConstant 3.674022E-40 
					                                       f32_2 %103 = OpConstantComposite %102 %102 
					                                             %107 = OpTypePointer Output %83 
					                               Output f32_2* %108 = OpVariable Output 
					                                             %109 = OpTypePointer Input %83 
					                                Input f32_2* %110 = OpVariable Input 
					                               Output f32_2* %120 = OpVariable Output 
					                               Output f32_2* %130 = OpVariable Output 
					                                         i32 %132 = OpConstant 4 
					                               Output f32_4* %141 = OpVariable Output 
					                                Input f32_4* %142 = OpVariable Input 
					                                             %144 = OpTypePointer Output %6 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                        f32_4 %12 = OpLoad %11 
					                                        f32_4 %13 = OpVectorShuffle %12 %12 1 1 1 1 
					                               Uniform f32_4* %25 = OpAccessChain %20 %22 %23 
					                                        f32_4 %26 = OpLoad %25 
					                                        f32_4 %27 = OpFMul %13 %26 
					                                                      OpStore %9 %27 
					                               Uniform f32_4* %28 = OpAccessChain %20 %22 %22 
					                                        f32_4 %29 = OpLoad %28 
					                                        f32_4 %30 = OpLoad %11 
					                                        f32_4 %31 = OpVectorShuffle %30 %30 0 0 0 0 
					                                        f32_4 %32 = OpFMul %29 %31 
					                                        f32_4 %33 = OpLoad %9 
					                                        f32_4 %34 = OpFAdd %32 %33 
					                                                      OpStore %9 %34 
					                               Uniform f32_4* %36 = OpAccessChain %20 %22 %35 
					                                        f32_4 %37 = OpLoad %36 
					                                        f32_4 %38 = OpLoad %11 
					                                        f32_4 %39 = OpVectorShuffle %38 %38 2 2 2 2 
					                                        f32_4 %40 = OpFMul %37 %39 
					                                        f32_4 %41 = OpLoad %9 
					                                        f32_4 %42 = OpFAdd %40 %41 
					                                                      OpStore %9 %42 
					                                        f32_4 %43 = OpLoad %9 
					                               Uniform f32_4* %45 = OpAccessChain %20 %22 %44 
					                                        f32_4 %46 = OpLoad %45 
					                                        f32_4 %47 = OpFAdd %43 %46 
					                                                      OpStore %9 %47 
					                                        f32_4 %49 = OpLoad %9 
					                                        f32_4 %50 = OpVectorShuffle %49 %49 1 1 1 1 
					                               Uniform f32_4* %51 = OpAccessChain %20 %23 %23 
					                                        f32_4 %52 = OpLoad %51 
					                                        f32_4 %53 = OpFMul %50 %52 
					                                                      OpStore %48 %53 
					                               Uniform f32_4* %54 = OpAccessChain %20 %23 %22 
					                                        f32_4 %55 = OpLoad %54 
					                                        f32_4 %56 = OpLoad %9 
					                                        f32_4 %57 = OpVectorShuffle %56 %56 0 0 0 0 
					                                        f32_4 %58 = OpFMul %55 %57 
					                                        f32_4 %59 = OpLoad %48 
					                                        f32_4 %60 = OpFAdd %58 %59 
					                                                      OpStore %48 %60 
					                               Uniform f32_4* %61 = OpAccessChain %20 %23 %35 
					                                        f32_4 %62 = OpLoad %61 
					                                        f32_4 %63 = OpLoad %9 
					                                        f32_4 %64 = OpVectorShuffle %63 %63 2 2 2 2 
					                                        f32_4 %65 = OpFMul %62 %64 
					                                        f32_4 %66 = OpLoad %48 
					                                        f32_4 %67 = OpFAdd %65 %66 
					                                                      OpStore %48 %67 
					                               Uniform f32_4* %68 = OpAccessChain %20 %23 %44 
					                                        f32_4 %69 = OpLoad %68 
					                                        f32_4 %70 = OpLoad %9 
					                                        f32_4 %71 = OpVectorShuffle %70 %70 3 3 3 3 
					                                        f32_4 %72 = OpFMul %69 %71 
					                                        f32_4 %73 = OpLoad %48 
					                                        f32_4 %74 = OpFAdd %72 %73 
					                                                      OpStore %9 %74 
					                                        f32_4 %80 = OpLoad %9 
					                                Output f32_4* %82 = OpAccessChain %79 %22 
					                                                      OpStore %82 %80 
					                                        f32_4 %84 = OpLoad %9 
					                                        f32_2 %85 = OpVectorShuffle %84 %84 0 1 
					                                        f32_2 %89 = OpFMul %85 %88 
					                                        f32_4 %90 = OpLoad %9 
					                                        f32_2 %91 = OpVectorShuffle %90 %90 3 3 
					                                        f32_2 %92 = OpFAdd %89 %91 
					                                        f32_4 %93 = OpLoad %9 
					                                        f32_4 %94 = OpVectorShuffle %93 %92 4 5 2 3 
					                                                      OpStore %9 %94 
					                                        f32_4 %96 = OpLoad %9 
					                                        f32_2 %97 = OpVectorShuffle %96 %96 2 3 
					                                        f32_4 %98 = OpLoad %95 
					                                        f32_4 %99 = OpVectorShuffle %98 %97 0 1 4 5 
					                                                      OpStore %95 %99 
					                                       f32_4 %100 = OpLoad %9 
					                                       f32_2 %101 = OpVectorShuffle %100 %100 0 1 
					                                       f32_2 %104 = OpFMul %101 %103 
					                                       f32_4 %105 = OpLoad %95 
					                                       f32_4 %106 = OpVectorShuffle %105 %104 4 5 2 3 
					                                                      OpStore %95 %106 
					                                       f32_2 %111 = OpLoad %110 
					                              Uniform f32_4* %112 = OpAccessChain %20 %35 
					                                       f32_4 %113 = OpLoad %112 
					                                       f32_2 %114 = OpVectorShuffle %113 %113 0 1 
					                                       f32_2 %115 = OpFMul %111 %114 
					                              Uniform f32_4* %116 = OpAccessChain %20 %35 
					                                       f32_4 %117 = OpLoad %116 
					                                       f32_2 %118 = OpVectorShuffle %117 %117 2 3 
					                                       f32_2 %119 = OpFAdd %115 %118 
					                                                      OpStore %108 %119 
					                                       f32_2 %121 = OpLoad %110 
					                              Uniform f32_4* %122 = OpAccessChain %20 %44 
					                                       f32_4 %123 = OpLoad %122 
					                                       f32_2 %124 = OpVectorShuffle %123 %123 0 1 
					                                       f32_2 %125 = OpFMul %121 %124 
					                              Uniform f32_4* %126 = OpAccessChain %20 %44 
					                                       f32_4 %127 = OpLoad %126 
					                                       f32_2 %128 = OpVectorShuffle %127 %127 2 3 
					                                       f32_2 %129 = OpFAdd %125 %128 
					                                                      OpStore %120 %129 
					                                       f32_2 %131 = OpLoad %110 
					                              Uniform f32_4* %133 = OpAccessChain %20 %132 
					                                       f32_4 %134 = OpLoad %133 
					                                       f32_2 %135 = OpVectorShuffle %134 %134 0 1 
					                                       f32_2 %136 = OpFMul %131 %135 
					                              Uniform f32_4* %137 = OpAccessChain %20 %132 
					                                       f32_4 %138 = OpLoad %137 
					                                       f32_2 %139 = OpVectorShuffle %138 %138 2 3 
					                                       f32_2 %140 = OpFAdd %136 %139 
					                                                      OpStore %130 %140 
					                                       f32_4 %143 = OpLoad %142 
					                                                      OpStore %141 %143 
					                                 Output f32* %145 = OpAccessChain %79 %22 %75 
					                                         f32 %146 = OpLoad %145 
					                                         f32 %147 = OpFNegate %146 
					                                 Output f32* %148 = OpAccessChain %79 %22 %75 
					                                                      OpStore %148 %147 
					                                                      OpReturn
					                                                      OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 1
					; Bound: 159
					; Schema: 0
					                                                     OpCapability Shader 
					                                              %1 = OpExtInstImport "GLSL.std.450" 
					                                                     OpMemoryModel Logical GLSL450 
					                                                     OpEntryPoint Fragment %4 "main" %17 %61 %86 %92 %124 %130 
					                                                     OpExecutionMode %4 OriginUpperLeft 
					                                                     OpDecorate %9 RelaxedPrecision 
					                                                     OpDecorate %13 RelaxedPrecision 
					                                                     OpDecorate %13 DescriptorSet 13 
					                                                     OpDecorate %13 Binding 13 
					                                                     OpDecorate %14 RelaxedPrecision 
					                                                     OpDecorate %17 Location 17 
					                                                     OpDecorate %21 RelaxedPrecision 
					                                                     OpDecorate %25 RelaxedPrecision 
					                                                     OpDecorate %26 RelaxedPrecision 
					                                                     OpDecorate %27 RelaxedPrecision 
					                                                     OpDecorate %30 RelaxedPrecision 
					                                                     OpDecorate %33 RelaxedPrecision 
					                                                     OpDecorate %35 RelaxedPrecision 
					                                                     OpMemberDecorate %36 0 Offset 36 
					                                                     OpMemberDecorate %36 1 Offset 36 
					                                                     OpMemberDecorate %36 2 Offset 36 
					                                                     OpMemberDecorate %36 3 RelaxedPrecision 
					                                                     OpMemberDecorate %36 3 Offset 36 
					                                                     OpDecorate %36 Block 
					                                                     OpDecorate %38 DescriptorSet 38 
					                                                     OpDecorate %38 Binding 38 
					                                                     OpDecorate %44 RelaxedPrecision 
					                                                     OpDecorate %45 RelaxedPrecision 
					                                                     OpDecorate %61 Location 61 
					                                                     OpDecorate %77 RelaxedPrecision 
					                                                     OpDecorate %77 DescriptorSet 77 
					                                                     OpDecorate %77 Binding 77 
					                                                     OpDecorate %78 RelaxedPrecision 
					                                                     OpDecorate %82 RelaxedPrecision 
					                                                     OpDecorate %83 RelaxedPrecision 
					                                                     OpDecorate %84 RelaxedPrecision 
					                                                     OpDecorate %84 DescriptorSet 84 
					                                                     OpDecorate %84 Binding 84 
					                                                     OpDecorate %85 RelaxedPrecision 
					                                                     OpDecorate %86 Location 86 
					                                                     OpDecorate %89 RelaxedPrecision 
					                                                     OpDecorate %90 RelaxedPrecision 
					                                                     OpDecorate %91 RelaxedPrecision 
					                                                     OpDecorate %92 RelaxedPrecision 
					                                                     OpDecorate %92 Location 92 
					                                                     OpDecorate %93 RelaxedPrecision 
					                                                     OpDecorate %94 RelaxedPrecision 
					                                                     OpDecorate %95 RelaxedPrecision 
					                                                     OpDecorate %97 RelaxedPrecision 
					                                                     OpDecorate %105 RelaxedPrecision 
					                                                     OpDecorate %106 RelaxedPrecision 
					                                                     OpDecorate %107 RelaxedPrecision 
					                                                     OpDecorate %108 RelaxedPrecision 
					                                                     OpDecorate %109 RelaxedPrecision 
					                                                     OpDecorate %110 RelaxedPrecision 
					                                                     OpDecorate %114 RelaxedPrecision 
					                                                     OpDecorate %115 RelaxedPrecision 
					                                                     OpDecorate %117 RelaxedPrecision 
					                                                     OpDecorate %118 RelaxedPrecision 
					                                                     OpDecorate %119 RelaxedPrecision 
					                                                     OpDecorate %120 RelaxedPrecision 
					                                                     OpDecorate %124 RelaxedPrecision 
					                                                     OpDecorate %124 Location 124 
					                                                     OpDecorate %128 RelaxedPrecision 
					                                                     OpDecorate %128 DescriptorSet 128 
					                                                     OpDecorate %128 Binding 128 
					                                                     OpDecorate %129 RelaxedPrecision 
					                                                     OpDecorate %130 Location 130 
					                                                     OpDecorate %135 RelaxedPrecision 
					                                                     OpDecorate %139 RelaxedPrecision 
					                                                     OpDecorate %141 RelaxedPrecision 
					                                                     OpDecorate %144 RelaxedPrecision 
					                                                     OpDecorate %145 RelaxedPrecision 
					                                                     OpDecorate %147 RelaxedPrecision 
					                                                     OpDecorate %149 RelaxedPrecision 
					                                                     OpDecorate %150 RelaxedPrecision 
					                                                     OpDecorate %152 RelaxedPrecision 
					                                                     OpDecorate %154 RelaxedPrecision 
					                                                     OpDecorate %155 RelaxedPrecision 
					                                              %2 = OpTypeVoid 
					                                              %3 = OpTypeFunction %2 
					                                              %6 = OpTypeFloat 32 
					                                              %7 = OpTypeVector %6 3 
					                                              %8 = OpTypePointer Private %7 
					                               Private f32_3* %9 = OpVariable Private 
					                                             %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                             %11 = OpTypeSampledImage %10 
					                                             %12 = OpTypePointer UniformConstant %11 
					 UniformConstant read_only Texture2DSampled* %13 = OpVariable UniformConstant 
					                                             %15 = OpTypeVector %6 2 
					                                             %16 = OpTypePointer Input %15 
					                                Input f32_2* %17 = OpVariable Input 
					                                             %19 = OpTypeVector %6 4 
					                                             %24 = OpTypePointer Private %15 
					                              Private f32_2* %25 = OpVariable Private 
					                                         f32 %28 = OpConstant 3.674022E-40 
					                                       f32_2 %29 = OpConstantComposite %28 %28 
					                                         f32 %31 = OpConstant 3.674022E-40 
					                                       f32_2 %32 = OpConstantComposite %31 %31 
					                              Private f32_3* %34 = OpVariable Private 
					                                             %36 = OpTypeStruct %6 %6 %19 %19 
					                                             %37 = OpTypePointer Uniform %36 
					   Uniform struct {f32; f32; f32_4; f32_4;}* %38 = OpVariable Uniform 
					                                             %39 = OpTypeInt 32 1 
					                                         i32 %40 = OpConstant 0 
					                                             %41 = OpTypePointer Uniform %6 
					                                         i32 %50 = OpConstant 2 
					                                             %51 = OpTypePointer Uniform %19 
					                                             %60 = OpTypePointer Input %19 
					                                Input f32_4* %61 = OpVariable Input 
					 UniformConstant read_only Texture2DSampled* %77 = OpVariable UniformConstant 
					                              Private f32_3* %83 = OpVariable Private 
					 UniformConstant read_only Texture2DSampled* %84 = OpVariable UniformConstant 
					                                Input f32_2* %86 = OpVariable Input 
					                              Private f32_3* %90 = OpVariable Private 
					                                Input f32_4* %92 = OpVariable Input 
					                              Private f32_3* %96 = OpVariable Private 
					                                         i32 %98 = OpConstant 1 
					                                        i32 %112 = OpConstant 3 
					                                            %123 = OpTypePointer Output %19 
					                              Output f32_4* %124 = OpVariable Output 
					UniformConstant read_only Texture2DSampled* %128 = OpVariable UniformConstant 
					                               Input f32_2* %130 = OpVariable Input 
					                                            %133 = OpTypeInt 32 0 
					                                        u32 %134 = OpConstant 3 
					                                        u32 %136 = OpConstant 0 
					                                            %137 = OpTypePointer Private %6 
					                               Private f32* %139 = OpVariable Private 
					                                            %142 = OpTypePointer Input %6 
					                                            %156 = OpTypePointer Output %6 
					                                         void %4 = OpFunction None %3 
					                                              %5 = OpLabel 
					                  read_only Texture2DSampled %14 = OpLoad %13 
					                                       f32_2 %18 = OpLoad %17 
					                                       f32_4 %20 = OpImageSampleImplicitLod %14 %18 
					                                       f32_2 %21 = OpVectorShuffle %20 %20 0 1 
					                                       f32_3 %22 = OpLoad %9 
					                                       f32_3 %23 = OpVectorShuffle %22 %21 3 4 2 
					                                                     OpStore %9 %23 
					                                       f32_3 %26 = OpLoad %9 
					                                       f32_2 %27 = OpVectorShuffle %26 %26 0 1 
					                                       f32_2 %30 = OpFMul %27 %29 
					                                       f32_2 %33 = OpFAdd %30 %32 
					                                                     OpStore %25 %33 
					                                       f32_2 %35 = OpLoad %25 
					                                Uniform f32* %42 = OpAccessChain %38 %40 
					                                         f32 %43 = OpLoad %42 
					                                       f32_2 %44 = OpCompositeConstruct %43 %43 
					                                       f32_2 %45 = OpFMul %35 %44 
					                                       f32_3 %46 = OpLoad %34 
					                                       f32_3 %47 = OpVectorShuffle %46 %45 3 4 2 
					                                                     OpStore %34 %47 
					                                       f32_3 %48 = OpLoad %34 
					                                       f32_2 %49 = OpVectorShuffle %48 %48 0 1 
					                              Uniform f32_4* %52 = OpAccessChain %38 %50 
					                                       f32_4 %53 = OpLoad %52 
					                                       f32_2 %54 = OpVectorShuffle %53 %53 0 1 
					                                       f32_2 %55 = OpFMul %49 %54 
					                                       f32_3 %56 = OpLoad %34 
					                                       f32_3 %57 = OpVectorShuffle %56 %55 3 4 2 
					                                                     OpStore %34 %57 
					                                       f32_3 %58 = OpLoad %34 
					                                       f32_2 %59 = OpVectorShuffle %58 %58 0 1 
					                                       f32_4 %62 = OpLoad %61 
					                                       f32_2 %63 = OpVectorShuffle %62 %62 2 2 
					                                       f32_2 %64 = OpFMul %59 %63 
					                                       f32_4 %65 = OpLoad %61 
					                                       f32_2 %66 = OpVectorShuffle %65 %65 0 1 
					                                       f32_2 %67 = OpFAdd %64 %66 
					                                       f32_3 %68 = OpLoad %34 
					                                       f32_3 %69 = OpVectorShuffle %68 %67 3 4 2 
					                                                     OpStore %34 %69 
					                                       f32_3 %70 = OpLoad %34 
					                                       f32_2 %71 = OpVectorShuffle %70 %70 0 1 
					                                       f32_4 %72 = OpLoad %61 
					                                       f32_2 %73 = OpVectorShuffle %72 %72 3 3 
					                                       f32_2 %74 = OpFDiv %71 %73 
					                                       f32_3 %75 = OpLoad %34 
					                                       f32_3 %76 = OpVectorShuffle %75 %74 3 4 2 
					                                                     OpStore %34 %76 
					                  read_only Texture2DSampled %78 = OpLoad %77 
					                                       f32_3 %79 = OpLoad %34 
					                                       f32_2 %80 = OpVectorShuffle %79 %79 0 1 
					                                       f32_4 %81 = OpImageSampleImplicitLod %78 %80 
					                                       f32_3 %82 = OpVectorShuffle %81 %81 0 1 2 
					                                                     OpStore %9 %82 
					                  read_only Texture2DSampled %85 = OpLoad %84 
					                                       f32_2 %87 = OpLoad %86 
					                                       f32_4 %88 = OpImageSampleImplicitLod %85 %87 
					                                       f32_3 %89 = OpVectorShuffle %88 %88 0 1 2 
					                                                     OpStore %83 %89 
					                                       f32_3 %91 = OpLoad %83 
					                                       f32_4 %93 = OpLoad %92 
					                                       f32_3 %94 = OpVectorShuffle %93 %93 0 1 2 
					                                       f32_3 %95 = OpFMul %91 %94 
					                                                     OpStore %90 %95 
					                                       f32_3 %97 = OpLoad %90 
					                                Uniform f32* %99 = OpAccessChain %38 %98 
					                                        f32 %100 = OpLoad %99 
					                               Uniform f32* %101 = OpAccessChain %38 %98 
					                                        f32 %102 = OpLoad %101 
					                               Uniform f32* %103 = OpAccessChain %38 %98 
					                                        f32 %104 = OpLoad %103 
					                                      f32_3 %105 = OpCompositeConstruct %100 %102 %104 
					                                        f32 %106 = OpCompositeExtract %105 0 
					                                        f32 %107 = OpCompositeExtract %105 1 
					                                        f32 %108 = OpCompositeExtract %105 2 
					                                      f32_3 %109 = OpCompositeConstruct %106 %107 %108 
					                                      f32_3 %110 = OpFMul %97 %109 
					                                                     OpStore %96 %110 
					                                      f32_3 %111 = OpLoad %96 
					                             Uniform f32_4* %113 = OpAccessChain %38 %112 
					                                      f32_4 %114 = OpLoad %113 
					                                      f32_3 %115 = OpVectorShuffle %114 %114 0 1 2 
					                                      f32_3 %116 = OpFMul %111 %115 
					                                                     OpStore %96 %116 
					                                      f32_3 %117 = OpLoad %9 
					                                      f32_4 %118 = OpLoad %92 
					                                      f32_3 %119 = OpVectorShuffle %118 %118 0 1 2 
					                                      f32_3 %120 = OpFMul %117 %119 
					                                      f32_3 %121 = OpLoad %96 
					                                      f32_3 %122 = OpFAdd %120 %121 
					                                                     OpStore %34 %122 
					                                      f32_3 %125 = OpLoad %34 
					                                      f32_4 %126 = OpLoad %124 
					                                      f32_4 %127 = OpVectorShuffle %126 %125 4 5 6 3 
					                                                     OpStore %124 %127 
					                 read_only Texture2DSampled %129 = OpLoad %128 
					                                      f32_2 %131 = OpLoad %130 
					                                      f32_4 %132 = OpImageSampleImplicitLod %129 %131 
					                                        f32 %135 = OpCompositeExtract %132 3 
					                               Private f32* %138 = OpAccessChain %9 %136 
					                                                     OpStore %138 %135 
					                               Private f32* %140 = OpAccessChain %9 %136 
					                                        f32 %141 = OpLoad %140 
					                                 Input f32* %143 = OpAccessChain %92 %134 
					                                        f32 %144 = OpLoad %143 
					                                        f32 %145 = OpFMul %141 %144 
					                                                     OpStore %139 %145 
					                                 Input f32* %146 = OpAccessChain %92 %134 
					                                        f32 %147 = OpLoad %146 
					                               Uniform f32* %148 = OpAccessChain %38 %112 %134 
					                                        f32 %149 = OpLoad %148 
					                                        f32 %150 = OpFMul %147 %149 
					                               Private f32* %151 = OpAccessChain %25 %136 
					                                                     OpStore %151 %150 
					                                        f32 %152 = OpLoad %139 
					                               Private f32* %153 = OpAccessChain %25 %136 
					                                        f32 %154 = OpLoad %153 
					                                        f32 %155 = OpFMul %152 %154 
					                                Output f32* %157 = OpAccessChain %124 %134 
					                                                     OpStore %157 %155 
					                                                     OpReturn
					                                                     OpFunctionEnd"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "SOFTPARTICLES_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ProjectionParams;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_MatrixV;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _CutOut_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec2 xlv_TEXCOORD2;
					varying highp vec2 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR;
					varying highp vec4 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  highp vec4 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = tmpvar_1.xyz;
					  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
					  highp vec4 o_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7 = (tmpvar_4 * 0.5);
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = tmpvar_7.x;
					  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
					  o_6.xy = (tmpvar_8 + tmpvar_7.w);
					  o_6.zw = tmpvar_4.zw;
					  tmpvar_3.xyw = o_6.xyw;
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = tmpvar_1.xyz;
					  tmpvar_3.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_9)).z);
					  tmpvar_2.xy = ((tmpvar_4.xy + tmpvar_4.w) * 0.5);
					  tmpvar_2.zw = tmpvar_4.zw;
					  gl_Position = tmpvar_4;
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD3 = ((_glesMultiTexCoord0.xy * _CutOut_ST.xy) + _CutOut_ST.zw);
					  xlv_COLOR = _glesColor;
					  xlv_TEXCOORD4 = tmpvar_3;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
					uniform sampler2D _MainTex;
					uniform sampler2D _CutOut;
					uniform sampler2D _BumpMap;
					uniform highp float _BumpAmt;
					uniform highp float _ColorStrength;
					uniform sampler2D _GrabTextureMobile;
					uniform highp vec4 _GrabTextureMobile_TexelSize;
					uniform lowp vec4 _TintColor;
					uniform sampler2D _CameraDepthTexture;
					uniform highp float _InvFade;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec2 xlv_TEXCOORD2;
					varying highp vec2 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR;
					varying highp vec4 xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec4 tmpvar_1;
					  highp vec4 tmpvar_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_2 = xlv_TEXCOORD0;
					  tmpvar_3 = xlv_COLOR;
					  lowp vec4 emission_4;
					  mediump vec4 col_5;
					  mediump vec2 bump_6;
					  if ((_InvFade > 0.0001)) {
					    lowp vec4 tmpvar_7;
					    tmpvar_7 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD4);
					    highp float z_8;
					    z_8 = tmpvar_7.x;
					    highp float tmpvar_9;
					    tmpvar_9 = clamp ((_InvFade * (
					      (1.0/(((_ZBufferParams.z * z_8) + _ZBufferParams.w)))
					     - xlv_TEXCOORD4.z)), 0.0, 1.0);
					    tmpvar_3.w = (xlv_COLOR.w * tmpvar_9);
					  };
					  lowp vec2 tmpvar_10;
					  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD1).xyz * 2.0) - 1.0).xy;
					  bump_6 = tmpvar_10;
					  tmpvar_2.xy = (((bump_6 * _BumpAmt) * (_GrabTextureMobile_TexelSize.xy * xlv_TEXCOORD0.z)) + xlv_TEXCOORD0.xy);
					  lowp vec4 tmpvar_11;
					  tmpvar_11 = texture2DProj (_GrabTextureMobile, tmpvar_2);
					  col_5 = tmpvar_11;
					  lowp vec4 tmpvar_12;
					  tmpvar_12 = (texture2D (_MainTex, xlv_TEXCOORD2) * tmpvar_3);
					  highp vec4 tmpvar_13;
					  tmpvar_13 = ((col_5 * tmpvar_3) + ((tmpvar_12 * _ColorStrength) * _TintColor));
					  emission_4.xyz = tmpvar_13.xyz;
					  emission_4.w = ((_TintColor.w * tmpvar_3.w) * (texture2D (_CutOut, xlv_TEXCOORD3) * tmpvar_3).w);
					  tmpvar_1 = emission_4;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "SOFTPARTICLES_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ProjectionParams;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_MatrixV;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _CutOut_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec2 xlv_TEXCOORD2;
					varying highp vec2 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR;
					varying highp vec4 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  highp vec4 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = tmpvar_1.xyz;
					  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
					  highp vec4 o_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7 = (tmpvar_4 * 0.5);
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = tmpvar_7.x;
					  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
					  o_6.xy = (tmpvar_8 + tmpvar_7.w);
					  o_6.zw = tmpvar_4.zw;
					  tmpvar_3.xyw = o_6.xyw;
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = tmpvar_1.xyz;
					  tmpvar_3.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_9)).z);
					  tmpvar_2.xy = ((tmpvar_4.xy + tmpvar_4.w) * 0.5);
					  tmpvar_2.zw = tmpvar_4.zw;
					  gl_Position = tmpvar_4;
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD3 = ((_glesMultiTexCoord0.xy * _CutOut_ST.xy) + _CutOut_ST.zw);
					  xlv_COLOR = _glesColor;
					  xlv_TEXCOORD4 = tmpvar_3;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
					uniform sampler2D _MainTex;
					uniform sampler2D _CutOut;
					uniform sampler2D _BumpMap;
					uniform highp float _BumpAmt;
					uniform highp float _ColorStrength;
					uniform sampler2D _GrabTextureMobile;
					uniform highp vec4 _GrabTextureMobile_TexelSize;
					uniform lowp vec4 _TintColor;
					uniform sampler2D _CameraDepthTexture;
					uniform highp float _InvFade;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec2 xlv_TEXCOORD2;
					varying highp vec2 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR;
					varying highp vec4 xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec4 tmpvar_1;
					  highp vec4 tmpvar_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_2 = xlv_TEXCOORD0;
					  tmpvar_3 = xlv_COLOR;
					  lowp vec4 emission_4;
					  mediump vec4 col_5;
					  mediump vec2 bump_6;
					  if ((_InvFade > 0.0001)) {
					    lowp vec4 tmpvar_7;
					    tmpvar_7 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD4);
					    highp float z_8;
					    z_8 = tmpvar_7.x;
					    highp float tmpvar_9;
					    tmpvar_9 = clamp ((_InvFade * (
					      (1.0/(((_ZBufferParams.z * z_8) + _ZBufferParams.w)))
					     - xlv_TEXCOORD4.z)), 0.0, 1.0);
					    tmpvar_3.w = (xlv_COLOR.w * tmpvar_9);
					  };
					  lowp vec2 tmpvar_10;
					  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD1).xyz * 2.0) - 1.0).xy;
					  bump_6 = tmpvar_10;
					  tmpvar_2.xy = (((bump_6 * _BumpAmt) * (_GrabTextureMobile_TexelSize.xy * xlv_TEXCOORD0.z)) + xlv_TEXCOORD0.xy);
					  lowp vec4 tmpvar_11;
					  tmpvar_11 = texture2DProj (_GrabTextureMobile, tmpvar_2);
					  col_5 = tmpvar_11;
					  lowp vec4 tmpvar_12;
					  tmpvar_12 = (texture2D (_MainTex, xlv_TEXCOORD2) * tmpvar_3);
					  highp vec4 tmpvar_13;
					  tmpvar_13 = ((col_5 * tmpvar_3) + ((tmpvar_12 * _ColorStrength) * _TintColor));
					  emission_4.xyz = tmpvar_13.xyz;
					  emission_4.w = ((_TintColor.w * tmpvar_3.w) * (texture2D (_CutOut, xlv_TEXCOORD3) * tmpvar_3).w);
					  tmpvar_1 = emission_4;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "SOFTPARTICLES_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ProjectionParams;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_MatrixV;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _CutOut_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec2 xlv_TEXCOORD2;
					varying highp vec2 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR;
					varying highp vec4 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  highp vec4 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = tmpvar_1.xyz;
					  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
					  highp vec4 o_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7 = (tmpvar_4 * 0.5);
					  highp vec2 tmpvar_8;
					  tmpvar_8.x = tmpvar_7.x;
					  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
					  o_6.xy = (tmpvar_8 + tmpvar_7.w);
					  o_6.zw = tmpvar_4.zw;
					  tmpvar_3.xyw = o_6.xyw;
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = tmpvar_1.xyz;
					  tmpvar_3.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_9)).z);
					  tmpvar_2.xy = ((tmpvar_4.xy + tmpvar_4.w) * 0.5);
					  tmpvar_2.zw = tmpvar_4.zw;
					  gl_Position = tmpvar_4;
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD3 = ((_glesMultiTexCoord0.xy * _CutOut_ST.xy) + _CutOut_ST.zw);
					  xlv_COLOR = _glesColor;
					  xlv_TEXCOORD4 = tmpvar_3;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
					uniform sampler2D _MainTex;
					uniform sampler2D _CutOut;
					uniform sampler2D _BumpMap;
					uniform highp float _BumpAmt;
					uniform highp float _ColorStrength;
					uniform sampler2D _GrabTextureMobile;
					uniform highp vec4 _GrabTextureMobile_TexelSize;
					uniform lowp vec4 _TintColor;
					uniform sampler2D _CameraDepthTexture;
					uniform highp float _InvFade;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec2 xlv_TEXCOORD2;
					varying highp vec2 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR;
					varying highp vec4 xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec4 tmpvar_1;
					  highp vec4 tmpvar_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_2 = xlv_TEXCOORD0;
					  tmpvar_3 = xlv_COLOR;
					  lowp vec4 emission_4;
					  mediump vec4 col_5;
					  mediump vec2 bump_6;
					  if ((_InvFade > 0.0001)) {
					    lowp vec4 tmpvar_7;
					    tmpvar_7 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD4);
					    highp float z_8;
					    z_8 = tmpvar_7.x;
					    highp float tmpvar_9;
					    tmpvar_9 = clamp ((_InvFade * (
					      (1.0/(((_ZBufferParams.z * z_8) + _ZBufferParams.w)))
					     - xlv_TEXCOORD4.z)), 0.0, 1.0);
					    tmpvar_3.w = (xlv_COLOR.w * tmpvar_9);
					  };
					  lowp vec2 tmpvar_10;
					  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD1).xyz * 2.0) - 1.0).xy;
					  bump_6 = tmpvar_10;
					  tmpvar_2.xy = (((bump_6 * _BumpAmt) * (_GrabTextureMobile_TexelSize.xy * xlv_TEXCOORD0.z)) + xlv_TEXCOORD0.xy);
					  lowp vec4 tmpvar_11;
					  tmpvar_11 = texture2DProj (_GrabTextureMobile, tmpvar_2);
					  col_5 = tmpvar_11;
					  lowp vec4 tmpvar_12;
					  tmpvar_12 = (texture2D (_MainTex, xlv_TEXCOORD2) * tmpvar_3);
					  highp vec4 tmpvar_13;
					  tmpvar_13 = ((col_5 * tmpvar_3) + ((tmpvar_12 * _ColorStrength) * _TintColor));
					  emission_4.xyz = tmpvar_13.xyz;
					  emission_4.w = ((_TintColor.w * tmpvar_3.w) * (texture2D (_CutOut, xlv_TEXCOORD3) * tmpvar_3).w);
					  tmpvar_1 = emission_4;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "SOFTPARTICLES_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _BumpMap_ST;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _CutOut_ST;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					in mediump vec4 in_COLOR0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec2 vs_TEXCOORD2;
					out highp vec2 vs_TEXCOORD3;
					out mediump vec4 vs_COLOR0;
					out highp vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					float u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    u_xlat2.xy = u_xlat1.ww + u_xlat1.xy;
					    vs_TEXCOORD0.xy = u_xlat2.xy * vec2(0.5, 0.5);
					    vs_TEXCOORD0.zw = u_xlat1.zw;
					    vs_TEXCOORD4.w = u_xlat1.w;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _CutOut_ST.xy + _CutOut_ST.zw;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat3 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3;
					    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
					    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
					    vs_TEXCOORD4.z = (-u_xlat0.x);
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat1.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    u_xlat1.w = u_xlat0.x * 0.5;
					    vs_TEXCOORD4.xy = u_xlat1.zz + u_xlat1.xw;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _ZBufferParams;
					uniform 	float _BumpAmt;
					uniform 	float _ColorStrength;
					uniform 	vec4 _GrabTextureMobile_TexelSize;
					uniform 	mediump vec4 _TintColor;
					uniform 	float _InvFade;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _BumpMap;
					uniform lowp sampler2D _GrabTextureMobile;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _CutOut;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec2 vs_TEXCOORD2;
					in highp vec2 vs_TEXCOORD3;
					in mediump vec4 vs_COLOR0;
					in highp vec4 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec2 u_xlat0;
					mediump float u_xlat16_0;
					bool u_xlatb0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					mediump vec2 u_xlat16_2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_3;
					lowp vec3 u_xlat10_3;
					mediump float u_xlat16_13;
					lowp float u_xlat10_13;
					void main()
					{
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(9.99999975e-005<_InvFade);
					#else
					    u_xlatb0 = 9.99999975e-005<_InvFade;
					#endif
					    if(u_xlatb0){
					        u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
					        u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
					        u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
					        u_xlat0.x = float(1.0) / u_xlat0.x;
					        u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD4.z);
					        u_xlat0.x = u_xlat0.x * _InvFade;
					#ifdef UNITY_ADRENO_ES3
					        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					        u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
					        u_xlat16_0 = u_xlat0.x;
					    } else {
					        u_xlat16_0 = vs_COLOR0.w;
					    //ENDIF
					    }
					    u_xlat10_1.xy = texture(_BumpMap, vs_TEXCOORD1.xy).xy;
					    u_xlat16_2.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat1.xy = u_xlat16_2.xy * vec2(_BumpAmt);
					    u_xlat1.xy = u_xlat1.xy * _GrabTextureMobile_TexelSize.xy;
					    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD0.zz + vs_TEXCOORD0.xy;
					    u_xlat1.xy = u_xlat1.xy / vs_TEXCOORD0.ww;
					    u_xlat10_1.xyz = texture(_GrabTextureMobile, u_xlat1.xy).xyz;
					    u_xlat10_3.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
					    u_xlat16_3.xyz = u_xlat10_3.xyz * vs_COLOR0.xyz;
					    u_xlat10_13 = texture(_CutOut, vs_TEXCOORD3.xy).w;
					    u_xlat16_13 = u_xlat16_0 * u_xlat10_13;
					    u_xlat3.xyz = u_xlat16_3.xyz * vec3(vec3(_ColorStrength, _ColorStrength, _ColorStrength));
					    u_xlat3.xyz = u_xlat3.xyz * _TintColor.xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz + u_xlat3.xyz;
					    u_xlat16_2.x = u_xlat16_0 * _TintColor.w;
					    SV_Target0.w = u_xlat16_13 * u_xlat16_2.x;
					    SV_Target0.xyz = u_xlat1.xyz;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "SOFTPARTICLES_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _BumpMap_ST;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _CutOut_ST;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					in mediump vec4 in_COLOR0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec2 vs_TEXCOORD2;
					out highp vec2 vs_TEXCOORD3;
					out mediump vec4 vs_COLOR0;
					out highp vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					float u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    u_xlat2.xy = u_xlat1.ww + u_xlat1.xy;
					    vs_TEXCOORD0.xy = u_xlat2.xy * vec2(0.5, 0.5);
					    vs_TEXCOORD0.zw = u_xlat1.zw;
					    vs_TEXCOORD4.w = u_xlat1.w;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _CutOut_ST.xy + _CutOut_ST.zw;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat3 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3;
					    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
					    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
					    vs_TEXCOORD4.z = (-u_xlat0.x);
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat1.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    u_xlat1.w = u_xlat0.x * 0.5;
					    vs_TEXCOORD4.xy = u_xlat1.zz + u_xlat1.xw;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _ZBufferParams;
					uniform 	float _BumpAmt;
					uniform 	float _ColorStrength;
					uniform 	vec4 _GrabTextureMobile_TexelSize;
					uniform 	mediump vec4 _TintColor;
					uniform 	float _InvFade;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _BumpMap;
					uniform lowp sampler2D _GrabTextureMobile;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _CutOut;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec2 vs_TEXCOORD2;
					in highp vec2 vs_TEXCOORD3;
					in mediump vec4 vs_COLOR0;
					in highp vec4 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec2 u_xlat0;
					mediump float u_xlat16_0;
					bool u_xlatb0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					mediump vec2 u_xlat16_2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_3;
					lowp vec3 u_xlat10_3;
					mediump float u_xlat16_13;
					lowp float u_xlat10_13;
					void main()
					{
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(9.99999975e-005<_InvFade);
					#else
					    u_xlatb0 = 9.99999975e-005<_InvFade;
					#endif
					    if(u_xlatb0){
					        u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
					        u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
					        u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
					        u_xlat0.x = float(1.0) / u_xlat0.x;
					        u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD4.z);
					        u_xlat0.x = u_xlat0.x * _InvFade;
					#ifdef UNITY_ADRENO_ES3
					        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					        u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
					        u_xlat16_0 = u_xlat0.x;
					    } else {
					        u_xlat16_0 = vs_COLOR0.w;
					    //ENDIF
					    }
					    u_xlat10_1.xy = texture(_BumpMap, vs_TEXCOORD1.xy).xy;
					    u_xlat16_2.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat1.xy = u_xlat16_2.xy * vec2(_BumpAmt);
					    u_xlat1.xy = u_xlat1.xy * _GrabTextureMobile_TexelSize.xy;
					    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD0.zz + vs_TEXCOORD0.xy;
					    u_xlat1.xy = u_xlat1.xy / vs_TEXCOORD0.ww;
					    u_xlat10_1.xyz = texture(_GrabTextureMobile, u_xlat1.xy).xyz;
					    u_xlat10_3.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
					    u_xlat16_3.xyz = u_xlat10_3.xyz * vs_COLOR0.xyz;
					    u_xlat10_13 = texture(_CutOut, vs_TEXCOORD3.xy).w;
					    u_xlat16_13 = u_xlat16_0 * u_xlat10_13;
					    u_xlat3.xyz = u_xlat16_3.xyz * vec3(vec3(_ColorStrength, _ColorStrength, _ColorStrength));
					    u_xlat3.xyz = u_xlat3.xyz * _TintColor.xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz + u_xlat3.xyz;
					    u_xlat16_2.x = u_xlat16_0 * _TintColor.w;
					    SV_Target0.w = u_xlat16_13 * u_xlat16_2.x;
					    SV_Target0.xyz = u_xlat1.xyz;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "SOFTPARTICLES_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _BumpMap_ST;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _CutOut_ST;
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					in mediump vec4 in_COLOR0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec2 vs_TEXCOORD1;
					out highp vec2 vs_TEXCOORD2;
					out highp vec2 vs_TEXCOORD3;
					out mediump vec4 vs_COLOR0;
					out highp vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					float u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    u_xlat2.xy = u_xlat1.ww + u_xlat1.xy;
					    vs_TEXCOORD0.xy = u_xlat2.xy * vec2(0.5, 0.5);
					    vs_TEXCOORD0.zw = u_xlat1.zw;
					    vs_TEXCOORD4.w = u_xlat1.w;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _CutOut_ST.xy + _CutOut_ST.zw;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat3 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3;
					    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
					    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
					    vs_TEXCOORD4.z = (-u_xlat0.x);
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat1.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    u_xlat1.w = u_xlat0.x * 0.5;
					    vs_TEXCOORD4.xy = u_xlat1.zz + u_xlat1.xw;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _ZBufferParams;
					uniform 	float _BumpAmt;
					uniform 	float _ColorStrength;
					uniform 	vec4 _GrabTextureMobile_TexelSize;
					uniform 	mediump vec4 _TintColor;
					uniform 	float _InvFade;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _BumpMap;
					uniform lowp sampler2D _GrabTextureMobile;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _CutOut;
					in highp vec4 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec2 vs_TEXCOORD2;
					in highp vec2 vs_TEXCOORD3;
					in mediump vec4 vs_COLOR0;
					in highp vec4 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec2 u_xlat0;
					mediump float u_xlat16_0;
					bool u_xlatb0;
					vec3 u_xlat1;
					lowp vec3 u_xlat10_1;
					mediump vec2 u_xlat16_2;
					vec3 u_xlat3;
					mediump vec3 u_xlat16_3;
					lowp vec3 u_xlat10_3;
					mediump float u_xlat16_13;
					lowp float u_xlat10_13;
					void main()
					{
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(9.99999975e-005<_InvFade);
					#else
					    u_xlatb0 = 9.99999975e-005<_InvFade;
					#endif
					    if(u_xlatb0){
					        u_xlat0.xy = vs_TEXCOORD4.xy / vs_TEXCOORD4.ww;
					        u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
					        u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
					        u_xlat0.x = float(1.0) / u_xlat0.x;
					        u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD4.z);
					        u_xlat0.x = u_xlat0.x * _InvFade;
					#ifdef UNITY_ADRENO_ES3
					        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					        u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
					        u_xlat16_0 = u_xlat0.x;
					    } else {
					        u_xlat16_0 = vs_COLOR0.w;
					    //ENDIF
					    }
					    u_xlat10_1.xy = texture(_BumpMap, vs_TEXCOORD1.xy).xy;
					    u_xlat16_2.xy = u_xlat10_1.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat1.xy = u_xlat16_2.xy * vec2(_BumpAmt);
					    u_xlat1.xy = u_xlat1.xy * _GrabTextureMobile_TexelSize.xy;
					    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD0.zz + vs_TEXCOORD0.xy;
					    u_xlat1.xy = u_xlat1.xy / vs_TEXCOORD0.ww;
					    u_xlat10_1.xyz = texture(_GrabTextureMobile, u_xlat1.xy).xyz;
					    u_xlat10_3.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
					    u_xlat16_3.xyz = u_xlat10_3.xyz * vs_COLOR0.xyz;
					    u_xlat10_13 = texture(_CutOut, vs_TEXCOORD3.xy).w;
					    u_xlat16_13 = u_xlat16_0 * u_xlat10_13;
					    u_xlat3.xyz = u_xlat16_3.xyz * vec3(vec3(_ColorStrength, _ColorStrength, _ColorStrength));
					    u_xlat3.xyz = u_xlat3.xyz * _TintColor.xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz + u_xlat3.xyz;
					    u_xlat16_2.x = u_xlat16_0 * _TintColor.w;
					    SV_Target0.w = u_xlat16_13 * u_xlat16_2.x;
					    SV_Target0.xyz = u_xlat1.xyz;
					    return;
					}
					
					#endif"
				}
				SubProgram "vulkan hw_tier00 " {
					Keywords { "SOFTPARTICLES_ON" }
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 1
					; Bound: 219
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Vertex %4 "main" %11 %80 %96 %107 %115 %117 %128 %139 %150 %151 
					                                                      OpDecorate %11 Location 11 
					                                                      OpDecorate %16 ArrayStride 16 
					                                                      OpDecorate %17 ArrayStride 17 
					                                                      OpDecorate %18 ArrayStride 18 
					                                                      OpMemberDecorate %19 0 Offset 19 
					                                                      OpMemberDecorate %19 1 Offset 19 
					                                                      OpMemberDecorate %19 2 Offset 19 
					                                                      OpMemberDecorate %19 3 Offset 19 
					                                                      OpMemberDecorate %19 4 Offset 19 
					                                                      OpMemberDecorate %19 5 Offset 19 
					                                                      OpMemberDecorate %19 6 Offset 19 
					                                                      OpDecorate %19 Block 
					                                                      OpDecorate %21 DescriptorSet 21 
					                                                      OpDecorate %21 Binding 21 
					                                                      OpMemberDecorate %78 0 BuiltIn 78 
					                                                      OpMemberDecorate %78 1 BuiltIn 78 
					                                                      OpMemberDecorate %78 2 BuiltIn 78 
					                                                      OpDecorate %78 Block 
					                                                      OpDecorate %96 Location 96 
					                                                      OpDecorate %107 Location 107 
					                                                      OpDecorate %115 Location 115 
					                                                      OpDecorate %117 Location 117 
					                                                      OpDecorate %128 Location 128 
					                                                      OpDecorate %139 Location 139 
					                                                      OpDecorate %150 RelaxedPrecision 
					                                                      OpDecorate %150 Location 150 
					                                                      OpDecorate %151 RelaxedPrecision 
					                                                      OpDecorate %151 Location 151 
					                                                      OpDecorate %152 RelaxedPrecision 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 4 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_4* %9 = OpVariable Private 
					                                              %10 = OpTypePointer Input %7 
					                                 Input f32_4* %11 = OpVariable Input 
					                                              %14 = OpTypeInt 32 0 
					                                          u32 %15 = OpConstant 4 
					                                              %16 = OpTypeArray %7 %15 
					                                              %17 = OpTypeArray %7 %15 
					                                              %18 = OpTypeArray %7 %15 
					                                              %19 = OpTypeStruct %7 %16 %17 %18 %7 %7 %7 
					                                              %20 = OpTypePointer Uniform %19 
					Uniform struct {f32_4; f32_4[4]; f32_4[4]; f32_4[4]; f32_4; f32_4; f32_4;}* %21 = OpVariable Uniform 
					                                              %22 = OpTypeInt 32 1 
					                                          i32 %23 = OpConstant 1 
					                                              %24 = OpTypePointer Uniform %7 
					                                          i32 %28 = OpConstant 0 
					                                          i32 %36 = OpConstant 2 
					                                          i32 %45 = OpConstant 3 
					                               Private f32_4* %49 = OpVariable Private 
					                                          u32 %76 = OpConstant 1 
					                                              %77 = OpTypeArray %6 %76 
					                                              %78 = OpTypeStruct %7 %6 %77 
					                                              %79 = OpTypePointer Output %78 
					         Output struct {f32_4; f32; f32[1];}* %80 = OpVariable Output 
					                                              %82 = OpTypePointer Output %7 
					                                              %84 = OpTypeVector %6 2 
					                                              %85 = OpTypePointer Private %84 
					                               Private f32_2* %86 = OpVariable Private 
					                                          f32 %89 = OpConstant 3.674022E-40 
					                                          f32 %90 = OpConstant 3.674022E-40 
					                                        f32_2 %91 = OpConstantComposite %89 %90 
					                                Output f32_4* %96 = OpVariable Output 
					                                          f32 %98 = OpConstant 3.674022E-40 
					                                        f32_2 %99 = OpConstantComposite %98 %98 
					                               Output f32_4* %107 = OpVariable Output 
					                                         u32 %108 = OpConstant 3 
					                                             %109 = OpTypePointer Private %6 
					                                             %112 = OpTypePointer Output %6 
					                                             %114 = OpTypePointer Output %84 
					                               Output f32_2* %115 = OpVariable Output 
					                                             %116 = OpTypePointer Input %84 
					                                Input f32_2* %117 = OpVariable Input 
					                                         i32 %119 = OpConstant 4 
					                               Output f32_2* %128 = OpVariable Output 
					                                         i32 %130 = OpConstant 5 
					                               Output f32_2* %139 = OpVariable Output 
					                                         i32 %141 = OpConstant 6 
					                               Output f32_4* %150 = OpVariable Output 
					                                Input f32_4* %151 = OpVariable Input 
					                                Private f32* %153 = OpVariable Private 
					                                         u32 %156 = OpConstant 2 
					                                             %157 = OpTypePointer Uniform %6 
					                                         u32 %163 = OpConstant 0 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                        f32_4 %12 = OpLoad %11 
					                                        f32_4 %13 = OpVectorShuffle %12 %12 1 1 1 1 
					                               Uniform f32_4* %25 = OpAccessChain %21 %23 %23 
					                                        f32_4 %26 = OpLoad %25 
					                                        f32_4 %27 = OpFMul %13 %26 
					                                                      OpStore %9 %27 
					                               Uniform f32_4* %29 = OpAccessChain %21 %23 %28 
					                                        f32_4 %30 = OpLoad %29 
					                                        f32_4 %31 = OpLoad %11 
					                                        f32_4 %32 = OpVectorShuffle %31 %31 0 0 0 0 
					                                        f32_4 %33 = OpFMul %30 %32 
					                                        f32_4 %34 = OpLoad %9 
					                                        f32_4 %35 = OpFAdd %33 %34 
					                                                      OpStore %9 %35 
					                               Uniform f32_4* %37 = OpAccessChain %21 %23 %36 
					                                        f32_4 %38 = OpLoad %37 
					                                        f32_4 %39 = OpLoad %11 
					                                        f32_4 %40 = OpVectorShuffle %39 %39 2 2 2 2 
					                                        f32_4 %41 = OpFMul %38 %40 
					                                        f32_4 %42 = OpLoad %9 
					                                        f32_4 %43 = OpFAdd %41 %42 
					                                                      OpStore %9 %43 
					                                        f32_4 %44 = OpLoad %9 
					                               Uniform f32_4* %46 = OpAccessChain %21 %23 %45 
					                                        f32_4 %47 = OpLoad %46 
					                                        f32_4 %48 = OpFAdd %44 %47 
					                                                      OpStore %9 %48 
					                                        f32_4 %50 = OpLoad %9 
					                                        f32_4 %51 = OpVectorShuffle %50 %50 1 1 1 1 
					                               Uniform f32_4* %52 = OpAccessChain %21 %45 %23 
					                                        f32_4 %53 = OpLoad %52 
					                                        f32_4 %54 = OpFMul %51 %53 
					                                                      OpStore %49 %54 
					                               Uniform f32_4* %55 = OpAccessChain %21 %45 %28 
					                                        f32_4 %56 = OpLoad %55 
					                                        f32_4 %57 = OpLoad %9 
					                                        f32_4 %58 = OpVectorShuffle %57 %57 0 0 0 0 
					                                        f32_4 %59 = OpFMul %56 %58 
					                                        f32_4 %60 = OpLoad %49 
					                                        f32_4 %61 = OpFAdd %59 %60 
					                                                      OpStore %49 %61 
					                               Uniform f32_4* %62 = OpAccessChain %21 %45 %36 
					                                        f32_4 %63 = OpLoad %62 
					                                        f32_4 %64 = OpLoad %9 
					                                        f32_4 %65 = OpVectorShuffle %64 %64 2 2 2 2 
					                                        f32_4 %66 = OpFMul %63 %65 
					                                        f32_4 %67 = OpLoad %49 
					                                        f32_4 %68 = OpFAdd %66 %67 
					                                                      OpStore %49 %68 
					                               Uniform f32_4* %69 = OpAccessChain %21 %45 %45 
					                                        f32_4 %70 = OpLoad %69 
					                                        f32_4 %71 = OpLoad %9 
					                                        f32_4 %72 = OpVectorShuffle %71 %71 3 3 3 3 
					                                        f32_4 %73 = OpFMul %70 %72 
					                                        f32_4 %74 = OpLoad %49 
					                                        f32_4 %75 = OpFAdd %73 %74 
					                                                      OpStore %49 %75 
					                                        f32_4 %81 = OpLoad %49 
					                                Output f32_4* %83 = OpAccessChain %80 %28 
					                                                      OpStore %83 %81 
					                                        f32_4 %87 = OpLoad %49 
					                                        f32_2 %88 = OpVectorShuffle %87 %87 0 1 
					                                        f32_2 %92 = OpFMul %88 %91 
					                                        f32_4 %93 = OpLoad %49 
					                                        f32_2 %94 = OpVectorShuffle %93 %93 3 3 
					                                        f32_2 %95 = OpFAdd %92 %94 
					                                                      OpStore %86 %95 
					                                        f32_2 %97 = OpLoad %86 
					                                       f32_2 %100 = OpFMul %97 %99 
					                                       f32_4 %101 = OpLoad %96 
					                                       f32_4 %102 = OpVectorShuffle %101 %100 4 5 2 3 
					                                                      OpStore %96 %102 
					                                       f32_4 %103 = OpLoad %49 
					                                       f32_2 %104 = OpVectorShuffle %103 %103 2 3 
					                                       f32_4 %105 = OpLoad %96 
					                                       f32_4 %106 = OpVectorShuffle %105 %104 0 1 4 5 
					                                                      OpStore %96 %106 
					                                Private f32* %110 = OpAccessChain %49 %108 
					                                         f32 %111 = OpLoad %110 
					                                 Output f32* %113 = OpAccessChain %107 %108 
					                                                      OpStore %113 %111 
					                                       f32_2 %118 = OpLoad %117 
					                              Uniform f32_4* %120 = OpAccessChain %21 %119 
					                                       f32_4 %121 = OpLoad %120 
					                                       f32_2 %122 = OpVectorShuffle %121 %121 0 1 
					                                       f32_2 %123 = OpFMul %118 %122 
					                              Uniform f32_4* %124 = OpAccessChain %21 %119 
					                                       f32_4 %125 = OpLoad %124 
					                                       f32_2 %126 = OpVectorShuffle %125 %125 2 3 
					                                       f32_2 %127 = OpFAdd %123 %126 
					                                                      OpStore %115 %127 
					                                       f32_2 %129 = OpLoad %117 
					                              Uniform f32_4* %131 = OpAccessChain %21 %130 
					                                       f32_4 %132 = OpLoad %131 
					                                       f32_2 %133 = OpVectorShuffle %132 %132 0 1 
					                                       f32_2 %134 = OpFMul %129 %133 
					                              Uniform f32_4* %135 = OpAccessChain %21 %130 
					                                       f32_4 %136 = OpLoad %135 
					                                       f32_2 %137 = OpVectorShuffle %136 %136 2 3 
					                                       f32_2 %138 = OpFAdd %134 %137 
					                                                      OpStore %128 %138 
					                                       f32_2 %140 = OpLoad %117 
					                              Uniform f32_4* %142 = OpAccessChain %21 %141 
					                                       f32_4 %143 = OpLoad %142 
					                                       f32_2 %144 = OpVectorShuffle %143 %143 0 1 
					                                       f32_2 %145 = OpFMul %140 %144 
					                              Uniform f32_4* %146 = OpAccessChain %21 %141 
					                                       f32_4 %147 = OpLoad %146 
					                                       f32_2 %148 = OpVectorShuffle %147 %147 2 3 
					                                       f32_2 %149 = OpFAdd %145 %148 
					                                                      OpStore %139 %149 
					                                       f32_4 %152 = OpLoad %151 
					                                                      OpStore %150 %152 
					                                Private f32* %154 = OpAccessChain %9 %76 
					                                         f32 %155 = OpLoad %154 
					                                Uniform f32* %158 = OpAccessChain %21 %36 %23 %156 
					                                         f32 %159 = OpLoad %158 
					                                         f32 %160 = OpFMul %155 %159 
					                                                      OpStore %153 %160 
					                                Uniform f32* %161 = OpAccessChain %21 %36 %28 %156 
					                                         f32 %162 = OpLoad %161 
					                                Private f32* %164 = OpAccessChain %9 %163 
					                                         f32 %165 = OpLoad %164 
					                                         f32 %166 = OpFMul %162 %165 
					                                         f32 %167 = OpLoad %153 
					                                         f32 %168 = OpFAdd %166 %167 
					                                Private f32* %169 = OpAccessChain %9 %163 
					                                                      OpStore %169 %168 
					                                Uniform f32* %170 = OpAccessChain %21 %36 %36 %156 
					                                         f32 %171 = OpLoad %170 
					                                Private f32* %172 = OpAccessChain %9 %156 
					                                         f32 %173 = OpLoad %172 
					                                         f32 %174 = OpFMul %171 %173 
					                                Private f32* %175 = OpAccessChain %9 %163 
					                                         f32 %176 = OpLoad %175 
					                                         f32 %177 = OpFAdd %174 %176 
					                                Private f32* %178 = OpAccessChain %9 %163 
					                                                      OpStore %178 %177 
					                                Uniform f32* %179 = OpAccessChain %21 %36 %45 %156 
					                                         f32 %180 = OpLoad %179 
					                                Private f32* %181 = OpAccessChain %9 %108 
					                                         f32 %182 = OpLoad %181 
					                                         f32 %183 = OpFMul %180 %182 
					                                Private f32* %184 = OpAccessChain %9 %163 
					                                         f32 %185 = OpLoad %184 
					                                         f32 %186 = OpFAdd %183 %185 
					                                Private f32* %187 = OpAccessChain %9 %163 
					                                                      OpStore %187 %186 
					                                Private f32* %188 = OpAccessChain %9 %163 
					                                         f32 %189 = OpLoad %188 
					                                         f32 %190 = OpFNegate %189 
					                                 Output f32* %191 = OpAccessChain %107 %156 
					                                                      OpStore %191 %190 
					                                Private f32* %192 = OpAccessChain %49 %76 
					                                         f32 %193 = OpLoad %192 
					                                Uniform f32* %194 = OpAccessChain %21 %28 %163 
					                                         f32 %195 = OpLoad %194 
					                                         f32 %196 = OpFMul %193 %195 
					                                Private f32* %197 = OpAccessChain %9 %163 
					                                                      OpStore %197 %196 
					                                       f32_4 %198 = OpLoad %49 
					                                       f32_2 %199 = OpVectorShuffle %198 %198 0 3 
					                                       f32_2 %200 = OpFMul %199 %99 
					                                       f32_4 %201 = OpLoad %49 
					                                       f32_4 %202 = OpVectorShuffle %201 %200 4 1 5 3 
					                                                      OpStore %49 %202 
					                                Private f32* %203 = OpAccessChain %9 %163 
					                                         f32 %204 = OpLoad %203 
					                                         f32 %205 = OpFMul %204 %98 
					                                Private f32* %206 = OpAccessChain %49 %108 
					                                                      OpStore %206 %205 
					                                       f32_4 %207 = OpLoad %49 
					                                       f32_2 %208 = OpVectorShuffle %207 %207 2 2 
					                                       f32_4 %209 = OpLoad %49 
					                                       f32_2 %210 = OpVectorShuffle %209 %209 0 3 
					                                       f32_2 %211 = OpFAdd %208 %210 
					                                       f32_4 %212 = OpLoad %107 
					                                       f32_4 %213 = OpVectorShuffle %212 %211 4 5 2 3 
					                                                      OpStore %107 %213 
					                                 Output f32* %214 = OpAccessChain %80 %28 %76 
					                                         f32 %215 = OpLoad %214 
					                                         f32 %216 = OpFNegate %215 
					                                 Output f32* %217 = OpAccessChain %80 %28 %76 
					                                                      OpStore %217 %216 
					                                                      OpReturn
					                                                      OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 1
					; Bound: 232
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Fragment %4 "main" %34 %90 %107 %143 %168 %180 %221 
					                                                      OpExecutionMode %4 OriginUpperLeft 
					                                                      OpMemberDecorate %12 0 Offset 12 
					                                                      OpMemberDecorate %12 1 Offset 12 
					                                                      OpMemberDecorate %12 2 Offset 12 
					                                                      OpMemberDecorate %12 3 Offset 12 
					                                                      OpMemberDecorate %12 4 RelaxedPrecision 
					                                                      OpMemberDecorate %12 4 Offset 12 
					                                                      OpMemberDecorate %12 5 Offset 12 
					                                                      OpDecorate %12 Block 
					                                                      OpDecorate %14 DescriptorSet 14 
					                                                      OpDecorate %14 Binding 14 
					                                                      OpDecorate %27 SpecId 27 
					                                                      OpDecorate %34 Location 34 
					                                                      OpDecorate %43 DescriptorSet 43 
					                                                      OpDecorate %43 Binding 43 
					                                                      OpDecorate %90 RelaxedPrecision 
					                                                      OpDecorate %90 Location 90 
					                                                      OpDecorate %92 RelaxedPrecision 
					                                                      OpDecorate %95 RelaxedPrecision 
					                                                      OpDecorate %100 RelaxedPrecision 
					                                                      OpDecorate %103 RelaxedPrecision 
					                                                      OpDecorate %104 RelaxedPrecision 
					                                                      OpDecorate %104 DescriptorSet 104 
					                                                      OpDecorate %104 Binding 104 
					                                                      OpDecorate %105 RelaxedPrecision 
					                                                      OpDecorate %107 Location 107 
					                                                      OpDecorate %110 RelaxedPrecision 
					                                                      OpDecorate %113 RelaxedPrecision 
					                                                      OpDecorate %114 RelaxedPrecision 
					                                                      OpDecorate %115 RelaxedPrecision 
					                                                      OpDecorate %118 RelaxedPrecision 
					                                                      OpDecorate %121 RelaxedPrecision 
					                                                      OpDecorate %123 RelaxedPrecision 
					                                                      OpDecorate %127 RelaxedPrecision 
					                                                      OpDecorate %128 RelaxedPrecision 
					                                                      OpDecorate %143 Location 143 
					                                                      OpDecorate %159 RelaxedPrecision 
					                                                      OpDecorate %159 DescriptorSet 159 
					                                                      OpDecorate %159 Binding 159 
					                                                      OpDecorate %160 RelaxedPrecision 
					                                                      OpDecorate %164 RelaxedPrecision 
					                                                      OpDecorate %165 RelaxedPrecision 
					                                                      OpDecorate %166 RelaxedPrecision 
					                                                      OpDecorate %166 DescriptorSet 166 
					                                                      OpDecorate %166 Binding 166 
					                                                      OpDecorate %167 RelaxedPrecision 
					                                                      OpDecorate %168 Location 168 
					                                                      OpDecorate %171 RelaxedPrecision 
					                                                      OpDecorate %172 RelaxedPrecision 
					                                                      OpDecorate %173 RelaxedPrecision 
					                                                      OpDecorate %174 RelaxedPrecision 
					                                                      OpDecorate %175 RelaxedPrecision 
					                                                      OpDecorate %176 RelaxedPrecision 
					                                                      OpDecorate %177 RelaxedPrecision 
					                                                      OpDecorate %178 RelaxedPrecision 
					                                                      OpDecorate %178 DescriptorSet 178 
					                                                      OpDecorate %178 Binding 178 
					                                                      OpDecorate %179 RelaxedPrecision 
					                                                      OpDecorate %180 Location 180 
					                                                      OpDecorate %183 RelaxedPrecision 
					                                                      OpDecorate %184 RelaxedPrecision 
					                                                      OpDecorate %185 RelaxedPrecision 
					                                                      OpDecorate %186 RelaxedPrecision 
					                                                      OpDecorate %187 RelaxedPrecision 
					                                                      OpDecorate %189 RelaxedPrecision 
					                                                      OpDecorate %197 RelaxedPrecision 
					                                                      OpDecorate %198 RelaxedPrecision 
					                                                      OpDecorate %199 RelaxedPrecision 
					                                                      OpDecorate %200 RelaxedPrecision 
					                                                      OpDecorate %201 RelaxedPrecision 
					                                                      OpDecorate %202 RelaxedPrecision 
					                                                      OpDecorate %206 RelaxedPrecision 
					                                                      OpDecorate %207 RelaxedPrecision 
					                                                      OpDecorate %209 RelaxedPrecision 
					                                                      OpDecorate %210 RelaxedPrecision 
					                                                      OpDecorate %211 RelaxedPrecision 
					                                                      OpDecorate %212 RelaxedPrecision 
					                                                      OpDecorate %215 RelaxedPrecision 
					                                                      OpDecorate %217 RelaxedPrecision 
					                                                      OpDecorate %218 RelaxedPrecision 
					                                                      OpDecorate %221 RelaxedPrecision 
					                                                      OpDecorate %221 Location 221 
					                                                      OpDecorate %222 RelaxedPrecision 
					                                                      OpDecorate %224 RelaxedPrecision 
					                                                      OpDecorate %225 RelaxedPrecision 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeBool 
					                                               %7 = OpTypePointer Private %6 
					                                 Private bool* %8 = OpVariable Private 
					                                               %9 = OpTypeFloat 32 
					                                          f32 %10 = OpConstant 3.674022E-40 
					                                              %11 = OpTypeVector %9 4 
					                                              %12 = OpTypeStruct %11 %9 %9 %11 %11 %9 
					                                              %13 = OpTypePointer Uniform %12 
					Uniform struct {f32_4; f32; f32; f32_4; f32_4; f32;}* %14 = OpVariable Uniform 
					                                              %15 = OpTypeInt 32 1 
					                                          i32 %16 = OpConstant 5 
					                                              %17 = OpTypePointer Uniform %9 
					                                         bool %21 = OpConstantFalse 
					                                         bool %27 = OpSpecConstantFalse 
					                                              %30 = OpTypeVector %9 2 
					                                              %31 = OpTypePointer Private %30 
					                               Private f32_2* %32 = OpVariable Private 
					                                              %33 = OpTypePointer Input %11 
					                                 Input f32_4* %34 = OpVariable Input 
					                                              %40 = OpTypeImage %9 Dim2D 0 0 0 1 Unknown 
					                                              %41 = OpTypeSampledImage %40 
					                                              %42 = OpTypePointer UniformConstant %41 
					  UniformConstant read_only Texture2DSampled* %43 = OpVariable UniformConstant 
					                                              %47 = OpTypeInt 32 0 
					                                          u32 %48 = OpConstant 0 
					                                              %50 = OpTypePointer Private %9 
					                                          i32 %52 = OpConstant 0 
					                                          u32 %53 = OpConstant 2 
					                                          u32 %59 = OpConstant 3 
					                                          f32 %64 = OpConstant 3.674022E-40 
					                                              %71 = OpTypePointer Input %9 
					                                          f32 %85 = OpConstant 3.674022E-40 
					                                 Input f32_4* %90 = OpVariable Input 
					                                 Private f32* %95 = OpVariable Private 
					                                             %101 = OpTypeVector %9 3 
					                                             %102 = OpTypePointer Private %101 
					                              Private f32_3* %103 = OpVariable Private 
					 UniformConstant read_only Texture2DSampled* %104 = OpVariable UniformConstant 
					                                             %106 = OpTypePointer Input %30 
					                                Input f32_2* %107 = OpVariable Input 
					                              Private f32_2* %113 = OpVariable Private 
					                                         f32 %116 = OpConstant 3.674022E-40 
					                                       f32_2 %117 = OpConstantComposite %116 %116 
					                                         f32 %119 = OpConstant 3.674022E-40 
					                                       f32_2 %120 = OpConstantComposite %119 %119 
					                              Private f32_3* %122 = OpVariable Private 
					                                         i32 %124 = OpConstant 1 
					                                         i32 %133 = OpConstant 3 
					                                             %134 = OpTypePointer Uniform %11 
					                                Input f32_4* %143 = OpVariable Input 
					 UniformConstant read_only Texture2DSampled* %159 = OpVariable UniformConstant 
					                              Private f32_3* %165 = OpVariable Private 
					 UniformConstant read_only Texture2DSampled* %166 = OpVariable UniformConstant 
					                                Input f32_2* %168 = OpVariable Input 
					                              Private f32_3* %172 = OpVariable Private 
					                                Private f32* %177 = OpVariable Private 
					 UniformConstant read_only Texture2DSampled* %178 = OpVariable UniformConstant 
					                                Input f32_2* %180 = OpVariable Input 
					                                Private f32* %184 = OpVariable Private 
					                              Private f32_3* %188 = OpVariable Private 
					                                         i32 %190 = OpConstant 2 
					                                         i32 %204 = OpConstant 4 
					                                             %220 = OpTypePointer Output %11 
					                               Output f32_4* %221 = OpVariable Output 
					                                             %226 = OpTypePointer Output %9 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                 Uniform f32* %18 = OpAccessChain %14 %16 
					                                          f32 %19 = OpLoad %18 
					                                         bool %20 = OpFOrdLessThan %10 %19 
					                                                      OpStore %8 %20 
					                                                      OpSelectionMerge %23 None 
					                                                      OpBranchConditional %21 %22 %23 
					                                              %22 = OpLabel 
					                                         bool %24 = OpLoad %8 
					                                                      OpSelectionMerge %26 None 
					                                                      OpBranchConditional %24 %25 %26 
					                                              %25 = OpLabel 
					                                                      OpBranch %26 
					                                              %26 = OpLabel 
					                                                      OpBranch %23 
					                                              %23 = OpLabel 
					                                                      OpSelectionMerge %29 None 
					                                                      OpBranchConditional %27 %28 %98 
					                                              %28 = OpLabel 
					                                        f32_4 %35 = OpLoad %34 
					                                        f32_2 %36 = OpVectorShuffle %35 %35 0 1 
					                                        f32_4 %37 = OpLoad %34 
					                                        f32_2 %38 = OpVectorShuffle %37 %37 3 3 
					                                        f32_2 %39 = OpFDiv %36 %38 
					                                                      OpStore %32 %39 
					                   read_only Texture2DSampled %44 = OpLoad %43 
					                                        f32_2 %45 = OpLoad %32 
					                                        f32_4 %46 = OpImageSampleImplicitLod %44 %45 
					                                          f32 %49 = OpCompositeExtract %46 0 
					                                 Private f32* %51 = OpAccessChain %32 %48 
					                                                      OpStore %51 %49 
					                                 Uniform f32* %54 = OpAccessChain %14 %52 %53 
					                                          f32 %55 = OpLoad %54 
					                                 Private f32* %56 = OpAccessChain %32 %48 
					                                          f32 %57 = OpLoad %56 
					                                          f32 %58 = OpFMul %55 %57 
					                                 Uniform f32* %60 = OpAccessChain %14 %52 %59 
					                                          f32 %61 = OpLoad %60 
					                                          f32 %62 = OpFAdd %58 %61 
					                                 Private f32* %63 = OpAccessChain %32 %48 
					                                                      OpStore %63 %62 
					                                 Private f32* %65 = OpAccessChain %32 %48 
					                                          f32 %66 = OpLoad %65 
					                                          f32 %67 = OpFDiv %64 %66 
					                                 Private f32* %68 = OpAccessChain %32 %48 
					                                                      OpStore %68 %67 
					                                 Private f32* %69 = OpAccessChain %32 %48 
					                                          f32 %70 = OpLoad %69 
					                                   Input f32* %72 = OpAccessChain %34 %53 
					                                          f32 %73 = OpLoad %72 
					                                          f32 %74 = OpFNegate %73 
					                                          f32 %75 = OpFAdd %70 %74 
					                                 Private f32* %76 = OpAccessChain %32 %48 
					                                                      OpStore %76 %75 
					                                 Private f32* %77 = OpAccessChain %32 %48 
					                                          f32 %78 = OpLoad %77 
					                                 Uniform f32* %79 = OpAccessChain %14 %16 
					                                          f32 %80 = OpLoad %79 
					                                          f32 %81 = OpFMul %78 %80 
					                                 Private f32* %82 = OpAccessChain %32 %48 
					                                                      OpStore %82 %81 
					                                 Private f32* %83 = OpAccessChain %32 %48 
					                                          f32 %84 = OpLoad %83 
					                                          f32 %86 = OpExtInst %1 43 %84 %85 %64 
					                                 Private f32* %87 = OpAccessChain %32 %48 
					                                                      OpStore %87 %86 
					                                 Private f32* %88 = OpAccessChain %32 %48 
					                                          f32 %89 = OpLoad %88 
					                                   Input f32* %91 = OpAccessChain %90 %59 
					                                          f32 %92 = OpLoad %91 
					                                          f32 %93 = OpFMul %89 %92 
					                                 Private f32* %94 = OpAccessChain %32 %48 
					                                                      OpStore %94 %93 
					                                 Private f32* %96 = OpAccessChain %32 %48 
					                                          f32 %97 = OpLoad %96 
					                                                      OpStore %95 %97 
					                                                      OpBranch %29 
					                                              %98 = OpLabel 
					                                   Input f32* %99 = OpAccessChain %90 %59 
					                                         f32 %100 = OpLoad %99 
					                                                      OpStore %95 %100 
					                                                      OpBranch %29 
					                                              %29 = OpLabel 
					                  read_only Texture2DSampled %105 = OpLoad %104 
					                                       f32_2 %108 = OpLoad %107 
					                                       f32_4 %109 = OpImageSampleImplicitLod %105 %108 
					                                       f32_2 %110 = OpVectorShuffle %109 %109 0 1 
					                                       f32_3 %111 = OpLoad %103 
					                                       f32_3 %112 = OpVectorShuffle %111 %110 3 4 2 
					                                                      OpStore %103 %112 
					                                       f32_3 %114 = OpLoad %103 
					                                       f32_2 %115 = OpVectorShuffle %114 %114 0 1 
					                                       f32_2 %118 = OpFMul %115 %117 
					                                       f32_2 %121 = OpFAdd %118 %120 
					                                                      OpStore %113 %121 
					                                       f32_2 %123 = OpLoad %113 
					                                Uniform f32* %125 = OpAccessChain %14 %124 
					                                         f32 %126 = OpLoad %125 
					                                       f32_2 %127 = OpCompositeConstruct %126 %126 
					                                       f32_2 %128 = OpFMul %123 %127 
					                                       f32_3 %129 = OpLoad %122 
					                                       f32_3 %130 = OpVectorShuffle %129 %128 3 4 2 
					                                                      OpStore %122 %130 
					                                       f32_3 %131 = OpLoad %122 
					                                       f32_2 %132 = OpVectorShuffle %131 %131 0 1 
					                              Uniform f32_4* %135 = OpAccessChain %14 %133 
					                                       f32_4 %136 = OpLoad %135 
					                                       f32_2 %137 = OpVectorShuffle %136 %136 0 1 
					                                       f32_2 %138 = OpFMul %132 %137 
					                                       f32_3 %139 = OpLoad %122 
					                                       f32_3 %140 = OpVectorShuffle %139 %138 3 4 2 
					                                                      OpStore %122 %140 
					                                       f32_3 %141 = OpLoad %122 
					                                       f32_2 %142 = OpVectorShuffle %141 %141 0 1 
					                                       f32_4 %144 = OpLoad %143 
					                                       f32_2 %145 = OpVectorShuffle %144 %144 2 2 
					                                       f32_2 %146 = OpFMul %142 %145 
					                                       f32_4 %147 = OpLoad %143 
					                                       f32_2 %148 = OpVectorShuffle %147 %147 0 1 
					                                       f32_2 %149 = OpFAdd %146 %148 
					                                       f32_3 %150 = OpLoad %122 
					                                       f32_3 %151 = OpVectorShuffle %150 %149 3 4 2 
					                                                      OpStore %122 %151 
					                                       f32_3 %152 = OpLoad %122 
					                                       f32_2 %153 = OpVectorShuffle %152 %152 0 1 
					                                       f32_4 %154 = OpLoad %143 
					                                       f32_2 %155 = OpVectorShuffle %154 %154 3 3 
					                                       f32_2 %156 = OpFDiv %153 %155 
					                                       f32_3 %157 = OpLoad %122 
					                                       f32_3 %158 = OpVectorShuffle %157 %156 3 4 2 
					                                                      OpStore %122 %158 
					                  read_only Texture2DSampled %160 = OpLoad %159 
					                                       f32_3 %161 = OpLoad %122 
					                                       f32_2 %162 = OpVectorShuffle %161 %161 0 1 
					                                       f32_4 %163 = OpImageSampleImplicitLod %160 %162 
					                                       f32_3 %164 = OpVectorShuffle %163 %163 0 1 2 
					                                                      OpStore %103 %164 
					                  read_only Texture2DSampled %167 = OpLoad %166 
					                                       f32_2 %169 = OpLoad %168 
					                                       f32_4 %170 = OpImageSampleImplicitLod %167 %169 
					                                       f32_3 %171 = OpVectorShuffle %170 %170 0 1 2 
					                                                      OpStore %165 %171 
					                                       f32_3 %173 = OpLoad %165 
					                                       f32_4 %174 = OpLoad %90 
					                                       f32_3 %175 = OpVectorShuffle %174 %174 0 1 2 
					                                       f32_3 %176 = OpFMul %173 %175 
					                                                      OpStore %172 %176 
					                  read_only Texture2DSampled %179 = OpLoad %178 
					                                       f32_2 %181 = OpLoad %180 
					                                       f32_4 %182 = OpImageSampleImplicitLod %179 %181 
					                                         f32 %183 = OpCompositeExtract %182 3 
					                                                      OpStore %177 %183 
					                                         f32 %185 = OpLoad %95 
					                                         f32 %186 = OpLoad %177 
					                                         f32 %187 = OpFMul %185 %186 
					                                                      OpStore %184 %187 
					                                       f32_3 %189 = OpLoad %172 
					                                Uniform f32* %191 = OpAccessChain %14 %190 
					                                         f32 %192 = OpLoad %191 
					                                Uniform f32* %193 = OpAccessChain %14 %190 
					                                         f32 %194 = OpLoad %193 
					                                Uniform f32* %195 = OpAccessChain %14 %190 
					                                         f32 %196 = OpLoad %195 
					                                       f32_3 %197 = OpCompositeConstruct %192 %194 %196 
					                                         f32 %198 = OpCompositeExtract %197 0 
					                                         f32 %199 = OpCompositeExtract %197 1 
					                                         f32 %200 = OpCompositeExtract %197 2 
					                                       f32_3 %201 = OpCompositeConstruct %198 %199 %200 
					                                       f32_3 %202 = OpFMul %189 %201 
					                                                      OpStore %188 %202 
					                                       f32_3 %203 = OpLoad %188 
					                              Uniform f32_4* %205 = OpAccessChain %14 %204 
					                                       f32_4 %206 = OpLoad %205 
					                                       f32_3 %207 = OpVectorShuffle %206 %206 0 1 2 
					                                       f32_3 %208 = OpFMul %203 %207 
					                                                      OpStore %188 %208 
					                                       f32_3 %209 = OpLoad %103 
					                                       f32_4 %210 = OpLoad %90 
					                                       f32_3 %211 = OpVectorShuffle %210 %210 0 1 2 
					                                       f32_3 %212 = OpFMul %209 %211 
					                                       f32_3 %213 = OpLoad %188 
					                                       f32_3 %214 = OpFAdd %212 %213 
					                                                      OpStore %122 %214 
					                                         f32 %215 = OpLoad %95 
					                                Uniform f32* %216 = OpAccessChain %14 %204 %59 
					                                         f32 %217 = OpLoad %216 
					                                         f32 %218 = OpFMul %215 %217 
					                                Private f32* %219 = OpAccessChain %113 %48 
					                                                      OpStore %219 %218 
					                                         f32 %222 = OpLoad %184 
					                                Private f32* %223 = OpAccessChain %113 %48 
					                                         f32 %224 = OpLoad %223 
					                                         f32 %225 = OpFMul %222 %224 
					                                 Output f32* %227 = OpAccessChain %221 %59 
					                                                      OpStore %227 %225 
					                                       f32_3 %228 = OpLoad %122 
					                                       f32_4 %229 = OpLoad %221 
					                                       f32_4 %230 = OpVectorShuffle %229 %228 4 5 6 3 
					                                                      OpStore %221 %230 
					                                                      OpReturn
					                                                      OpFunctionEnd"
				}
				SubProgram "vulkan hw_tier01 " {
					Keywords { "SOFTPARTICLES_ON" }
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 1
					; Bound: 219
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Vertex %4 "main" %11 %80 %96 %107 %115 %117 %128 %139 %150 %151 
					                                                      OpDecorate %11 Location 11 
					                                                      OpDecorate %16 ArrayStride 16 
					                                                      OpDecorate %17 ArrayStride 17 
					                                                      OpDecorate %18 ArrayStride 18 
					                                                      OpMemberDecorate %19 0 Offset 19 
					                                                      OpMemberDecorate %19 1 Offset 19 
					                                                      OpMemberDecorate %19 2 Offset 19 
					                                                      OpMemberDecorate %19 3 Offset 19 
					                                                      OpMemberDecorate %19 4 Offset 19 
					                                                      OpMemberDecorate %19 5 Offset 19 
					                                                      OpMemberDecorate %19 6 Offset 19 
					                                                      OpDecorate %19 Block 
					                                                      OpDecorate %21 DescriptorSet 21 
					                                                      OpDecorate %21 Binding 21 
					                                                      OpMemberDecorate %78 0 BuiltIn 78 
					                                                      OpMemberDecorate %78 1 BuiltIn 78 
					                                                      OpMemberDecorate %78 2 BuiltIn 78 
					                                                      OpDecorate %78 Block 
					                                                      OpDecorate %96 Location 96 
					                                                      OpDecorate %107 Location 107 
					                                                      OpDecorate %115 Location 115 
					                                                      OpDecorate %117 Location 117 
					                                                      OpDecorate %128 Location 128 
					                                                      OpDecorate %139 Location 139 
					                                                      OpDecorate %150 RelaxedPrecision 
					                                                      OpDecorate %150 Location 150 
					                                                      OpDecorate %151 RelaxedPrecision 
					                                                      OpDecorate %151 Location 151 
					                                                      OpDecorate %152 RelaxedPrecision 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 4 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_4* %9 = OpVariable Private 
					                                              %10 = OpTypePointer Input %7 
					                                 Input f32_4* %11 = OpVariable Input 
					                                              %14 = OpTypeInt 32 0 
					                                          u32 %15 = OpConstant 4 
					                                              %16 = OpTypeArray %7 %15 
					                                              %17 = OpTypeArray %7 %15 
					                                              %18 = OpTypeArray %7 %15 
					                                              %19 = OpTypeStruct %7 %16 %17 %18 %7 %7 %7 
					                                              %20 = OpTypePointer Uniform %19 
					Uniform struct {f32_4; f32_4[4]; f32_4[4]; f32_4[4]; f32_4; f32_4; f32_4;}* %21 = OpVariable Uniform 
					                                              %22 = OpTypeInt 32 1 
					                                          i32 %23 = OpConstant 1 
					                                              %24 = OpTypePointer Uniform %7 
					                                          i32 %28 = OpConstant 0 
					                                          i32 %36 = OpConstant 2 
					                                          i32 %45 = OpConstant 3 
					                               Private f32_4* %49 = OpVariable Private 
					                                          u32 %76 = OpConstant 1 
					                                              %77 = OpTypeArray %6 %76 
					                                              %78 = OpTypeStruct %7 %6 %77 
					                                              %79 = OpTypePointer Output %78 
					         Output struct {f32_4; f32; f32[1];}* %80 = OpVariable Output 
					                                              %82 = OpTypePointer Output %7 
					                                              %84 = OpTypeVector %6 2 
					                                              %85 = OpTypePointer Private %84 
					                               Private f32_2* %86 = OpVariable Private 
					                                          f32 %89 = OpConstant 3.674022E-40 
					                                          f32 %90 = OpConstant 3.674022E-40 
					                                        f32_2 %91 = OpConstantComposite %89 %90 
					                                Output f32_4* %96 = OpVariable Output 
					                                          f32 %98 = OpConstant 3.674022E-40 
					                                        f32_2 %99 = OpConstantComposite %98 %98 
					                               Output f32_4* %107 = OpVariable Output 
					                                         u32 %108 = OpConstant 3 
					                                             %109 = OpTypePointer Private %6 
					                                             %112 = OpTypePointer Output %6 
					                                             %114 = OpTypePointer Output %84 
					                               Output f32_2* %115 = OpVariable Output 
					                                             %116 = OpTypePointer Input %84 
					                                Input f32_2* %117 = OpVariable Input 
					                                         i32 %119 = OpConstant 4 
					                               Output f32_2* %128 = OpVariable Output 
					                                         i32 %130 = OpConstant 5 
					                               Output f32_2* %139 = OpVariable Output 
					                                         i32 %141 = OpConstant 6 
					                               Output f32_4* %150 = OpVariable Output 
					                                Input f32_4* %151 = OpVariable Input 
					                                Private f32* %153 = OpVariable Private 
					                                         u32 %156 = OpConstant 2 
					                                             %157 = OpTypePointer Uniform %6 
					                                         u32 %163 = OpConstant 0 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                        f32_4 %12 = OpLoad %11 
					                                        f32_4 %13 = OpVectorShuffle %12 %12 1 1 1 1 
					                               Uniform f32_4* %25 = OpAccessChain %21 %23 %23 
					                                        f32_4 %26 = OpLoad %25 
					                                        f32_4 %27 = OpFMul %13 %26 
					                                                      OpStore %9 %27 
					                               Uniform f32_4* %29 = OpAccessChain %21 %23 %28 
					                                        f32_4 %30 = OpLoad %29 
					                                        f32_4 %31 = OpLoad %11 
					                                        f32_4 %32 = OpVectorShuffle %31 %31 0 0 0 0 
					                                        f32_4 %33 = OpFMul %30 %32 
					                                        f32_4 %34 = OpLoad %9 
					                                        f32_4 %35 = OpFAdd %33 %34 
					                                                      OpStore %9 %35 
					                               Uniform f32_4* %37 = OpAccessChain %21 %23 %36 
					                                        f32_4 %38 = OpLoad %37 
					                                        f32_4 %39 = OpLoad %11 
					                                        f32_4 %40 = OpVectorShuffle %39 %39 2 2 2 2 
					                                        f32_4 %41 = OpFMul %38 %40 
					                                        f32_4 %42 = OpLoad %9 
					                                        f32_4 %43 = OpFAdd %41 %42 
					                                                      OpStore %9 %43 
					                                        f32_4 %44 = OpLoad %9 
					                               Uniform f32_4* %46 = OpAccessChain %21 %23 %45 
					                                        f32_4 %47 = OpLoad %46 
					                                        f32_4 %48 = OpFAdd %44 %47 
					                                                      OpStore %9 %48 
					                                        f32_4 %50 = OpLoad %9 
					                                        f32_4 %51 = OpVectorShuffle %50 %50 1 1 1 1 
					                               Uniform f32_4* %52 = OpAccessChain %21 %45 %23 
					                                        f32_4 %53 = OpLoad %52 
					                                        f32_4 %54 = OpFMul %51 %53 
					                                                      OpStore %49 %54 
					                               Uniform f32_4* %55 = OpAccessChain %21 %45 %28 
					                                        f32_4 %56 = OpLoad %55 
					                                        f32_4 %57 = OpLoad %9 
					                                        f32_4 %58 = OpVectorShuffle %57 %57 0 0 0 0 
					                                        f32_4 %59 = OpFMul %56 %58 
					                                        f32_4 %60 = OpLoad %49 
					                                        f32_4 %61 = OpFAdd %59 %60 
					                                                      OpStore %49 %61 
					                               Uniform f32_4* %62 = OpAccessChain %21 %45 %36 
					                                        f32_4 %63 = OpLoad %62 
					                                        f32_4 %64 = OpLoad %9 
					                                        f32_4 %65 = OpVectorShuffle %64 %64 2 2 2 2 
					                                        f32_4 %66 = OpFMul %63 %65 
					                                        f32_4 %67 = OpLoad %49 
					                                        f32_4 %68 = OpFAdd %66 %67 
					                                                      OpStore %49 %68 
					                               Uniform f32_4* %69 = OpAccessChain %21 %45 %45 
					                                        f32_4 %70 = OpLoad %69 
					                                        f32_4 %71 = OpLoad %9 
					                                        f32_4 %72 = OpVectorShuffle %71 %71 3 3 3 3 
					                                        f32_4 %73 = OpFMul %70 %72 
					                                        f32_4 %74 = OpLoad %49 
					                                        f32_4 %75 = OpFAdd %73 %74 
					                                                      OpStore %49 %75 
					                                        f32_4 %81 = OpLoad %49 
					                                Output f32_4* %83 = OpAccessChain %80 %28 
					                                                      OpStore %83 %81 
					                                        f32_4 %87 = OpLoad %49 
					                                        f32_2 %88 = OpVectorShuffle %87 %87 0 1 
					                                        f32_2 %92 = OpFMul %88 %91 
					                                        f32_4 %93 = OpLoad %49 
					                                        f32_2 %94 = OpVectorShuffle %93 %93 3 3 
					                                        f32_2 %95 = OpFAdd %92 %94 
					                                                      OpStore %86 %95 
					                                        f32_2 %97 = OpLoad %86 
					                                       f32_2 %100 = OpFMul %97 %99 
					                                       f32_4 %101 = OpLoad %96 
					                                       f32_4 %102 = OpVectorShuffle %101 %100 4 5 2 3 
					                                                      OpStore %96 %102 
					                                       f32_4 %103 = OpLoad %49 
					                                       f32_2 %104 = OpVectorShuffle %103 %103 2 3 
					                                       f32_4 %105 = OpLoad %96 
					                                       f32_4 %106 = OpVectorShuffle %105 %104 0 1 4 5 
					                                                      OpStore %96 %106 
					                                Private f32* %110 = OpAccessChain %49 %108 
					                                         f32 %111 = OpLoad %110 
					                                 Output f32* %113 = OpAccessChain %107 %108 
					                                                      OpStore %113 %111 
					                                       f32_2 %118 = OpLoad %117 
					                              Uniform f32_4* %120 = OpAccessChain %21 %119 
					                                       f32_4 %121 = OpLoad %120 
					                                       f32_2 %122 = OpVectorShuffle %121 %121 0 1 
					                                       f32_2 %123 = OpFMul %118 %122 
					                              Uniform f32_4* %124 = OpAccessChain %21 %119 
					                                       f32_4 %125 = OpLoad %124 
					                                       f32_2 %126 = OpVectorShuffle %125 %125 2 3 
					                                       f32_2 %127 = OpFAdd %123 %126 
					                                                      OpStore %115 %127 
					                                       f32_2 %129 = OpLoad %117 
					                              Uniform f32_4* %131 = OpAccessChain %21 %130 
					                                       f32_4 %132 = OpLoad %131 
					                                       f32_2 %133 = OpVectorShuffle %132 %132 0 1 
					                                       f32_2 %134 = OpFMul %129 %133 
					                              Uniform f32_4* %135 = OpAccessChain %21 %130 
					                                       f32_4 %136 = OpLoad %135 
					                                       f32_2 %137 = OpVectorShuffle %136 %136 2 3 
					                                       f32_2 %138 = OpFAdd %134 %137 
					                                                      OpStore %128 %138 
					                                       f32_2 %140 = OpLoad %117 
					                              Uniform f32_4* %142 = OpAccessChain %21 %141 
					                                       f32_4 %143 = OpLoad %142 
					                                       f32_2 %144 = OpVectorShuffle %143 %143 0 1 
					                                       f32_2 %145 = OpFMul %140 %144 
					                              Uniform f32_4* %146 = OpAccessChain %21 %141 
					                                       f32_4 %147 = OpLoad %146 
					                                       f32_2 %148 = OpVectorShuffle %147 %147 2 3 
					                                       f32_2 %149 = OpFAdd %145 %148 
					                                                      OpStore %139 %149 
					                                       f32_4 %152 = OpLoad %151 
					                                                      OpStore %150 %152 
					                                Private f32* %154 = OpAccessChain %9 %76 
					                                         f32 %155 = OpLoad %154 
					                                Uniform f32* %158 = OpAccessChain %21 %36 %23 %156 
					                                         f32 %159 = OpLoad %158 
					                                         f32 %160 = OpFMul %155 %159 
					                                                      OpStore %153 %160 
					                                Uniform f32* %161 = OpAccessChain %21 %36 %28 %156 
					                                         f32 %162 = OpLoad %161 
					                                Private f32* %164 = OpAccessChain %9 %163 
					                                         f32 %165 = OpLoad %164 
					                                         f32 %166 = OpFMul %162 %165 
					                                         f32 %167 = OpLoad %153 
					                                         f32 %168 = OpFAdd %166 %167 
					                                Private f32* %169 = OpAccessChain %9 %163 
					                                                      OpStore %169 %168 
					                                Uniform f32* %170 = OpAccessChain %21 %36 %36 %156 
					                                         f32 %171 = OpLoad %170 
					                                Private f32* %172 = OpAccessChain %9 %156 
					                                         f32 %173 = OpLoad %172 
					                                         f32 %174 = OpFMul %171 %173 
					                                Private f32* %175 = OpAccessChain %9 %163 
					                                         f32 %176 = OpLoad %175 
					                                         f32 %177 = OpFAdd %174 %176 
					                                Private f32* %178 = OpAccessChain %9 %163 
					                                                      OpStore %178 %177 
					                                Uniform f32* %179 = OpAccessChain %21 %36 %45 %156 
					                                         f32 %180 = OpLoad %179 
					                                Private f32* %181 = OpAccessChain %9 %108 
					                                         f32 %182 = OpLoad %181 
					                                         f32 %183 = OpFMul %180 %182 
					                                Private f32* %184 = OpAccessChain %9 %163 
					                                         f32 %185 = OpLoad %184 
					                                         f32 %186 = OpFAdd %183 %185 
					                                Private f32* %187 = OpAccessChain %9 %163 
					                                                      OpStore %187 %186 
					                                Private f32* %188 = OpAccessChain %9 %163 
					                                         f32 %189 = OpLoad %188 
					                                         f32 %190 = OpFNegate %189 
					                                 Output f32* %191 = OpAccessChain %107 %156 
					                                                      OpStore %191 %190 
					                                Private f32* %192 = OpAccessChain %49 %76 
					                                         f32 %193 = OpLoad %192 
					                                Uniform f32* %194 = OpAccessChain %21 %28 %163 
					                                         f32 %195 = OpLoad %194 
					                                         f32 %196 = OpFMul %193 %195 
					                                Private f32* %197 = OpAccessChain %9 %163 
					                                                      OpStore %197 %196 
					                                       f32_4 %198 = OpLoad %49 
					                                       f32_2 %199 = OpVectorShuffle %198 %198 0 3 
					                                       f32_2 %200 = OpFMul %199 %99 
					                                       f32_4 %201 = OpLoad %49 
					                                       f32_4 %202 = OpVectorShuffle %201 %200 4 1 5 3 
					                                                      OpStore %49 %202 
					                                Private f32* %203 = OpAccessChain %9 %163 
					                                         f32 %204 = OpLoad %203 
					                                         f32 %205 = OpFMul %204 %98 
					                                Private f32* %206 = OpAccessChain %49 %108 
					                                                      OpStore %206 %205 
					                                       f32_4 %207 = OpLoad %49 
					                                       f32_2 %208 = OpVectorShuffle %207 %207 2 2 
					                                       f32_4 %209 = OpLoad %49 
					                                       f32_2 %210 = OpVectorShuffle %209 %209 0 3 
					                                       f32_2 %211 = OpFAdd %208 %210 
					                                       f32_4 %212 = OpLoad %107 
					                                       f32_4 %213 = OpVectorShuffle %212 %211 4 5 2 3 
					                                                      OpStore %107 %213 
					                                 Output f32* %214 = OpAccessChain %80 %28 %76 
					                                         f32 %215 = OpLoad %214 
					                                         f32 %216 = OpFNegate %215 
					                                 Output f32* %217 = OpAccessChain %80 %28 %76 
					                                                      OpStore %217 %216 
					                                                      OpReturn
					                                                      OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 1
					; Bound: 232
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Fragment %4 "main" %34 %90 %107 %143 %168 %180 %221 
					                                                      OpExecutionMode %4 OriginUpperLeft 
					                                                      OpMemberDecorate %12 0 Offset 12 
					                                                      OpMemberDecorate %12 1 Offset 12 
					                                                      OpMemberDecorate %12 2 Offset 12 
					                                                      OpMemberDecorate %12 3 Offset 12 
					                                                      OpMemberDecorate %12 4 RelaxedPrecision 
					                                                      OpMemberDecorate %12 4 Offset 12 
					                                                      OpMemberDecorate %12 5 Offset 12 
					                                                      OpDecorate %12 Block 
					                                                      OpDecorate %14 DescriptorSet 14 
					                                                      OpDecorate %14 Binding 14 
					                                                      OpDecorate %27 SpecId 27 
					                                                      OpDecorate %34 Location 34 
					                                                      OpDecorate %43 DescriptorSet 43 
					                                                      OpDecorate %43 Binding 43 
					                                                      OpDecorate %90 RelaxedPrecision 
					                                                      OpDecorate %90 Location 90 
					                                                      OpDecorate %92 RelaxedPrecision 
					                                                      OpDecorate %95 RelaxedPrecision 
					                                                      OpDecorate %100 RelaxedPrecision 
					                                                      OpDecorate %103 RelaxedPrecision 
					                                                      OpDecorate %104 RelaxedPrecision 
					                                                      OpDecorate %104 DescriptorSet 104 
					                                                      OpDecorate %104 Binding 104 
					                                                      OpDecorate %105 RelaxedPrecision 
					                                                      OpDecorate %107 Location 107 
					                                                      OpDecorate %110 RelaxedPrecision 
					                                                      OpDecorate %113 RelaxedPrecision 
					                                                      OpDecorate %114 RelaxedPrecision 
					                                                      OpDecorate %115 RelaxedPrecision 
					                                                      OpDecorate %118 RelaxedPrecision 
					                                                      OpDecorate %121 RelaxedPrecision 
					                                                      OpDecorate %123 RelaxedPrecision 
					                                                      OpDecorate %127 RelaxedPrecision 
					                                                      OpDecorate %128 RelaxedPrecision 
					                                                      OpDecorate %143 Location 143 
					                                                      OpDecorate %159 RelaxedPrecision 
					                                                      OpDecorate %159 DescriptorSet 159 
					                                                      OpDecorate %159 Binding 159 
					                                                      OpDecorate %160 RelaxedPrecision 
					                                                      OpDecorate %164 RelaxedPrecision 
					                                                      OpDecorate %165 RelaxedPrecision 
					                                                      OpDecorate %166 RelaxedPrecision 
					                                                      OpDecorate %166 DescriptorSet 166 
					                                                      OpDecorate %166 Binding 166 
					                                                      OpDecorate %167 RelaxedPrecision 
					                                                      OpDecorate %168 Location 168 
					                                                      OpDecorate %171 RelaxedPrecision 
					                                                      OpDecorate %172 RelaxedPrecision 
					                                                      OpDecorate %173 RelaxedPrecision 
					                                                      OpDecorate %174 RelaxedPrecision 
					                                                      OpDecorate %175 RelaxedPrecision 
					                                                      OpDecorate %176 RelaxedPrecision 
					                                                      OpDecorate %177 RelaxedPrecision 
					                                                      OpDecorate %178 RelaxedPrecision 
					                                                      OpDecorate %178 DescriptorSet 178 
					                                                      OpDecorate %178 Binding 178 
					                                                      OpDecorate %179 RelaxedPrecision 
					                                                      OpDecorate %180 Location 180 
					                                                      OpDecorate %183 RelaxedPrecision 
					                                                      OpDecorate %184 RelaxedPrecision 
					                                                      OpDecorate %185 RelaxedPrecision 
					                                                      OpDecorate %186 RelaxedPrecision 
					                                                      OpDecorate %187 RelaxedPrecision 
					                                                      OpDecorate %189 RelaxedPrecision 
					                                                      OpDecorate %197 RelaxedPrecision 
					                                                      OpDecorate %198 RelaxedPrecision 
					                                                      OpDecorate %199 RelaxedPrecision 
					                                                      OpDecorate %200 RelaxedPrecision 
					                                                      OpDecorate %201 RelaxedPrecision 
					                                                      OpDecorate %202 RelaxedPrecision 
					                                                      OpDecorate %206 RelaxedPrecision 
					                                                      OpDecorate %207 RelaxedPrecision 
					                                                      OpDecorate %209 RelaxedPrecision 
					                                                      OpDecorate %210 RelaxedPrecision 
					                                                      OpDecorate %211 RelaxedPrecision 
					                                                      OpDecorate %212 RelaxedPrecision 
					                                                      OpDecorate %215 RelaxedPrecision 
					                                                      OpDecorate %217 RelaxedPrecision 
					                                                      OpDecorate %218 RelaxedPrecision 
					                                                      OpDecorate %221 RelaxedPrecision 
					                                                      OpDecorate %221 Location 221 
					                                                      OpDecorate %222 RelaxedPrecision 
					                                                      OpDecorate %224 RelaxedPrecision 
					                                                      OpDecorate %225 RelaxedPrecision 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeBool 
					                                               %7 = OpTypePointer Private %6 
					                                 Private bool* %8 = OpVariable Private 
					                                               %9 = OpTypeFloat 32 
					                                          f32 %10 = OpConstant 3.674022E-40 
					                                              %11 = OpTypeVector %9 4 
					                                              %12 = OpTypeStruct %11 %9 %9 %11 %11 %9 
					                                              %13 = OpTypePointer Uniform %12 
					Uniform struct {f32_4; f32; f32; f32_4; f32_4; f32;}* %14 = OpVariable Uniform 
					                                              %15 = OpTypeInt 32 1 
					                                          i32 %16 = OpConstant 5 
					                                              %17 = OpTypePointer Uniform %9 
					                                         bool %21 = OpConstantFalse 
					                                         bool %27 = OpSpecConstantFalse 
					                                              %30 = OpTypeVector %9 2 
					                                              %31 = OpTypePointer Private %30 
					                               Private f32_2* %32 = OpVariable Private 
					                                              %33 = OpTypePointer Input %11 
					                                 Input f32_4* %34 = OpVariable Input 
					                                              %40 = OpTypeImage %9 Dim2D 0 0 0 1 Unknown 
					                                              %41 = OpTypeSampledImage %40 
					                                              %42 = OpTypePointer UniformConstant %41 
					  UniformConstant read_only Texture2DSampled* %43 = OpVariable UniformConstant 
					                                              %47 = OpTypeInt 32 0 
					                                          u32 %48 = OpConstant 0 
					                                              %50 = OpTypePointer Private %9 
					                                          i32 %52 = OpConstant 0 
					                                          u32 %53 = OpConstant 2 
					                                          u32 %59 = OpConstant 3 
					                                          f32 %64 = OpConstant 3.674022E-40 
					                                              %71 = OpTypePointer Input %9 
					                                          f32 %85 = OpConstant 3.674022E-40 
					                                 Input f32_4* %90 = OpVariable Input 
					                                 Private f32* %95 = OpVariable Private 
					                                             %101 = OpTypeVector %9 3 
					                                             %102 = OpTypePointer Private %101 
					                              Private f32_3* %103 = OpVariable Private 
					 UniformConstant read_only Texture2DSampled* %104 = OpVariable UniformConstant 
					                                             %106 = OpTypePointer Input %30 
					                                Input f32_2* %107 = OpVariable Input 
					                              Private f32_2* %113 = OpVariable Private 
					                                         f32 %116 = OpConstant 3.674022E-40 
					                                       f32_2 %117 = OpConstantComposite %116 %116 
					                                         f32 %119 = OpConstant 3.674022E-40 
					                                       f32_2 %120 = OpConstantComposite %119 %119 
					                              Private f32_3* %122 = OpVariable Private 
					                                         i32 %124 = OpConstant 1 
					                                         i32 %133 = OpConstant 3 
					                                             %134 = OpTypePointer Uniform %11 
					                                Input f32_4* %143 = OpVariable Input 
					 UniformConstant read_only Texture2DSampled* %159 = OpVariable UniformConstant 
					                              Private f32_3* %165 = OpVariable Private 
					 UniformConstant read_only Texture2DSampled* %166 = OpVariable UniformConstant 
					                                Input f32_2* %168 = OpVariable Input 
					                              Private f32_3* %172 = OpVariable Private 
					                                Private f32* %177 = OpVariable Private 
					 UniformConstant read_only Texture2DSampled* %178 = OpVariable UniformConstant 
					                                Input f32_2* %180 = OpVariable Input 
					                                Private f32* %184 = OpVariable Private 
					                              Private f32_3* %188 = OpVariable Private 
					                                         i32 %190 = OpConstant 2 
					                                         i32 %204 = OpConstant 4 
					                                             %220 = OpTypePointer Output %11 
					                               Output f32_4* %221 = OpVariable Output 
					                                             %226 = OpTypePointer Output %9 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                 Uniform f32* %18 = OpAccessChain %14 %16 
					                                          f32 %19 = OpLoad %18 
					                                         bool %20 = OpFOrdLessThan %10 %19 
					                                                      OpStore %8 %20 
					                                                      OpSelectionMerge %23 None 
					                                                      OpBranchConditional %21 %22 %23 
					                                              %22 = OpLabel 
					                                         bool %24 = OpLoad %8 
					                                                      OpSelectionMerge %26 None 
					                                                      OpBranchConditional %24 %25 %26 
					                                              %25 = OpLabel 
					                                                      OpBranch %26 
					                                              %26 = OpLabel 
					                                                      OpBranch %23 
					                                              %23 = OpLabel 
					                                                      OpSelectionMerge %29 None 
					                                                      OpBranchConditional %27 %28 %98 
					                                              %28 = OpLabel 
					                                        f32_4 %35 = OpLoad %34 
					                                        f32_2 %36 = OpVectorShuffle %35 %35 0 1 
					                                        f32_4 %37 = OpLoad %34 
					                                        f32_2 %38 = OpVectorShuffle %37 %37 3 3 
					                                        f32_2 %39 = OpFDiv %36 %38 
					                                                      OpStore %32 %39 
					                   read_only Texture2DSampled %44 = OpLoad %43 
					                                        f32_2 %45 = OpLoad %32 
					                                        f32_4 %46 = OpImageSampleImplicitLod %44 %45 
					                                          f32 %49 = OpCompositeExtract %46 0 
					                                 Private f32* %51 = OpAccessChain %32 %48 
					                                                      OpStore %51 %49 
					                                 Uniform f32* %54 = OpAccessChain %14 %52 %53 
					                                          f32 %55 = OpLoad %54 
					                                 Private f32* %56 = OpAccessChain %32 %48 
					                                          f32 %57 = OpLoad %56 
					                                          f32 %58 = OpFMul %55 %57 
					                                 Uniform f32* %60 = OpAccessChain %14 %52 %59 
					                                          f32 %61 = OpLoad %60 
					                                          f32 %62 = OpFAdd %58 %61 
					                                 Private f32* %63 = OpAccessChain %32 %48 
					                                                      OpStore %63 %62 
					                                 Private f32* %65 = OpAccessChain %32 %48 
					                                          f32 %66 = OpLoad %65 
					                                          f32 %67 = OpFDiv %64 %66 
					                                 Private f32* %68 = OpAccessChain %32 %48 
					                                                      OpStore %68 %67 
					                                 Private f32* %69 = OpAccessChain %32 %48 
					                                          f32 %70 = OpLoad %69 
					                                   Input f32* %72 = OpAccessChain %34 %53 
					                                          f32 %73 = OpLoad %72 
					                                          f32 %74 = OpFNegate %73 
					                                          f32 %75 = OpFAdd %70 %74 
					                                 Private f32* %76 = OpAccessChain %32 %48 
					                                                      OpStore %76 %75 
					                                 Private f32* %77 = OpAccessChain %32 %48 
					                                          f32 %78 = OpLoad %77 
					                                 Uniform f32* %79 = OpAccessChain %14 %16 
					                                          f32 %80 = OpLoad %79 
					                                          f32 %81 = OpFMul %78 %80 
					                                 Private f32* %82 = OpAccessChain %32 %48 
					                                                      OpStore %82 %81 
					                                 Private f32* %83 = OpAccessChain %32 %48 
					                                          f32 %84 = OpLoad %83 
					                                          f32 %86 = OpExtInst %1 43 %84 %85 %64 
					                                 Private f32* %87 = OpAccessChain %32 %48 
					                                                      OpStore %87 %86 
					                                 Private f32* %88 = OpAccessChain %32 %48 
					                                          f32 %89 = OpLoad %88 
					                                   Input f32* %91 = OpAccessChain %90 %59 
					                                          f32 %92 = OpLoad %91 
					                                          f32 %93 = OpFMul %89 %92 
					                                 Private f32* %94 = OpAccessChain %32 %48 
					                                                      OpStore %94 %93 
					                                 Private f32* %96 = OpAccessChain %32 %48 
					                                          f32 %97 = OpLoad %96 
					                                                      OpStore %95 %97 
					                                                      OpBranch %29 
					                                              %98 = OpLabel 
					                                   Input f32* %99 = OpAccessChain %90 %59 
					                                         f32 %100 = OpLoad %99 
					                                                      OpStore %95 %100 
					                                                      OpBranch %29 
					                                              %29 = OpLabel 
					                  read_only Texture2DSampled %105 = OpLoad %104 
					                                       f32_2 %108 = OpLoad %107 
					                                       f32_4 %109 = OpImageSampleImplicitLod %105 %108 
					                                       f32_2 %110 = OpVectorShuffle %109 %109 0 1 
					                                       f32_3 %111 = OpLoad %103 
					                                       f32_3 %112 = OpVectorShuffle %111 %110 3 4 2 
					                                                      OpStore %103 %112 
					                                       f32_3 %114 = OpLoad %103 
					                                       f32_2 %115 = OpVectorShuffle %114 %114 0 1 
					                                       f32_2 %118 = OpFMul %115 %117 
					                                       f32_2 %121 = OpFAdd %118 %120 
					                                                      OpStore %113 %121 
					                                       f32_2 %123 = OpLoad %113 
					                                Uniform f32* %125 = OpAccessChain %14 %124 
					                                         f32 %126 = OpLoad %125 
					                                       f32_2 %127 = OpCompositeConstruct %126 %126 
					                                       f32_2 %128 = OpFMul %123 %127 
					                                       f32_3 %129 = OpLoad %122 
					                                       f32_3 %130 = OpVectorShuffle %129 %128 3 4 2 
					                                                      OpStore %122 %130 
					                                       f32_3 %131 = OpLoad %122 
					                                       f32_2 %132 = OpVectorShuffle %131 %131 0 1 
					                              Uniform f32_4* %135 = OpAccessChain %14 %133 
					                                       f32_4 %136 = OpLoad %135 
					                                       f32_2 %137 = OpVectorShuffle %136 %136 0 1 
					                                       f32_2 %138 = OpFMul %132 %137 
					                                       f32_3 %139 = OpLoad %122 
					                                       f32_3 %140 = OpVectorShuffle %139 %138 3 4 2 
					                                                      OpStore %122 %140 
					                                       f32_3 %141 = OpLoad %122 
					                                       f32_2 %142 = OpVectorShuffle %141 %141 0 1 
					                                       f32_4 %144 = OpLoad %143 
					                                       f32_2 %145 = OpVectorShuffle %144 %144 2 2 
					                                       f32_2 %146 = OpFMul %142 %145 
					                                       f32_4 %147 = OpLoad %143 
					                                       f32_2 %148 = OpVectorShuffle %147 %147 0 1 
					                                       f32_2 %149 = OpFAdd %146 %148 
					                                       f32_3 %150 = OpLoad %122 
					                                       f32_3 %151 = OpVectorShuffle %150 %149 3 4 2 
					                                                      OpStore %122 %151 
					                                       f32_3 %152 = OpLoad %122 
					                                       f32_2 %153 = OpVectorShuffle %152 %152 0 1 
					                                       f32_4 %154 = OpLoad %143 
					                                       f32_2 %155 = OpVectorShuffle %154 %154 3 3 
					                                       f32_2 %156 = OpFDiv %153 %155 
					                                       f32_3 %157 = OpLoad %122 
					                                       f32_3 %158 = OpVectorShuffle %157 %156 3 4 2 
					                                                      OpStore %122 %158 
					                  read_only Texture2DSampled %160 = OpLoad %159 
					                                       f32_3 %161 = OpLoad %122 
					                                       f32_2 %162 = OpVectorShuffle %161 %161 0 1 
					                                       f32_4 %163 = OpImageSampleImplicitLod %160 %162 
					                                       f32_3 %164 = OpVectorShuffle %163 %163 0 1 2 
					                                                      OpStore %103 %164 
					                  read_only Texture2DSampled %167 = OpLoad %166 
					                                       f32_2 %169 = OpLoad %168 
					                                       f32_4 %170 = OpImageSampleImplicitLod %167 %169 
					                                       f32_3 %171 = OpVectorShuffle %170 %170 0 1 2 
					                                                      OpStore %165 %171 
					                                       f32_3 %173 = OpLoad %165 
					                                       f32_4 %174 = OpLoad %90 
					                                       f32_3 %175 = OpVectorShuffle %174 %174 0 1 2 
					                                       f32_3 %176 = OpFMul %173 %175 
					                                                      OpStore %172 %176 
					                  read_only Texture2DSampled %179 = OpLoad %178 
					                                       f32_2 %181 = OpLoad %180 
					                                       f32_4 %182 = OpImageSampleImplicitLod %179 %181 
					                                         f32 %183 = OpCompositeExtract %182 3 
					                                                      OpStore %177 %183 
					                                         f32 %185 = OpLoad %95 
					                                         f32 %186 = OpLoad %177 
					                                         f32 %187 = OpFMul %185 %186 
					                                                      OpStore %184 %187 
					                                       f32_3 %189 = OpLoad %172 
					                                Uniform f32* %191 = OpAccessChain %14 %190 
					                                         f32 %192 = OpLoad %191 
					                                Uniform f32* %193 = OpAccessChain %14 %190 
					                                         f32 %194 = OpLoad %193 
					                                Uniform f32* %195 = OpAccessChain %14 %190 
					                                         f32 %196 = OpLoad %195 
					                                       f32_3 %197 = OpCompositeConstruct %192 %194 %196 
					                                         f32 %198 = OpCompositeExtract %197 0 
					                                         f32 %199 = OpCompositeExtract %197 1 
					                                         f32 %200 = OpCompositeExtract %197 2 
					                                       f32_3 %201 = OpCompositeConstruct %198 %199 %200 
					                                       f32_3 %202 = OpFMul %189 %201 
					                                                      OpStore %188 %202 
					                                       f32_3 %203 = OpLoad %188 
					                              Uniform f32_4* %205 = OpAccessChain %14 %204 
					                                       f32_4 %206 = OpLoad %205 
					                                       f32_3 %207 = OpVectorShuffle %206 %206 0 1 2 
					                                       f32_3 %208 = OpFMul %203 %207 
					                                                      OpStore %188 %208 
					                                       f32_3 %209 = OpLoad %103 
					                                       f32_4 %210 = OpLoad %90 
					                                       f32_3 %211 = OpVectorShuffle %210 %210 0 1 2 
					                                       f32_3 %212 = OpFMul %209 %211 
					                                       f32_3 %213 = OpLoad %188 
					                                       f32_3 %214 = OpFAdd %212 %213 
					                                                      OpStore %122 %214 
					                                         f32 %215 = OpLoad %95 
					                                Uniform f32* %216 = OpAccessChain %14 %204 %59 
					                                         f32 %217 = OpLoad %216 
					                                         f32 %218 = OpFMul %215 %217 
					                                Private f32* %219 = OpAccessChain %113 %48 
					                                                      OpStore %219 %218 
					                                         f32 %222 = OpLoad %184 
					                                Private f32* %223 = OpAccessChain %113 %48 
					                                         f32 %224 = OpLoad %223 
					                                         f32 %225 = OpFMul %222 %224 
					                                 Output f32* %227 = OpAccessChain %221 %59 
					                                                      OpStore %227 %225 
					                                       f32_3 %228 = OpLoad %122 
					                                       f32_4 %229 = OpLoad %221 
					                                       f32_4 %230 = OpVectorShuffle %229 %228 4 5 6 3 
					                                                      OpStore %221 %230 
					                                                      OpReturn
					                                                      OpFunctionEnd"
				}
				SubProgram "vulkan hw_tier02 " {
					Keywords { "SOFTPARTICLES_ON" }
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 1
					; Bound: 219
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Vertex %4 "main" %11 %80 %96 %107 %115 %117 %128 %139 %150 %151 
					                                                      OpDecorate %11 Location 11 
					                                                      OpDecorate %16 ArrayStride 16 
					                                                      OpDecorate %17 ArrayStride 17 
					                                                      OpDecorate %18 ArrayStride 18 
					                                                      OpMemberDecorate %19 0 Offset 19 
					                                                      OpMemberDecorate %19 1 Offset 19 
					                                                      OpMemberDecorate %19 2 Offset 19 
					                                                      OpMemberDecorate %19 3 Offset 19 
					                                                      OpMemberDecorate %19 4 Offset 19 
					                                                      OpMemberDecorate %19 5 Offset 19 
					                                                      OpMemberDecorate %19 6 Offset 19 
					                                                      OpDecorate %19 Block 
					                                                      OpDecorate %21 DescriptorSet 21 
					                                                      OpDecorate %21 Binding 21 
					                                                      OpMemberDecorate %78 0 BuiltIn 78 
					                                                      OpMemberDecorate %78 1 BuiltIn 78 
					                                                      OpMemberDecorate %78 2 BuiltIn 78 
					                                                      OpDecorate %78 Block 
					                                                      OpDecorate %96 Location 96 
					                                                      OpDecorate %107 Location 107 
					                                                      OpDecorate %115 Location 115 
					                                                      OpDecorate %117 Location 117 
					                                                      OpDecorate %128 Location 128 
					                                                      OpDecorate %139 Location 139 
					                                                      OpDecorate %150 RelaxedPrecision 
					                                                      OpDecorate %150 Location 150 
					                                                      OpDecorate %151 RelaxedPrecision 
					                                                      OpDecorate %151 Location 151 
					                                                      OpDecorate %152 RelaxedPrecision 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 4 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_4* %9 = OpVariable Private 
					                                              %10 = OpTypePointer Input %7 
					                                 Input f32_4* %11 = OpVariable Input 
					                                              %14 = OpTypeInt 32 0 
					                                          u32 %15 = OpConstant 4 
					                                              %16 = OpTypeArray %7 %15 
					                                              %17 = OpTypeArray %7 %15 
					                                              %18 = OpTypeArray %7 %15 
					                                              %19 = OpTypeStruct %7 %16 %17 %18 %7 %7 %7 
					                                              %20 = OpTypePointer Uniform %19 
					Uniform struct {f32_4; f32_4[4]; f32_4[4]; f32_4[4]; f32_4; f32_4; f32_4;}* %21 = OpVariable Uniform 
					                                              %22 = OpTypeInt 32 1 
					                                          i32 %23 = OpConstant 1 
					                                              %24 = OpTypePointer Uniform %7 
					                                          i32 %28 = OpConstant 0 
					                                          i32 %36 = OpConstant 2 
					                                          i32 %45 = OpConstant 3 
					                               Private f32_4* %49 = OpVariable Private 
					                                          u32 %76 = OpConstant 1 
					                                              %77 = OpTypeArray %6 %76 
					                                              %78 = OpTypeStruct %7 %6 %77 
					                                              %79 = OpTypePointer Output %78 
					         Output struct {f32_4; f32; f32[1];}* %80 = OpVariable Output 
					                                              %82 = OpTypePointer Output %7 
					                                              %84 = OpTypeVector %6 2 
					                                              %85 = OpTypePointer Private %84 
					                               Private f32_2* %86 = OpVariable Private 
					                                          f32 %89 = OpConstant 3.674022E-40 
					                                          f32 %90 = OpConstant 3.674022E-40 
					                                        f32_2 %91 = OpConstantComposite %89 %90 
					                                Output f32_4* %96 = OpVariable Output 
					                                          f32 %98 = OpConstant 3.674022E-40 
					                                        f32_2 %99 = OpConstantComposite %98 %98 
					                               Output f32_4* %107 = OpVariable Output 
					                                         u32 %108 = OpConstant 3 
					                                             %109 = OpTypePointer Private %6 
					                                             %112 = OpTypePointer Output %6 
					                                             %114 = OpTypePointer Output %84 
					                               Output f32_2* %115 = OpVariable Output 
					                                             %116 = OpTypePointer Input %84 
					                                Input f32_2* %117 = OpVariable Input 
					                                         i32 %119 = OpConstant 4 
					                               Output f32_2* %128 = OpVariable Output 
					                                         i32 %130 = OpConstant 5 
					                               Output f32_2* %139 = OpVariable Output 
					                                         i32 %141 = OpConstant 6 
					                               Output f32_4* %150 = OpVariable Output 
					                                Input f32_4* %151 = OpVariable Input 
					                                Private f32* %153 = OpVariable Private 
					                                         u32 %156 = OpConstant 2 
					                                             %157 = OpTypePointer Uniform %6 
					                                         u32 %163 = OpConstant 0 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                        f32_4 %12 = OpLoad %11 
					                                        f32_4 %13 = OpVectorShuffle %12 %12 1 1 1 1 
					                               Uniform f32_4* %25 = OpAccessChain %21 %23 %23 
					                                        f32_4 %26 = OpLoad %25 
					                                        f32_4 %27 = OpFMul %13 %26 
					                                                      OpStore %9 %27 
					                               Uniform f32_4* %29 = OpAccessChain %21 %23 %28 
					                                        f32_4 %30 = OpLoad %29 
					                                        f32_4 %31 = OpLoad %11 
					                                        f32_4 %32 = OpVectorShuffle %31 %31 0 0 0 0 
					                                        f32_4 %33 = OpFMul %30 %32 
					                                        f32_4 %34 = OpLoad %9 
					                                        f32_4 %35 = OpFAdd %33 %34 
					                                                      OpStore %9 %35 
					                               Uniform f32_4* %37 = OpAccessChain %21 %23 %36 
					                                        f32_4 %38 = OpLoad %37 
					                                        f32_4 %39 = OpLoad %11 
					                                        f32_4 %40 = OpVectorShuffle %39 %39 2 2 2 2 
					                                        f32_4 %41 = OpFMul %38 %40 
					                                        f32_4 %42 = OpLoad %9 
					                                        f32_4 %43 = OpFAdd %41 %42 
					                                                      OpStore %9 %43 
					                                        f32_4 %44 = OpLoad %9 
					                               Uniform f32_4* %46 = OpAccessChain %21 %23 %45 
					                                        f32_4 %47 = OpLoad %46 
					                                        f32_4 %48 = OpFAdd %44 %47 
					                                                      OpStore %9 %48 
					                                        f32_4 %50 = OpLoad %9 
					                                        f32_4 %51 = OpVectorShuffle %50 %50 1 1 1 1 
					                               Uniform f32_4* %52 = OpAccessChain %21 %45 %23 
					                                        f32_4 %53 = OpLoad %52 
					                                        f32_4 %54 = OpFMul %51 %53 
					                                                      OpStore %49 %54 
					                               Uniform f32_4* %55 = OpAccessChain %21 %45 %28 
					                                        f32_4 %56 = OpLoad %55 
					                                        f32_4 %57 = OpLoad %9 
					                                        f32_4 %58 = OpVectorShuffle %57 %57 0 0 0 0 
					                                        f32_4 %59 = OpFMul %56 %58 
					                                        f32_4 %60 = OpLoad %49 
					                                        f32_4 %61 = OpFAdd %59 %60 
					                                                      OpStore %49 %61 
					                               Uniform f32_4* %62 = OpAccessChain %21 %45 %36 
					                                        f32_4 %63 = OpLoad %62 
					                                        f32_4 %64 = OpLoad %9 
					                                        f32_4 %65 = OpVectorShuffle %64 %64 2 2 2 2 
					                                        f32_4 %66 = OpFMul %63 %65 
					                                        f32_4 %67 = OpLoad %49 
					                                        f32_4 %68 = OpFAdd %66 %67 
					                                                      OpStore %49 %68 
					                               Uniform f32_4* %69 = OpAccessChain %21 %45 %45 
					                                        f32_4 %70 = OpLoad %69 
					                                        f32_4 %71 = OpLoad %9 
					                                        f32_4 %72 = OpVectorShuffle %71 %71 3 3 3 3 
					                                        f32_4 %73 = OpFMul %70 %72 
					                                        f32_4 %74 = OpLoad %49 
					                                        f32_4 %75 = OpFAdd %73 %74 
					                                                      OpStore %49 %75 
					                                        f32_4 %81 = OpLoad %49 
					                                Output f32_4* %83 = OpAccessChain %80 %28 
					                                                      OpStore %83 %81 
					                                        f32_4 %87 = OpLoad %49 
					                                        f32_2 %88 = OpVectorShuffle %87 %87 0 1 
					                                        f32_2 %92 = OpFMul %88 %91 
					                                        f32_4 %93 = OpLoad %49 
					                                        f32_2 %94 = OpVectorShuffle %93 %93 3 3 
					                                        f32_2 %95 = OpFAdd %92 %94 
					                                                      OpStore %86 %95 
					                                        f32_2 %97 = OpLoad %86 
					                                       f32_2 %100 = OpFMul %97 %99 
					                                       f32_4 %101 = OpLoad %96 
					                                       f32_4 %102 = OpVectorShuffle %101 %100 4 5 2 3 
					                                                      OpStore %96 %102 
					                                       f32_4 %103 = OpLoad %49 
					                                       f32_2 %104 = OpVectorShuffle %103 %103 2 3 
					                                       f32_4 %105 = OpLoad %96 
					                                       f32_4 %106 = OpVectorShuffle %105 %104 0 1 4 5 
					                                                      OpStore %96 %106 
					                                Private f32* %110 = OpAccessChain %49 %108 
					                                         f32 %111 = OpLoad %110 
					                                 Output f32* %113 = OpAccessChain %107 %108 
					                                                      OpStore %113 %111 
					                                       f32_2 %118 = OpLoad %117 
					                              Uniform f32_4* %120 = OpAccessChain %21 %119 
					                                       f32_4 %121 = OpLoad %120 
					                                       f32_2 %122 = OpVectorShuffle %121 %121 0 1 
					                                       f32_2 %123 = OpFMul %118 %122 
					                              Uniform f32_4* %124 = OpAccessChain %21 %119 
					                                       f32_4 %125 = OpLoad %124 
					                                       f32_2 %126 = OpVectorShuffle %125 %125 2 3 
					                                       f32_2 %127 = OpFAdd %123 %126 
					                                                      OpStore %115 %127 
					                                       f32_2 %129 = OpLoad %117 
					                              Uniform f32_4* %131 = OpAccessChain %21 %130 
					                                       f32_4 %132 = OpLoad %131 
					                                       f32_2 %133 = OpVectorShuffle %132 %132 0 1 
					                                       f32_2 %134 = OpFMul %129 %133 
					                              Uniform f32_4* %135 = OpAccessChain %21 %130 
					                                       f32_4 %136 = OpLoad %135 
					                                       f32_2 %137 = OpVectorShuffle %136 %136 2 3 
					                                       f32_2 %138 = OpFAdd %134 %137 
					                                                      OpStore %128 %138 
					                                       f32_2 %140 = OpLoad %117 
					                              Uniform f32_4* %142 = OpAccessChain %21 %141 
					                                       f32_4 %143 = OpLoad %142 
					                                       f32_2 %144 = OpVectorShuffle %143 %143 0 1 
					                                       f32_2 %145 = OpFMul %140 %144 
					                              Uniform f32_4* %146 = OpAccessChain %21 %141 
					                                       f32_4 %147 = OpLoad %146 
					                                       f32_2 %148 = OpVectorShuffle %147 %147 2 3 
					                                       f32_2 %149 = OpFAdd %145 %148 
					                                                      OpStore %139 %149 
					                                       f32_4 %152 = OpLoad %151 
					                                                      OpStore %150 %152 
					                                Private f32* %154 = OpAccessChain %9 %76 
					                                         f32 %155 = OpLoad %154 
					                                Uniform f32* %158 = OpAccessChain %21 %36 %23 %156 
					                                         f32 %159 = OpLoad %158 
					                                         f32 %160 = OpFMul %155 %159 
					                                                      OpStore %153 %160 
					                                Uniform f32* %161 = OpAccessChain %21 %36 %28 %156 
					                                         f32 %162 = OpLoad %161 
					                                Private f32* %164 = OpAccessChain %9 %163 
					                                         f32 %165 = OpLoad %164 
					                                         f32 %166 = OpFMul %162 %165 
					                                         f32 %167 = OpLoad %153 
					                                         f32 %168 = OpFAdd %166 %167 
					                                Private f32* %169 = OpAccessChain %9 %163 
					                                                      OpStore %169 %168 
					                                Uniform f32* %170 = OpAccessChain %21 %36 %36 %156 
					                                         f32 %171 = OpLoad %170 
					                                Private f32* %172 = OpAccessChain %9 %156 
					                                         f32 %173 = OpLoad %172 
					                                         f32 %174 = OpFMul %171 %173 
					                                Private f32* %175 = OpAccessChain %9 %163 
					                                         f32 %176 = OpLoad %175 
					                                         f32 %177 = OpFAdd %174 %176 
					                                Private f32* %178 = OpAccessChain %9 %163 
					                                                      OpStore %178 %177 
					                                Uniform f32* %179 = OpAccessChain %21 %36 %45 %156 
					                                         f32 %180 = OpLoad %179 
					                                Private f32* %181 = OpAccessChain %9 %108 
					                                         f32 %182 = OpLoad %181 
					                                         f32 %183 = OpFMul %180 %182 
					                                Private f32* %184 = OpAccessChain %9 %163 
					                                         f32 %185 = OpLoad %184 
					                                         f32 %186 = OpFAdd %183 %185 
					                                Private f32* %187 = OpAccessChain %9 %163 
					                                                      OpStore %187 %186 
					                                Private f32* %188 = OpAccessChain %9 %163 
					                                         f32 %189 = OpLoad %188 
					                                         f32 %190 = OpFNegate %189 
					                                 Output f32* %191 = OpAccessChain %107 %156 
					                                                      OpStore %191 %190 
					                                Private f32* %192 = OpAccessChain %49 %76 
					                                         f32 %193 = OpLoad %192 
					                                Uniform f32* %194 = OpAccessChain %21 %28 %163 
					                                         f32 %195 = OpLoad %194 
					                                         f32 %196 = OpFMul %193 %195 
					                                Private f32* %197 = OpAccessChain %9 %163 
					                                                      OpStore %197 %196 
					                                       f32_4 %198 = OpLoad %49 
					                                       f32_2 %199 = OpVectorShuffle %198 %198 0 3 
					                                       f32_2 %200 = OpFMul %199 %99 
					                                       f32_4 %201 = OpLoad %49 
					                                       f32_4 %202 = OpVectorShuffle %201 %200 4 1 5 3 
					                                                      OpStore %49 %202 
					                                Private f32* %203 = OpAccessChain %9 %163 
					                                         f32 %204 = OpLoad %203 
					                                         f32 %205 = OpFMul %204 %98 
					                                Private f32* %206 = OpAccessChain %49 %108 
					                                                      OpStore %206 %205 
					                                       f32_4 %207 = OpLoad %49 
					                                       f32_2 %208 = OpVectorShuffle %207 %207 2 2 
					                                       f32_4 %209 = OpLoad %49 
					                                       f32_2 %210 = OpVectorShuffle %209 %209 0 3 
					                                       f32_2 %211 = OpFAdd %208 %210 
					                                       f32_4 %212 = OpLoad %107 
					                                       f32_4 %213 = OpVectorShuffle %212 %211 4 5 2 3 
					                                                      OpStore %107 %213 
					                                 Output f32* %214 = OpAccessChain %80 %28 %76 
					                                         f32 %215 = OpLoad %214 
					                                         f32 %216 = OpFNegate %215 
					                                 Output f32* %217 = OpAccessChain %80 %28 %76 
					                                                      OpStore %217 %216 
					                                                      OpReturn
					                                                      OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 1
					; Bound: 232
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Fragment %4 "main" %34 %90 %107 %143 %168 %180 %221 
					                                                      OpExecutionMode %4 OriginUpperLeft 
					                                                      OpMemberDecorate %12 0 Offset 12 
					                                                      OpMemberDecorate %12 1 Offset 12 
					                                                      OpMemberDecorate %12 2 Offset 12 
					                                                      OpMemberDecorate %12 3 Offset 12 
					                                                      OpMemberDecorate %12 4 RelaxedPrecision 
					                                                      OpMemberDecorate %12 4 Offset 12 
					                                                      OpMemberDecorate %12 5 Offset 12 
					                                                      OpDecorate %12 Block 
					                                                      OpDecorate %14 DescriptorSet 14 
					                                                      OpDecorate %14 Binding 14 
					                                                      OpDecorate %27 SpecId 27 
					                                                      OpDecorate %34 Location 34 
					                                                      OpDecorate %43 DescriptorSet 43 
					                                                      OpDecorate %43 Binding 43 
					                                                      OpDecorate %90 RelaxedPrecision 
					                                                      OpDecorate %90 Location 90 
					                                                      OpDecorate %92 RelaxedPrecision 
					                                                      OpDecorate %95 RelaxedPrecision 
					                                                      OpDecorate %100 RelaxedPrecision 
					                                                      OpDecorate %103 RelaxedPrecision 
					                                                      OpDecorate %104 RelaxedPrecision 
					                                                      OpDecorate %104 DescriptorSet 104 
					                                                      OpDecorate %104 Binding 104 
					                                                      OpDecorate %105 RelaxedPrecision 
					                                                      OpDecorate %107 Location 107 
					                                                      OpDecorate %110 RelaxedPrecision 
					                                                      OpDecorate %113 RelaxedPrecision 
					                                                      OpDecorate %114 RelaxedPrecision 
					                                                      OpDecorate %115 RelaxedPrecision 
					                                                      OpDecorate %118 RelaxedPrecision 
					                                                      OpDecorate %121 RelaxedPrecision 
					                                                      OpDecorate %123 RelaxedPrecision 
					                                                      OpDecorate %127 RelaxedPrecision 
					                                                      OpDecorate %128 RelaxedPrecision 
					                                                      OpDecorate %143 Location 143 
					                                                      OpDecorate %159 RelaxedPrecision 
					                                                      OpDecorate %159 DescriptorSet 159 
					                                                      OpDecorate %159 Binding 159 
					                                                      OpDecorate %160 RelaxedPrecision 
					                                                      OpDecorate %164 RelaxedPrecision 
					                                                      OpDecorate %165 RelaxedPrecision 
					                                                      OpDecorate %166 RelaxedPrecision 
					                                                      OpDecorate %166 DescriptorSet 166 
					                                                      OpDecorate %166 Binding 166 
					                                                      OpDecorate %167 RelaxedPrecision 
					                                                      OpDecorate %168 Location 168 
					                                                      OpDecorate %171 RelaxedPrecision 
					                                                      OpDecorate %172 RelaxedPrecision 
					                                                      OpDecorate %173 RelaxedPrecision 
					                                                      OpDecorate %174 RelaxedPrecision 
					                                                      OpDecorate %175 RelaxedPrecision 
					                                                      OpDecorate %176 RelaxedPrecision 
					                                                      OpDecorate %177 RelaxedPrecision 
					                                                      OpDecorate %178 RelaxedPrecision 
					                                                      OpDecorate %178 DescriptorSet 178 
					                                                      OpDecorate %178 Binding 178 
					                                                      OpDecorate %179 RelaxedPrecision 
					                                                      OpDecorate %180 Location 180 
					                                                      OpDecorate %183 RelaxedPrecision 
					                                                      OpDecorate %184 RelaxedPrecision 
					                                                      OpDecorate %185 RelaxedPrecision 
					                                                      OpDecorate %186 RelaxedPrecision 
					                                                      OpDecorate %187 RelaxedPrecision 
					                                                      OpDecorate %189 RelaxedPrecision 
					                                                      OpDecorate %197 RelaxedPrecision 
					                                                      OpDecorate %198 RelaxedPrecision 
					                                                      OpDecorate %199 RelaxedPrecision 
					                                                      OpDecorate %200 RelaxedPrecision 
					                                                      OpDecorate %201 RelaxedPrecision 
					                                                      OpDecorate %202 RelaxedPrecision 
					                                                      OpDecorate %206 RelaxedPrecision 
					                                                      OpDecorate %207 RelaxedPrecision 
					                                                      OpDecorate %209 RelaxedPrecision 
					                                                      OpDecorate %210 RelaxedPrecision 
					                                                      OpDecorate %211 RelaxedPrecision 
					                                                      OpDecorate %212 RelaxedPrecision 
					                                                      OpDecorate %215 RelaxedPrecision 
					                                                      OpDecorate %217 RelaxedPrecision 
					                                                      OpDecorate %218 RelaxedPrecision 
					                                                      OpDecorate %221 RelaxedPrecision 
					                                                      OpDecorate %221 Location 221 
					                                                      OpDecorate %222 RelaxedPrecision 
					                                                      OpDecorate %224 RelaxedPrecision 
					                                                      OpDecorate %225 RelaxedPrecision 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeBool 
					                                               %7 = OpTypePointer Private %6 
					                                 Private bool* %8 = OpVariable Private 
					                                               %9 = OpTypeFloat 32 
					                                          f32 %10 = OpConstant 3.674022E-40 
					                                              %11 = OpTypeVector %9 4 
					                                              %12 = OpTypeStruct %11 %9 %9 %11 %11 %9 
					                                              %13 = OpTypePointer Uniform %12 
					Uniform struct {f32_4; f32; f32; f32_4; f32_4; f32;}* %14 = OpVariable Uniform 
					                                              %15 = OpTypeInt 32 1 
					                                          i32 %16 = OpConstant 5 
					                                              %17 = OpTypePointer Uniform %9 
					                                         bool %21 = OpConstantFalse 
					                                         bool %27 = OpSpecConstantFalse 
					                                              %30 = OpTypeVector %9 2 
					                                              %31 = OpTypePointer Private %30 
					                               Private f32_2* %32 = OpVariable Private 
					                                              %33 = OpTypePointer Input %11 
					                                 Input f32_4* %34 = OpVariable Input 
					                                              %40 = OpTypeImage %9 Dim2D 0 0 0 1 Unknown 
					                                              %41 = OpTypeSampledImage %40 
					                                              %42 = OpTypePointer UniformConstant %41 
					  UniformConstant read_only Texture2DSampled* %43 = OpVariable UniformConstant 
					                                              %47 = OpTypeInt 32 0 
					                                          u32 %48 = OpConstant 0 
					                                              %50 = OpTypePointer Private %9 
					                                          i32 %52 = OpConstant 0 
					                                          u32 %53 = OpConstant 2 
					                                          u32 %59 = OpConstant 3 
					                                          f32 %64 = OpConstant 3.674022E-40 
					                                              %71 = OpTypePointer Input %9 
					                                          f32 %85 = OpConstant 3.674022E-40 
					                                 Input f32_4* %90 = OpVariable Input 
					                                 Private f32* %95 = OpVariable Private 
					                                             %101 = OpTypeVector %9 3 
					                                             %102 = OpTypePointer Private %101 
					                              Private f32_3* %103 = OpVariable Private 
					 UniformConstant read_only Texture2DSampled* %104 = OpVariable UniformConstant 
					                                             %106 = OpTypePointer Input %30 
					                                Input f32_2* %107 = OpVariable Input 
					                              Private f32_2* %113 = OpVariable Private 
					                                         f32 %116 = OpConstant 3.674022E-40 
					                                       f32_2 %117 = OpConstantComposite %116 %116 
					                                         f32 %119 = OpConstant 3.674022E-40 
					                                       f32_2 %120 = OpConstantComposite %119 %119 
					                              Private f32_3* %122 = OpVariable Private 
					                                         i32 %124 = OpConstant 1 
					                                         i32 %133 = OpConstant 3 
					                                             %134 = OpTypePointer Uniform %11 
					                                Input f32_4* %143 = OpVariable Input 
					 UniformConstant read_only Texture2DSampled* %159 = OpVariable UniformConstant 
					                              Private f32_3* %165 = OpVariable Private 
					 UniformConstant read_only Texture2DSampled* %166 = OpVariable UniformConstant 
					                                Input f32_2* %168 = OpVariable Input 
					                              Private f32_3* %172 = OpVariable Private 
					                                Private f32* %177 = OpVariable Private 
					 UniformConstant read_only Texture2DSampled* %178 = OpVariable UniformConstant 
					                                Input f32_2* %180 = OpVariable Input 
					                                Private f32* %184 = OpVariable Private 
					                              Private f32_3* %188 = OpVariable Private 
					                                         i32 %190 = OpConstant 2 
					                                         i32 %204 = OpConstant 4 
					                                             %220 = OpTypePointer Output %11 
					                               Output f32_4* %221 = OpVariable Output 
					                                             %226 = OpTypePointer Output %9 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                 Uniform f32* %18 = OpAccessChain %14 %16 
					                                          f32 %19 = OpLoad %18 
					                                         bool %20 = OpFOrdLessThan %10 %19 
					                                                      OpStore %8 %20 
					                                                      OpSelectionMerge %23 None 
					                                                      OpBranchConditional %21 %22 %23 
					                                              %22 = OpLabel 
					                                         bool %24 = OpLoad %8 
					                                                      OpSelectionMerge %26 None 
					                                                      OpBranchConditional %24 %25 %26 
					                                              %25 = OpLabel 
					                                                      OpBranch %26 
					                                              %26 = OpLabel 
					                                                      OpBranch %23 
					                                              %23 = OpLabel 
					                                                      OpSelectionMerge %29 None 
					                                                      OpBranchConditional %27 %28 %98 
					                                              %28 = OpLabel 
					                                        f32_4 %35 = OpLoad %34 
					                                        f32_2 %36 = OpVectorShuffle %35 %35 0 1 
					                                        f32_4 %37 = OpLoad %34 
					                                        f32_2 %38 = OpVectorShuffle %37 %37 3 3 
					                                        f32_2 %39 = OpFDiv %36 %38 
					                                                      OpStore %32 %39 
					                   read_only Texture2DSampled %44 = OpLoad %43 
					                                        f32_2 %45 = OpLoad %32 
					                                        f32_4 %46 = OpImageSampleImplicitLod %44 %45 
					                                          f32 %49 = OpCompositeExtract %46 0 
					                                 Private f32* %51 = OpAccessChain %32 %48 
					                                                      OpStore %51 %49 
					                                 Uniform f32* %54 = OpAccessChain %14 %52 %53 
					                                          f32 %55 = OpLoad %54 
					                                 Private f32* %56 = OpAccessChain %32 %48 
					                                          f32 %57 = OpLoad %56 
					                                          f32 %58 = OpFMul %55 %57 
					                                 Uniform f32* %60 = OpAccessChain %14 %52 %59 
					                                          f32 %61 = OpLoad %60 
					                                          f32 %62 = OpFAdd %58 %61 
					                                 Private f32* %63 = OpAccessChain %32 %48 
					                                                      OpStore %63 %62 
					                                 Private f32* %65 = OpAccessChain %32 %48 
					                                          f32 %66 = OpLoad %65 
					                                          f32 %67 = OpFDiv %64 %66 
					                                 Private f32* %68 = OpAccessChain %32 %48 
					                                                      OpStore %68 %67 
					                                 Private f32* %69 = OpAccessChain %32 %48 
					                                          f32 %70 = OpLoad %69 
					                                   Input f32* %72 = OpAccessChain %34 %53 
					                                          f32 %73 = OpLoad %72 
					                                          f32 %74 = OpFNegate %73 
					                                          f32 %75 = OpFAdd %70 %74 
					                                 Private f32* %76 = OpAccessChain %32 %48 
					                                                      OpStore %76 %75 
					                                 Private f32* %77 = OpAccessChain %32 %48 
					                                          f32 %78 = OpLoad %77 
					                                 Uniform f32* %79 = OpAccessChain %14 %16 
					                                          f32 %80 = OpLoad %79 
					                                          f32 %81 = OpFMul %78 %80 
					                                 Private f32* %82 = OpAccessChain %32 %48 
					                                                      OpStore %82 %81 
					                                 Private f32* %83 = OpAccessChain %32 %48 
					                                          f32 %84 = OpLoad %83 
					                                          f32 %86 = OpExtInst %1 43 %84 %85 %64 
					                                 Private f32* %87 = OpAccessChain %32 %48 
					                                                      OpStore %87 %86 
					                                 Private f32* %88 = OpAccessChain %32 %48 
					                                          f32 %89 = OpLoad %88 
					                                   Input f32* %91 = OpAccessChain %90 %59 
					                                          f32 %92 = OpLoad %91 
					                                          f32 %93 = OpFMul %89 %92 
					                                 Private f32* %94 = OpAccessChain %32 %48 
					                                                      OpStore %94 %93 
					                                 Private f32* %96 = OpAccessChain %32 %48 
					                                          f32 %97 = OpLoad %96 
					                                                      OpStore %95 %97 
					                                                      OpBranch %29 
					                                              %98 = OpLabel 
					                                   Input f32* %99 = OpAccessChain %90 %59 
					                                         f32 %100 = OpLoad %99 
					                                                      OpStore %95 %100 
					                                                      OpBranch %29 
					                                              %29 = OpLabel 
					                  read_only Texture2DSampled %105 = OpLoad %104 
					                                       f32_2 %108 = OpLoad %107 
					                                       f32_4 %109 = OpImageSampleImplicitLod %105 %108 
					                                       f32_2 %110 = OpVectorShuffle %109 %109 0 1 
					                                       f32_3 %111 = OpLoad %103 
					                                       f32_3 %112 = OpVectorShuffle %111 %110 3 4 2 
					                                                      OpStore %103 %112 
					                                       f32_3 %114 = OpLoad %103 
					                                       f32_2 %115 = OpVectorShuffle %114 %114 0 1 
					                                       f32_2 %118 = OpFMul %115 %117 
					                                       f32_2 %121 = OpFAdd %118 %120 
					                                                      OpStore %113 %121 
					                                       f32_2 %123 = OpLoad %113 
					                                Uniform f32* %125 = OpAccessChain %14 %124 
					                                         f32 %126 = OpLoad %125 
					                                       f32_2 %127 = OpCompositeConstruct %126 %126 
					                                       f32_2 %128 = OpFMul %123 %127 
					                                       f32_3 %129 = OpLoad %122 
					                                       f32_3 %130 = OpVectorShuffle %129 %128 3 4 2 
					                                                      OpStore %122 %130 
					                                       f32_3 %131 = OpLoad %122 
					                                       f32_2 %132 = OpVectorShuffle %131 %131 0 1 
					                              Uniform f32_4* %135 = OpAccessChain %14 %133 
					                                       f32_4 %136 = OpLoad %135 
					                                       f32_2 %137 = OpVectorShuffle %136 %136 0 1 
					                                       f32_2 %138 = OpFMul %132 %137 
					                                       f32_3 %139 = OpLoad %122 
					                                       f32_3 %140 = OpVectorShuffle %139 %138 3 4 2 
					                                                      OpStore %122 %140 
					                                       f32_3 %141 = OpLoad %122 
					                                       f32_2 %142 = OpVectorShuffle %141 %141 0 1 
					                                       f32_4 %144 = OpLoad %143 
					                                       f32_2 %145 = OpVectorShuffle %144 %144 2 2 
					                                       f32_2 %146 = OpFMul %142 %145 
					                                       f32_4 %147 = OpLoad %143 
					                                       f32_2 %148 = OpVectorShuffle %147 %147 0 1 
					                                       f32_2 %149 = OpFAdd %146 %148 
					                                       f32_3 %150 = OpLoad %122 
					                                       f32_3 %151 = OpVectorShuffle %150 %149 3 4 2 
					                                                      OpStore %122 %151 
					                                       f32_3 %152 = OpLoad %122 
					                                       f32_2 %153 = OpVectorShuffle %152 %152 0 1 
					                                       f32_4 %154 = OpLoad %143 
					                                       f32_2 %155 = OpVectorShuffle %154 %154 3 3 
					                                       f32_2 %156 = OpFDiv %153 %155 
					                                       f32_3 %157 = OpLoad %122 
					                                       f32_3 %158 = OpVectorShuffle %157 %156 3 4 2 
					                                                      OpStore %122 %158 
					                  read_only Texture2DSampled %160 = OpLoad %159 
					                                       f32_3 %161 = OpLoad %122 
					                                       f32_2 %162 = OpVectorShuffle %161 %161 0 1 
					                                       f32_4 %163 = OpImageSampleImplicitLod %160 %162 
					                                       f32_3 %164 = OpVectorShuffle %163 %163 0 1 2 
					                                                      OpStore %103 %164 
					                  read_only Texture2DSampled %167 = OpLoad %166 
					                                       f32_2 %169 = OpLoad %168 
					                                       f32_4 %170 = OpImageSampleImplicitLod %167 %169 
					                                       f32_3 %171 = OpVectorShuffle %170 %170 0 1 2 
					                                                      OpStore %165 %171 
					                                       f32_3 %173 = OpLoad %165 
					                                       f32_4 %174 = OpLoad %90 
					                                       f32_3 %175 = OpVectorShuffle %174 %174 0 1 2 
					                                       f32_3 %176 = OpFMul %173 %175 
					                                                      OpStore %172 %176 
					                  read_only Texture2DSampled %179 = OpLoad %178 
					                                       f32_2 %181 = OpLoad %180 
					                                       f32_4 %182 = OpImageSampleImplicitLod %179 %181 
					                                         f32 %183 = OpCompositeExtract %182 3 
					                                                      OpStore %177 %183 
					                                         f32 %185 = OpLoad %95 
					                                         f32 %186 = OpLoad %177 
					                                         f32 %187 = OpFMul %185 %186 
					                                                      OpStore %184 %187 
					                                       f32_3 %189 = OpLoad %172 
					                                Uniform f32* %191 = OpAccessChain %14 %190 
					                                         f32 %192 = OpLoad %191 
					                                Uniform f32* %193 = OpAccessChain %14 %190 
					                                         f32 %194 = OpLoad %193 
					                                Uniform f32* %195 = OpAccessChain %14 %190 
					                                         f32 %196 = OpLoad %195 
					                                       f32_3 %197 = OpCompositeConstruct %192 %194 %196 
					                                         f32 %198 = OpCompositeExtract %197 0 
					                                         f32 %199 = OpCompositeExtract %197 1 
					                                         f32 %200 = OpCompositeExtract %197 2 
					                                       f32_3 %201 = OpCompositeConstruct %198 %199 %200 
					                                       f32_3 %202 = OpFMul %189 %201 
					                                                      OpStore %188 %202 
					                                       f32_3 %203 = OpLoad %188 
					                              Uniform f32_4* %205 = OpAccessChain %14 %204 
					                                       f32_4 %206 = OpLoad %205 
					                                       f32_3 %207 = OpVectorShuffle %206 %206 0 1 2 
					                                       f32_3 %208 = OpFMul %203 %207 
					                                                      OpStore %188 %208 
					                                       f32_3 %209 = OpLoad %103 
					                                       f32_4 %210 = OpLoad %90 
					                                       f32_3 %211 = OpVectorShuffle %210 %210 0 1 2 
					                                       f32_3 %212 = OpFMul %209 %211 
					                                       f32_3 %213 = OpLoad %188 
					                                       f32_3 %214 = OpFAdd %212 %213 
					                                                      OpStore %122 %214 
					                                         f32 %215 = OpLoad %95 
					                                Uniform f32* %216 = OpAccessChain %14 %204 %59 
					                                         f32 %217 = OpLoad %216 
					                                         f32 %218 = OpFMul %215 %217 
					                                Private f32* %219 = OpAccessChain %113 %48 
					                                                      OpStore %219 %218 
					                                         f32 %222 = OpLoad %184 
					                                Private f32* %223 = OpAccessChain %113 %48 
					                                         f32 %224 = OpLoad %223 
					                                         f32 %225 = OpFMul %222 %224 
					                                 Output f32* %227 = OpAccessChain %221 %59 
					                                                      OpStore %227 %225 
					                                       f32_3 %228 = OpLoad %122 
					                                       f32_4 %229 = OpLoad %221 
					                                       f32_4 %230 = OpVectorShuffle %229 %228 4 5 6 3 
					                                                      OpStore %221 %230 
					                                                      OpReturn
					                                                      OpFunctionEnd"
				}
			}
			Program "fp" {
				SubProgram "gles hw_tier00 " {
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					"!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					"!!GLES3"
				}
				SubProgram "vulkan hw_tier00 " {
					"spirv"
				}
				SubProgram "vulkan hw_tier01 " {
					"spirv"
				}
				SubProgram "vulkan hw_tier02 " {
					"spirv"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "SOFTPARTICLES_ON" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "SOFTPARTICLES_ON" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "SOFTPARTICLES_ON" }
					"!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "SOFTPARTICLES_ON" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "SOFTPARTICLES_ON" }
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "SOFTPARTICLES_ON" }
					"!!GLES3"
				}
				SubProgram "vulkan hw_tier00 " {
					Keywords { "SOFTPARTICLES_ON" }
					"spirv"
				}
				SubProgram "vulkan hw_tier01 " {
					Keywords { "SOFTPARTICLES_ON" }
					"spirv"
				}
				SubProgram "vulkan hw_tier02 " {
					Keywords { "SOFTPARTICLES_ON" }
					"spirv"
				}
			}
		}
	}
	SubShader {
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Opaque" }
		Pass {
			Name "BASE"
			Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Opaque" }
			Blend DstColor Zero, DstColor Zero
			ZClip Off
			ZWrite Off
			Cull Off
			Fog {
				Mode Off
			}
			GpuProgramID 84166
			Program "vp" {
				SubProgram "gles hw_tier00 " {
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _MainTex_ST;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 tmpvar_2;
					  tmpvar_2 = clamp (vec4(0.0, 0.0, 0.0, 1.1), 0.0, 1.0);
					  tmpvar_1 = tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  xlv_COLOR0 = tmpvar_1;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _MainTex_ST;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 tmpvar_2;
					  tmpvar_2 = clamp (vec4(0.0, 0.0, 0.0, 1.1), 0.0, 1.0);
					  tmpvar_1 = tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  xlv_COLOR0 = tmpvar_1;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _MainTex_ST;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 tmpvar_2;
					  tmpvar_2 = clamp (vec4(0.0, 0.0, 0.0, 1.1), 0.0, 1.0);
					  tmpvar_1 = tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  xlv_COLOR0 = tmpvar_1;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec3 in_POSITION0;
					in highp vec3 in_TEXCOORD0;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 1.0);
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    SV_Target0 = u_xlat10_0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec3 in_POSITION0;
					in highp vec3 in_TEXCOORD0;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 1.0);
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    SV_Target0 = u_xlat10_0;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					
					uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec3 in_POSITION0;
					in highp vec3 in_TEXCOORD0;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_COLOR0 = vec4(0.0, 0.0, 0.0, 1.0);
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    SV_Target0 = u_xlat10_0;
					    return;
					}
					
					#endif"
				}
				SubProgram "vulkan hw_tier00 " {
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 1
					; Bound: 107
					; Schema: 0
					                                                     OpCapability Shader 
					                                              %1 = OpExtInstImport "GLSL.std.450" 
					                                                     OpMemoryModel Logical GLSL450 
					                                                     OpEntryPoint Vertex %4 "main" %9 %15 %18 %41 %92 
					                                                     OpDecorate %9 RelaxedPrecision 
					                                                     OpDecorate %9 Location 9 
					                                                     OpDecorate %15 Location 15 
					                                                     OpDecorate %18 Location 18 
					                                                     OpDecorate %23 ArrayStride 23 
					                                                     OpDecorate %24 ArrayStride 24 
					                                                     OpMemberDecorate %25 0 Offset 25 
					                                                     OpMemberDecorate %25 1 Offset 25 
					                                                     OpMemberDecorate %25 2 Offset 25 
					                                                     OpDecorate %25 Block 
					                                                     OpDecorate %27 DescriptorSet 27 
					                                                     OpDecorate %27 Binding 27 
					                                                     OpDecorate %41 Location 41 
					                                                     OpMemberDecorate %90 0 BuiltIn 90 
					                                                     OpMemberDecorate %90 1 BuiltIn 90 
					                                                     OpMemberDecorate %90 2 BuiltIn 90 
					                                                     OpDecorate %90 Block 
					                                              %2 = OpTypeVoid 
					                                              %3 = OpTypeFunction %2 
					                                              %6 = OpTypeFloat 32 
					                                              %7 = OpTypeVector %6 4 
					                                              %8 = OpTypePointer Output %7 
					                                Output f32_4* %9 = OpVariable Output 
					                                         f32 %10 = OpConstant 3.674022E-40 
					                                         f32 %11 = OpConstant 3.674022E-40 
					                                       f32_4 %12 = OpConstantComposite %10 %10 %10 %11 
					                                             %13 = OpTypeVector %6 2 
					                                             %14 = OpTypePointer Output %13 
					                               Output f32_2* %15 = OpVariable Output 
					                                             %16 = OpTypeVector %6 3 
					                                             %17 = OpTypePointer Input %16 
					                                Input f32_3* %18 = OpVariable Input 
					                                             %21 = OpTypeInt 32 0 
					                                         u32 %22 = OpConstant 4 
					                                             %23 = OpTypeArray %7 %22 
					                                             %24 = OpTypeArray %7 %22 
					                                             %25 = OpTypeStruct %23 %24 %7 
					                                             %26 = OpTypePointer Uniform %25 
					Uniform struct {f32_4[4]; f32_4[4]; f32_4;}* %27 = OpVariable Uniform 
					                                             %28 = OpTypeInt 32 1 
					                                         i32 %29 = OpConstant 2 
					                                             %30 = OpTypePointer Uniform %7 
					                                             %39 = OpTypePointer Private %7 
					                              Private f32_4* %40 = OpVariable Private 
					                                Input f32_3* %41 = OpVariable Input 
					                                         i32 %44 = OpConstant 0 
					                                         i32 %45 = OpConstant 1 
					                                         i32 %64 = OpConstant 3 
					                              Private f32_4* %68 = OpVariable Private 
					                                         u32 %88 = OpConstant 1 
					                                             %89 = OpTypeArray %6 %88 
					                                             %90 = OpTypeStruct %7 %6 %89 
					                                             %91 = OpTypePointer Output %90 
					        Output struct {f32_4; f32; f32[1];}* %92 = OpVariable Output 
					                                            %101 = OpTypePointer Output %6 
					                                         void %4 = OpFunction None %3 
					                                              %5 = OpLabel 
					                                                     OpStore %9 %12 
					                                       f32_3 %19 = OpLoad %18 
					                                       f32_2 %20 = OpVectorShuffle %19 %19 0 1 
					                              Uniform f32_4* %31 = OpAccessChain %27 %29 
					                                       f32_4 %32 = OpLoad %31 
					                                       f32_2 %33 = OpVectorShuffle %32 %32 0 1 
					                                       f32_2 %34 = OpFMul %20 %33 
					                              Uniform f32_4* %35 = OpAccessChain %27 %29 
					                                       f32_4 %36 = OpLoad %35 
					                                       f32_2 %37 = OpVectorShuffle %36 %36 2 3 
					                                       f32_2 %38 = OpFAdd %34 %37 
					                                                     OpStore %15 %38 
					                                       f32_3 %42 = OpLoad %41 
					                                       f32_4 %43 = OpVectorShuffle %42 %42 1 1 1 1 
					                              Uniform f32_4* %46 = OpAccessChain %27 %44 %45 
					                                       f32_4 %47 = OpLoad %46 
					                                       f32_4 %48 = OpFMul %43 %47 
					                                                     OpStore %40 %48 
					                              Uniform f32_4* %49 = OpAccessChain %27 %44 %44 
					                                       f32_4 %50 = OpLoad %49 
					                                       f32_3 %51 = OpLoad %41 
					                                       f32_4 %52 = OpVectorShuffle %51 %51 0 0 0 0 
					                                       f32_4 %53 = OpFMul %50 %52 
					                                       f32_4 %54 = OpLoad %40 
					                                       f32_4 %55 = OpFAdd %53 %54 
					                                                     OpStore %40 %55 
					                              Uniform f32_4* %56 = OpAccessChain %27 %44 %29 
					                                       f32_4 %57 = OpLoad %56 
					                                       f32_3 %58 = OpLoad %41 
					                                       f32_4 %59 = OpVectorShuffle %58 %58 2 2 2 2 
					                                       f32_4 %60 = OpFMul %57 %59 
					                                       f32_4 %61 = OpLoad %40 
					                                       f32_4 %62 = OpFAdd %60 %61 
					                                                     OpStore %40 %62 
					                                       f32_4 %63 = OpLoad %40 
					                              Uniform f32_4* %65 = OpAccessChain %27 %44 %64 
					                                       f32_4 %66 = OpLoad %65 
					                                       f32_4 %67 = OpFAdd %63 %66 
					                                                     OpStore %40 %67 
					                                       f32_4 %69 = OpLoad %40 
					                                       f32_4 %70 = OpVectorShuffle %69 %69 1 1 1 1 
					                              Uniform f32_4* %71 = OpAccessChain %27 %45 %45 
					                                       f32_4 %72 = OpLoad %71 
					                                       f32_4 %73 = OpFMul %70 %72 
					                                                     OpStore %68 %73 
					                              Uniform f32_4* %74 = OpAccessChain %27 %45 %44 
					                                       f32_4 %75 = OpLoad %74 
					                                       f32_4 %76 = OpLoad %40 
					                                       f32_4 %77 = OpVectorShuffle %76 %76 0 0 0 0 
					                                       f32_4 %78 = OpFMul %75 %77 
					                                       f32_4 %79 = OpLoad %68 
					                                       f32_4 %80 = OpFAdd %78 %79 
					                                                     OpStore %68 %80 
					                              Uniform f32_4* %81 = OpAccessChain %27 %45 %29 
					                                       f32_4 %82 = OpLoad %81 
					                                       f32_4 %83 = OpLoad %40 
					                                       f32_4 %84 = OpVectorShuffle %83 %83 2 2 2 2 
					                                       f32_4 %85 = OpFMul %82 %84 
					                                       f32_4 %86 = OpLoad %68 
					                                       f32_4 %87 = OpFAdd %85 %86 
					                                                     OpStore %68 %87 
					                              Uniform f32_4* %93 = OpAccessChain %27 %45 %64 
					                                       f32_4 %94 = OpLoad %93 
					                                       f32_4 %95 = OpLoad %40 
					                                       f32_4 %96 = OpVectorShuffle %95 %95 3 3 3 3 
					                                       f32_4 %97 = OpFMul %94 %96 
					                                       f32_4 %98 = OpLoad %68 
					                                       f32_4 %99 = OpFAdd %97 %98 
					                              Output f32_4* %100 = OpAccessChain %92 %44 
					                                                     OpStore %100 %99 
					                                Output f32* %102 = OpAccessChain %92 %44 %88 
					                                        f32 %103 = OpLoad %102 
					                                        f32 %104 = OpFNegate %103 
					                                Output f32* %105 = OpAccessChain %92 %44 %88 
					                                                     OpStore %105 %104 
					                                                     OpReturn
					                                                     OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 1
					; Bound: 24
					; Schema: 0
					                                                    OpCapability Shader 
					                                             %1 = OpExtInstImport "GLSL.std.450" 
					                                                    OpMemoryModel Logical GLSL450 
					                                                    OpEntryPoint Fragment %4 "main" %17 %21 
					                                                    OpExecutionMode %4 OriginUpperLeft 
					                                                    OpDecorate %9 RelaxedPrecision 
					                                                    OpDecorate %13 RelaxedPrecision 
					                                                    OpDecorate %13 DescriptorSet 13 
					                                                    OpDecorate %13 Binding 13 
					                                                    OpDecorate %14 RelaxedPrecision 
					                                                    OpDecorate %17 Location 17 
					                                                    OpDecorate %21 RelaxedPrecision 
					                                                    OpDecorate %21 Location 21 
					                                                    OpDecorate %22 RelaxedPrecision 
					                                             %2 = OpTypeVoid 
					                                             %3 = OpTypeFunction %2 
					                                             %6 = OpTypeFloat 32 
					                                             %7 = OpTypeVector %6 4 
					                                             %8 = OpTypePointer Private %7 
					                              Private f32_4* %9 = OpVariable Private 
					                                            %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                            %11 = OpTypeSampledImage %10 
					                                            %12 = OpTypePointer UniformConstant %11 
					UniformConstant read_only Texture2DSampled* %13 = OpVariable UniformConstant 
					                                            %15 = OpTypeVector %6 2 
					                                            %16 = OpTypePointer Input %15 
					                               Input f32_2* %17 = OpVariable Input 
					                                            %20 = OpTypePointer Output %7 
					                              Output f32_4* %21 = OpVariable Output 
					                                        void %4 = OpFunction None %3 
					                                             %5 = OpLabel 
					                 read_only Texture2DSampled %14 = OpLoad %13 
					                                      f32_2 %18 = OpLoad %17 
					                                      f32_4 %19 = OpImageSampleImplicitLod %14 %18 
					                                                    OpStore %9 %19 
					                                      f32_4 %22 = OpLoad %9 
					                                                    OpStore %21 %22 
					                                                    OpReturn
					                                                    OpFunctionEnd"
				}
				SubProgram "vulkan hw_tier01 " {
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 1
					; Bound: 107
					; Schema: 0
					                                                     OpCapability Shader 
					                                              %1 = OpExtInstImport "GLSL.std.450" 
					                                                     OpMemoryModel Logical GLSL450 
					                                                     OpEntryPoint Vertex %4 "main" %9 %15 %18 %41 %92 
					                                                     OpDecorate %9 RelaxedPrecision 
					                                                     OpDecorate %9 Location 9 
					                                                     OpDecorate %15 Location 15 
					                                                     OpDecorate %18 Location 18 
					                                                     OpDecorate %23 ArrayStride 23 
					                                                     OpDecorate %24 ArrayStride 24 
					                                                     OpMemberDecorate %25 0 Offset 25 
					                                                     OpMemberDecorate %25 1 Offset 25 
					                                                     OpMemberDecorate %25 2 Offset 25 
					                                                     OpDecorate %25 Block 
					                                                     OpDecorate %27 DescriptorSet 27 
					                                                     OpDecorate %27 Binding 27 
					                                                     OpDecorate %41 Location 41 
					                                                     OpMemberDecorate %90 0 BuiltIn 90 
					                                                     OpMemberDecorate %90 1 BuiltIn 90 
					                                                     OpMemberDecorate %90 2 BuiltIn 90 
					                                                     OpDecorate %90 Block 
					                                              %2 = OpTypeVoid 
					                                              %3 = OpTypeFunction %2 
					                                              %6 = OpTypeFloat 32 
					                                              %7 = OpTypeVector %6 4 
					                                              %8 = OpTypePointer Output %7 
					                                Output f32_4* %9 = OpVariable Output 
					                                         f32 %10 = OpConstant 3.674022E-40 
					                                         f32 %11 = OpConstant 3.674022E-40 
					                                       f32_4 %12 = OpConstantComposite %10 %10 %10 %11 
					                                             %13 = OpTypeVector %6 2 
					                                             %14 = OpTypePointer Output %13 
					                               Output f32_2* %15 = OpVariable Output 
					                                             %16 = OpTypeVector %6 3 
					                                             %17 = OpTypePointer Input %16 
					                                Input f32_3* %18 = OpVariable Input 
					                                             %21 = OpTypeInt 32 0 
					                                         u32 %22 = OpConstant 4 
					                                             %23 = OpTypeArray %7 %22 
					                                             %24 = OpTypeArray %7 %22 
					                                             %25 = OpTypeStruct %23 %24 %7 
					                                             %26 = OpTypePointer Uniform %25 
					Uniform struct {f32_4[4]; f32_4[4]; f32_4;}* %27 = OpVariable Uniform 
					                                             %28 = OpTypeInt 32 1 
					                                         i32 %29 = OpConstant 2 
					                                             %30 = OpTypePointer Uniform %7 
					                                             %39 = OpTypePointer Private %7 
					                              Private f32_4* %40 = OpVariable Private 
					                                Input f32_3* %41 = OpVariable Input 
					                                         i32 %44 = OpConstant 0 
					                                         i32 %45 = OpConstant 1 
					                                         i32 %64 = OpConstant 3 
					                              Private f32_4* %68 = OpVariable Private 
					                                         u32 %88 = OpConstant 1 
					                                             %89 = OpTypeArray %6 %88 
					                                             %90 = OpTypeStruct %7 %6 %89 
					                                             %91 = OpTypePointer Output %90 
					        Output struct {f32_4; f32; f32[1];}* %92 = OpVariable Output 
					                                            %101 = OpTypePointer Output %6 
					                                         void %4 = OpFunction None %3 
					                                              %5 = OpLabel 
					                                                     OpStore %9 %12 
					                                       f32_3 %19 = OpLoad %18 
					                                       f32_2 %20 = OpVectorShuffle %19 %19 0 1 
					                              Uniform f32_4* %31 = OpAccessChain %27 %29 
					                                       f32_4 %32 = OpLoad %31 
					                                       f32_2 %33 = OpVectorShuffle %32 %32 0 1 
					                                       f32_2 %34 = OpFMul %20 %33 
					                              Uniform f32_4* %35 = OpAccessChain %27 %29 
					                                       f32_4 %36 = OpLoad %35 
					                                       f32_2 %37 = OpVectorShuffle %36 %36 2 3 
					                                       f32_2 %38 = OpFAdd %34 %37 
					                                                     OpStore %15 %38 
					                                       f32_3 %42 = OpLoad %41 
					                                       f32_4 %43 = OpVectorShuffle %42 %42 1 1 1 1 
					                              Uniform f32_4* %46 = OpAccessChain %27 %44 %45 
					                                       f32_4 %47 = OpLoad %46 
					                                       f32_4 %48 = OpFMul %43 %47 
					                                                     OpStore %40 %48 
					                              Uniform f32_4* %49 = OpAccessChain %27 %44 %44 
					                                       f32_4 %50 = OpLoad %49 
					                                       f32_3 %51 = OpLoad %41 
					                                       f32_4 %52 = OpVectorShuffle %51 %51 0 0 0 0 
					                                       f32_4 %53 = OpFMul %50 %52 
					                                       f32_4 %54 = OpLoad %40 
					                                       f32_4 %55 = OpFAdd %53 %54 
					                                                     OpStore %40 %55 
					                              Uniform f32_4* %56 = OpAccessChain %27 %44 %29 
					                                       f32_4 %57 = OpLoad %56 
					                                       f32_3 %58 = OpLoad %41 
					                                       f32_4 %59 = OpVectorShuffle %58 %58 2 2 2 2 
					                                       f32_4 %60 = OpFMul %57 %59 
					                                       f32_4 %61 = OpLoad %40 
					                                       f32_4 %62 = OpFAdd %60 %61 
					                                                     OpStore %40 %62 
					                                       f32_4 %63 = OpLoad %40 
					                              Uniform f32_4* %65 = OpAccessChain %27 %44 %64 
					                                       f32_4 %66 = OpLoad %65 
					                                       f32_4 %67 = OpFAdd %63 %66 
					                                                     OpStore %40 %67 
					                                       f32_4 %69 = OpLoad %40 
					                                       f32_4 %70 = OpVectorShuffle %69 %69 1 1 1 1 
					                              Uniform f32_4* %71 = OpAccessChain %27 %45 %45 
					                                       f32_4 %72 = OpLoad %71 
					                                       f32_4 %73 = OpFMul %70 %72 
					                                                     OpStore %68 %73 
					                              Uniform f32_4* %74 = OpAccessChain %27 %45 %44 
					                                       f32_4 %75 = OpLoad %74 
					                                       f32_4 %76 = OpLoad %40 
					                                       f32_4 %77 = OpVectorShuffle %76 %76 0 0 0 0 
					                                       f32_4 %78 = OpFMul %75 %77 
					                                       f32_4 %79 = OpLoad %68 
					                                       f32_4 %80 = OpFAdd %78 %79 
					                                                     OpStore %68 %80 
					                              Uniform f32_4* %81 = OpAccessChain %27 %45 %29 
					                                       f32_4 %82 = OpLoad %81 
					                                       f32_4 %83 = OpLoad %40 
					                                       f32_4 %84 = OpVectorShuffle %83 %83 2 2 2 2 
					                                       f32_4 %85 = OpFMul %82 %84 
					                                       f32_4 %86 = OpLoad %68 
					                                       f32_4 %87 = OpFAdd %85 %86 
					                                                     OpStore %68 %87 
					                              Uniform f32_4* %93 = OpAccessChain %27 %45 %64 
					                                       f32_4 %94 = OpLoad %93 
					                                       f32_4 %95 = OpLoad %40 
					                                       f32_4 %96 = OpVectorShuffle %95 %95 3 3 3 3 
					                                       f32_4 %97 = OpFMul %94 %96 
					                                       f32_4 %98 = OpLoad %68 
					                                       f32_4 %99 = OpFAdd %97 %98 
					                              Output f32_4* %100 = OpAccessChain %92 %44 
					                                                     OpStore %100 %99 
					                                Output f32* %102 = OpAccessChain %92 %44 %88 
					                                        f32 %103 = OpLoad %102 
					                                        f32 %104 = OpFNegate %103 
					                                Output f32* %105 = OpAccessChain %92 %44 %88 
					                                                     OpStore %105 %104 
					                                                     OpReturn
					                                                     OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 1
					; Bound: 24
					; Schema: 0
					                                                    OpCapability Shader 
					                                             %1 = OpExtInstImport "GLSL.std.450" 
					                                                    OpMemoryModel Logical GLSL450 
					                                                    OpEntryPoint Fragment %4 "main" %17 %21 
					                                                    OpExecutionMode %4 OriginUpperLeft 
					                                                    OpDecorate %9 RelaxedPrecision 
					                                                    OpDecorate %13 RelaxedPrecision 
					                                                    OpDecorate %13 DescriptorSet 13 
					                                                    OpDecorate %13 Binding 13 
					                                                    OpDecorate %14 RelaxedPrecision 
					                                                    OpDecorate %17 Location 17 
					                                                    OpDecorate %21 RelaxedPrecision 
					                                                    OpDecorate %21 Location 21 
					                                                    OpDecorate %22 RelaxedPrecision 
					                                             %2 = OpTypeVoid 
					                                             %3 = OpTypeFunction %2 
					                                             %6 = OpTypeFloat 32 
					                                             %7 = OpTypeVector %6 4 
					                                             %8 = OpTypePointer Private %7 
					                              Private f32_4* %9 = OpVariable Private 
					                                            %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                            %11 = OpTypeSampledImage %10 
					                                            %12 = OpTypePointer UniformConstant %11 
					UniformConstant read_only Texture2DSampled* %13 = OpVariable UniformConstant 
					                                            %15 = OpTypeVector %6 2 
					                                            %16 = OpTypePointer Input %15 
					                               Input f32_2* %17 = OpVariable Input 
					                                            %20 = OpTypePointer Output %7 
					                              Output f32_4* %21 = OpVariable Output 
					                                        void %4 = OpFunction None %3 
					                                             %5 = OpLabel 
					                 read_only Texture2DSampled %14 = OpLoad %13 
					                                      f32_2 %18 = OpLoad %17 
					                                      f32_4 %19 = OpImageSampleImplicitLod %14 %18 
					                                                    OpStore %9 %19 
					                                      f32_4 %22 = OpLoad %9 
					                                                    OpStore %21 %22 
					                                                    OpReturn
					                                                    OpFunctionEnd"
				}
				SubProgram "vulkan hw_tier02 " {
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 1
					; Bound: 107
					; Schema: 0
					                                                     OpCapability Shader 
					                                              %1 = OpExtInstImport "GLSL.std.450" 
					                                                     OpMemoryModel Logical GLSL450 
					                                                     OpEntryPoint Vertex %4 "main" %9 %15 %18 %41 %92 
					                                                     OpDecorate %9 RelaxedPrecision 
					                                                     OpDecorate %9 Location 9 
					                                                     OpDecorate %15 Location 15 
					                                                     OpDecorate %18 Location 18 
					                                                     OpDecorate %23 ArrayStride 23 
					                                                     OpDecorate %24 ArrayStride 24 
					                                                     OpMemberDecorate %25 0 Offset 25 
					                                                     OpMemberDecorate %25 1 Offset 25 
					                                                     OpMemberDecorate %25 2 Offset 25 
					                                                     OpDecorate %25 Block 
					                                                     OpDecorate %27 DescriptorSet 27 
					                                                     OpDecorate %27 Binding 27 
					                                                     OpDecorate %41 Location 41 
					                                                     OpMemberDecorate %90 0 BuiltIn 90 
					                                                     OpMemberDecorate %90 1 BuiltIn 90 
					                                                     OpMemberDecorate %90 2 BuiltIn 90 
					                                                     OpDecorate %90 Block 
					                                              %2 = OpTypeVoid 
					                                              %3 = OpTypeFunction %2 
					                                              %6 = OpTypeFloat 32 
					                                              %7 = OpTypeVector %6 4 
					                                              %8 = OpTypePointer Output %7 
					                                Output f32_4* %9 = OpVariable Output 
					                                         f32 %10 = OpConstant 3.674022E-40 
					                                         f32 %11 = OpConstant 3.674022E-40 
					                                       f32_4 %12 = OpConstantComposite %10 %10 %10 %11 
					                                             %13 = OpTypeVector %6 2 
					                                             %14 = OpTypePointer Output %13 
					                               Output f32_2* %15 = OpVariable Output 
					                                             %16 = OpTypeVector %6 3 
					                                             %17 = OpTypePointer Input %16 
					                                Input f32_3* %18 = OpVariable Input 
					                                             %21 = OpTypeInt 32 0 
					                                         u32 %22 = OpConstant 4 
					                                             %23 = OpTypeArray %7 %22 
					                                             %24 = OpTypeArray %7 %22 
					                                             %25 = OpTypeStruct %23 %24 %7 
					                                             %26 = OpTypePointer Uniform %25 
					Uniform struct {f32_4[4]; f32_4[4]; f32_4;}* %27 = OpVariable Uniform 
					                                             %28 = OpTypeInt 32 1 
					                                         i32 %29 = OpConstant 2 
					                                             %30 = OpTypePointer Uniform %7 
					                                             %39 = OpTypePointer Private %7 
					                              Private f32_4* %40 = OpVariable Private 
					                                Input f32_3* %41 = OpVariable Input 
					                                         i32 %44 = OpConstant 0 
					                                         i32 %45 = OpConstant 1 
					                                         i32 %64 = OpConstant 3 
					                              Private f32_4* %68 = OpVariable Private 
					                                         u32 %88 = OpConstant 1 
					                                             %89 = OpTypeArray %6 %88 
					                                             %90 = OpTypeStruct %7 %6 %89 
					                                             %91 = OpTypePointer Output %90 
					        Output struct {f32_4; f32; f32[1];}* %92 = OpVariable Output 
					                                            %101 = OpTypePointer Output %6 
					                                         void %4 = OpFunction None %3 
					                                              %5 = OpLabel 
					                                                     OpStore %9 %12 
					                                       f32_3 %19 = OpLoad %18 
					                                       f32_2 %20 = OpVectorShuffle %19 %19 0 1 
					                              Uniform f32_4* %31 = OpAccessChain %27 %29 
					                                       f32_4 %32 = OpLoad %31 
					                                       f32_2 %33 = OpVectorShuffle %32 %32 0 1 
					                                       f32_2 %34 = OpFMul %20 %33 
					                              Uniform f32_4* %35 = OpAccessChain %27 %29 
					                                       f32_4 %36 = OpLoad %35 
					                                       f32_2 %37 = OpVectorShuffle %36 %36 2 3 
					                                       f32_2 %38 = OpFAdd %34 %37 
					                                                     OpStore %15 %38 
					                                       f32_3 %42 = OpLoad %41 
					                                       f32_4 %43 = OpVectorShuffle %42 %42 1 1 1 1 
					                              Uniform f32_4* %46 = OpAccessChain %27 %44 %45 
					                                       f32_4 %47 = OpLoad %46 
					                                       f32_4 %48 = OpFMul %43 %47 
					                                                     OpStore %40 %48 
					                              Uniform f32_4* %49 = OpAccessChain %27 %44 %44 
					                                       f32_4 %50 = OpLoad %49 
					                                       f32_3 %51 = OpLoad %41 
					                                       f32_4 %52 = OpVectorShuffle %51 %51 0 0 0 0 
					                                       f32_4 %53 = OpFMul %50 %52 
					                                       f32_4 %54 = OpLoad %40 
					                                       f32_4 %55 = OpFAdd %53 %54 
					                                                     OpStore %40 %55 
					                              Uniform f32_4* %56 = OpAccessChain %27 %44 %29 
					                                       f32_4 %57 = OpLoad %56 
					                                       f32_3 %58 = OpLoad %41 
					                                       f32_4 %59 = OpVectorShuffle %58 %58 2 2 2 2 
					                                       f32_4 %60 = OpFMul %57 %59 
					                                       f32_4 %61 = OpLoad %40 
					                                       f32_4 %62 = OpFAdd %60 %61 
					                                                     OpStore %40 %62 
					                                       f32_4 %63 = OpLoad %40 
					                              Uniform f32_4* %65 = OpAccessChain %27 %44 %64 
					                                       f32_4 %66 = OpLoad %65 
					                                       f32_4 %67 = OpFAdd %63 %66 
					                                                     OpStore %40 %67 
					                                       f32_4 %69 = OpLoad %40 
					                                       f32_4 %70 = OpVectorShuffle %69 %69 1 1 1 1 
					                              Uniform f32_4* %71 = OpAccessChain %27 %45 %45 
					                                       f32_4 %72 = OpLoad %71 
					                                       f32_4 %73 = OpFMul %70 %72 
					                                                     OpStore %68 %73 
					                              Uniform f32_4* %74 = OpAccessChain %27 %45 %44 
					                                       f32_4 %75 = OpLoad %74 
					                                       f32_4 %76 = OpLoad %40 
					                                       f32_4 %77 = OpVectorShuffle %76 %76 0 0 0 0 
					                                       f32_4 %78 = OpFMul %75 %77 
					                                       f32_4 %79 = OpLoad %68 
					                                       f32_4 %80 = OpFAdd %78 %79 
					                                                     OpStore %68 %80 
					                              Uniform f32_4* %81 = OpAccessChain %27 %45 %29 
					                                       f32_4 %82 = OpLoad %81 
					                                       f32_4 %83 = OpLoad %40 
					                                       f32_4 %84 = OpVectorShuffle %83 %83 2 2 2 2 
					                                       f32_4 %85 = OpFMul %82 %84 
					                                       f32_4 %86 = OpLoad %68 
					                                       f32_4 %87 = OpFAdd %85 %86 
					                                                     OpStore %68 %87 
					                              Uniform f32_4* %93 = OpAccessChain %27 %45 %64 
					                                       f32_4 %94 = OpLoad %93 
					                                       f32_4 %95 = OpLoad %40 
					                                       f32_4 %96 = OpVectorShuffle %95 %95 3 3 3 3 
					                                       f32_4 %97 = OpFMul %94 %96 
					                                       f32_4 %98 = OpLoad %68 
					                                       f32_4 %99 = OpFAdd %97 %98 
					                              Output f32_4* %100 = OpAccessChain %92 %44 
					                                                     OpStore %100 %99 
					                                Output f32* %102 = OpAccessChain %92 %44 %88 
					                                        f32 %103 = OpLoad %102 
					                                        f32 %104 = OpFNegate %103 
					                                Output f32* %105 = OpAccessChain %92 %44 %88 
					                                                     OpStore %105 %104 
					                                                     OpReturn
					                                                     OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 1
					; Bound: 24
					; Schema: 0
					                                                    OpCapability Shader 
					                                             %1 = OpExtInstImport "GLSL.std.450" 
					                                                    OpMemoryModel Logical GLSL450 
					                                                    OpEntryPoint Fragment %4 "main" %17 %21 
					                                                    OpExecutionMode %4 OriginUpperLeft 
					                                                    OpDecorate %9 RelaxedPrecision 
					                                                    OpDecorate %13 RelaxedPrecision 
					                                                    OpDecorate %13 DescriptorSet 13 
					                                                    OpDecorate %13 Binding 13 
					                                                    OpDecorate %14 RelaxedPrecision 
					                                                    OpDecorate %17 Location 17 
					                                                    OpDecorate %21 RelaxedPrecision 
					                                                    OpDecorate %21 Location 21 
					                                                    OpDecorate %22 RelaxedPrecision 
					                                             %2 = OpTypeVoid 
					                                             %3 = OpTypeFunction %2 
					                                             %6 = OpTypeFloat 32 
					                                             %7 = OpTypeVector %6 4 
					                                             %8 = OpTypePointer Private %7 
					                              Private f32_4* %9 = OpVariable Private 
					                                            %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                            %11 = OpTypeSampledImage %10 
					                                            %12 = OpTypePointer UniformConstant %11 
					UniformConstant read_only Texture2DSampled* %13 = OpVariable UniformConstant 
					                                            %15 = OpTypeVector %6 2 
					                                            %16 = OpTypePointer Input %15 
					                               Input f32_2* %17 = OpVariable Input 
					                                            %20 = OpTypePointer Output %7 
					                              Output f32_4* %21 = OpVariable Output 
					                                        void %4 = OpFunction None %3 
					                                             %5 = OpLabel 
					                 read_only Texture2DSampled %14 = OpLoad %13 
					                                      f32_2 %18 = OpLoad %17 
					                                      f32_4 %19 = OpImageSampleImplicitLod %14 %18 
					                                                    OpStore %9 %19 
					                                      f32_4 %22 = OpLoad %9 
					                                                    OpStore %21 %22 
					                                                    OpReturn
					                                                    OpFunctionEnd"
				}
			}
			Program "fp" {
				SubProgram "gles hw_tier00 " {
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					"!!GLES"
				}
				SubProgram "gles3 hw_tier00 " {
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier01 " {
					"!!GLES3"
				}
				SubProgram "gles3 hw_tier02 " {
					"!!GLES3"
				}
				SubProgram "vulkan hw_tier00 " {
					"spirv"
				}
				SubProgram "vulkan hw_tier01 " {
					"spirv"
				}
				SubProgram "vulkan hw_tier02 " {
					"spirv"
				}
			}
		}
	}
}
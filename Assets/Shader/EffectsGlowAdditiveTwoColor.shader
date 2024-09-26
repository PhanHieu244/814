Shader "Effects/GlowAdditiveTwoColor" {
	Properties {
		_TintColor ("Tint Color", Vector) = (0.5,0.5,0.5,0.5)
		_CoreColor ("Core Color", Vector) = (0.5,0.5,0.5,0.5)
		_MainTex ("Particle Texture", 2D) = "white" {}
		_TintStrength ("Tint Color Strength", Float) = 1
		_CoreStrength ("Core Color Strength", Float) = 1
		_CutOutLightCore ("CutOut Light Core", Range(0, 1)) = 0.5
		_InvFade ("Soft Particles Factor", Range(0.01, 3)) = 1
	}
	SubShader {
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha One, SrcAlpha One
			ZClip Off
			ZWrite Off
			Cull Off
			GpuProgramID 15223
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
					uniform highp vec4 _MainTex_ST;
					varying lowp vec4 xlv_COLOR;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1.w = 1.0;
					  tmpvar_1.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
					  xlv_COLOR = _glesColor;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform lowp vec4 _TintColor;
					uniform lowp vec4 _CoreColor;
					uniform highp float _CutOutLightCore;
					uniform highp float _TintStrength;
					uniform highp float _CoreStrength;
					varying lowp vec4 xlv_COLOR;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 col_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  highp vec4 tmpvar_3;
					  tmpvar_3 = (((
					    (_TintColor * tmpvar_2.y)
					   * _TintStrength) + (
					    (tmpvar_2.x * _CoreColor)
					   * _CoreStrength)) - _CutOutLightCore);
					  col_1 = tmpvar_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = (xlv_COLOR * clamp (col_1, vec4(0.0, 0.0, 0.0, 0.0), vec4(255.0, 255.0, 255.0, 255.0)));
					  gl_FragData[0] = tmpvar_4;
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
					uniform highp vec4 _MainTex_ST;
					varying lowp vec4 xlv_COLOR;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1.w = 1.0;
					  tmpvar_1.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
					  xlv_COLOR = _glesColor;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform lowp vec4 _TintColor;
					uniform lowp vec4 _CoreColor;
					uniform highp float _CutOutLightCore;
					uniform highp float _TintStrength;
					uniform highp float _CoreStrength;
					varying lowp vec4 xlv_COLOR;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 col_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  highp vec4 tmpvar_3;
					  tmpvar_3 = (((
					    (_TintColor * tmpvar_2.y)
					   * _TintStrength) + (
					    (tmpvar_2.x * _CoreColor)
					   * _CoreStrength)) - _CutOutLightCore);
					  col_1 = tmpvar_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = (xlv_COLOR * clamp (col_1, vec4(0.0, 0.0, 0.0, 0.0), vec4(255.0, 255.0, 255.0, 255.0)));
					  gl_FragData[0] = tmpvar_4;
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
					uniform highp vec4 _MainTex_ST;
					varying lowp vec4 xlv_COLOR;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1.w = 1.0;
					  tmpvar_1.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
					  xlv_COLOR = _glesColor;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform lowp vec4 _TintColor;
					uniform lowp vec4 _CoreColor;
					uniform highp float _CutOutLightCore;
					uniform highp float _TintStrength;
					uniform highp float _CoreStrength;
					varying lowp vec4 xlv_COLOR;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 col_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  highp vec4 tmpvar_3;
					  tmpvar_3 = (((
					    (_TintColor * tmpvar_2.y)
					   * _TintStrength) + (
					    (tmpvar_2.x * _CoreColor)
					   * _CoreStrength)) - _CutOutLightCore);
					  col_1 = tmpvar_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = (xlv_COLOR * clamp (col_1, vec4(0.0, 0.0, 0.0, 0.0), vec4(255.0, 255.0, 255.0, 255.0)));
					  gl_FragData[0] = tmpvar_4;
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
					in highp vec4 in_POSITION0;
					in mediump vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
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
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	mediump vec4 _TintColor;
					uniform 	mediump vec4 _CoreColor;
					uniform 	float _CutOutLightCore;
					uniform 	float _TintStrength;
					uniform 	float _CoreStrength;
					uniform lowp sampler2D _MainTex;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					lowp vec2 u_xlat10_0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					void main()
					{
					    u_xlat10_0.xy = texture(_MainTex, vs_TEXCOORD0.xy).xy;
					    u_xlat16_1 = u_xlat10_0.xxxx * _CoreColor;
					    u_xlat16_0 = u_xlat10_0.yyyy * _TintColor;
					    u_xlat1 = u_xlat16_1 * vec4(vec4(_CoreStrength, _CoreStrength, _CoreStrength, _CoreStrength));
					    u_xlat0 = u_xlat16_0 * vec4(vec4(_TintStrength, _TintStrength, _TintStrength, _TintStrength)) + u_xlat1;
					    u_xlat0 = u_xlat0 + (-vec4(_CutOutLightCore));
					    u_xlat16_0 = max(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat16_0 = min(u_xlat16_0, vec4(255.0, 255.0, 255.0, 255.0));
					    SV_Target0 = u_xlat16_0 * vs_COLOR0;
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
					in highp vec4 in_POSITION0;
					in mediump vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
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
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	mediump vec4 _TintColor;
					uniform 	mediump vec4 _CoreColor;
					uniform 	float _CutOutLightCore;
					uniform 	float _TintStrength;
					uniform 	float _CoreStrength;
					uniform lowp sampler2D _MainTex;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					lowp vec2 u_xlat10_0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					void main()
					{
					    u_xlat10_0.xy = texture(_MainTex, vs_TEXCOORD0.xy).xy;
					    u_xlat16_1 = u_xlat10_0.xxxx * _CoreColor;
					    u_xlat16_0 = u_xlat10_0.yyyy * _TintColor;
					    u_xlat1 = u_xlat16_1 * vec4(vec4(_CoreStrength, _CoreStrength, _CoreStrength, _CoreStrength));
					    u_xlat0 = u_xlat16_0 * vec4(vec4(_TintStrength, _TintStrength, _TintStrength, _TintStrength)) + u_xlat1;
					    u_xlat0 = u_xlat0 + (-vec4(_CutOutLightCore));
					    u_xlat16_0 = max(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat16_0 = min(u_xlat16_0, vec4(255.0, 255.0, 255.0, 255.0));
					    SV_Target0 = u_xlat16_0 * vs_COLOR0;
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
					in highp vec4 in_POSITION0;
					in mediump vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
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
					    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	mediump vec4 _TintColor;
					uniform 	mediump vec4 _CoreColor;
					uniform 	float _CutOutLightCore;
					uniform 	float _TintStrength;
					uniform 	float _CoreStrength;
					uniform lowp sampler2D _MainTex;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					lowp vec2 u_xlat10_0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					void main()
					{
					    u_xlat10_0.xy = texture(_MainTex, vs_TEXCOORD0.xy).xy;
					    u_xlat16_1 = u_xlat10_0.xxxx * _CoreColor;
					    u_xlat16_0 = u_xlat10_0.yyyy * _TintColor;
					    u_xlat1 = u_xlat16_1 * vec4(vec4(_CoreStrength, _CoreStrength, _CoreStrength, _CoreStrength));
					    u_xlat0 = u_xlat16_0 * vec4(vec4(_TintStrength, _TintStrength, _TintStrength, _TintStrength)) + u_xlat1;
					    u_xlat0 = u_xlat0 + (-vec4(_CutOutLightCore));
					    u_xlat16_0 = max(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat16_0 = min(u_xlat16_0, vec4(255.0, 255.0, 255.0, 255.0));
					    SV_Target0 = u_xlat16_0 * vs_COLOR0;
					    return;
					}
					
					#endif"
				}
				SubProgram "vulkan hw_tier00 " {
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 1
					; Bound: 105
					; Schema: 0
					                                                     OpCapability Shader 
					                                              %1 = OpExtInstImport "GLSL.std.450" 
					                                                     OpMemoryModel Logical GLSL450 
					                                                     OpEntryPoint Vertex %4 "main" %11 %72 %82 %83 %87 %89 
					                                                     OpDecorate %11 Location 11 
					                                                     OpDecorate %16 ArrayStride 16 
					                                                     OpDecorate %17 ArrayStride 17 
					                                                     OpMemberDecorate %18 0 Offset 18 
					                                                     OpMemberDecorate %18 1 Offset 18 
					                                                     OpMemberDecorate %18 2 Offset 18 
					                                                     OpDecorate %18 Block 
					                                                     OpDecorate %20 DescriptorSet 20 
					                                                     OpDecorate %20 Binding 20 
					                                                     OpMemberDecorate %70 0 BuiltIn 70 
					                                                     OpMemberDecorate %70 1 BuiltIn 70 
					                                                     OpMemberDecorate %70 2 BuiltIn 70 
					                                                     OpDecorate %70 Block 
					                                                     OpDecorate %82 RelaxedPrecision 
					                                                     OpDecorate %82 Location 82 
					                                                     OpDecorate %83 RelaxedPrecision 
					                                                     OpDecorate %83 Location 83 
					                                                     OpDecorate %84 RelaxedPrecision 
					                                                     OpDecorate %87 Location 87 
					                                                     OpDecorate %89 Location 89 
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
					                                             %18 = OpTypeStruct %16 %17 %7 
					                                             %19 = OpTypePointer Uniform %18 
					Uniform struct {f32_4[4]; f32_4[4]; f32_4;}* %20 = OpVariable Uniform 
					                                             %21 = OpTypeInt 32 1 
					                                         i32 %22 = OpConstant 0 
					                                         i32 %23 = OpConstant 1 
					                                             %24 = OpTypePointer Uniform %7 
					                                         i32 %35 = OpConstant 2 
					                                         i32 %44 = OpConstant 3 
					                              Private f32_4* %48 = OpVariable Private 
					                                         u32 %68 = OpConstant 1 
					                                             %69 = OpTypeArray %6 %68 
					                                             %70 = OpTypeStruct %7 %6 %69 
					                                             %71 = OpTypePointer Output %70 
					        Output struct {f32_4; f32; f32[1];}* %72 = OpVariable Output 
					                                             %80 = OpTypePointer Output %7 
					                               Output f32_4* %82 = OpVariable Output 
					                                Input f32_4* %83 = OpVariable Input 
					                                             %85 = OpTypeVector %6 2 
					                                             %86 = OpTypePointer Output %85 
					                               Output f32_2* %87 = OpVariable Output 
					                                             %88 = OpTypePointer Input %85 
					                                Input f32_2* %89 = OpVariable Input 
					                                             %99 = OpTypePointer Output %6 
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
					                              Uniform f32_4* %73 = OpAccessChain %20 %23 %44 
					                                       f32_4 %74 = OpLoad %73 
					                                       f32_4 %75 = OpLoad %9 
					                                       f32_4 %76 = OpVectorShuffle %75 %75 3 3 3 3 
					                                       f32_4 %77 = OpFMul %74 %76 
					                                       f32_4 %78 = OpLoad %48 
					                                       f32_4 %79 = OpFAdd %77 %78 
					                               Output f32_4* %81 = OpAccessChain %72 %22 
					                                                     OpStore %81 %79 
					                                       f32_4 %84 = OpLoad %83 
					                                                     OpStore %82 %84 
					                                       f32_2 %90 = OpLoad %89 
					                              Uniform f32_4* %91 = OpAccessChain %20 %35 
					                                       f32_4 %92 = OpLoad %91 
					                                       f32_2 %93 = OpVectorShuffle %92 %92 0 1 
					                                       f32_2 %94 = OpFMul %90 %93 
					                              Uniform f32_4* %95 = OpAccessChain %20 %35 
					                                       f32_4 %96 = OpLoad %95 
					                                       f32_2 %97 = OpVectorShuffle %96 %96 2 3 
					                                       f32_2 %98 = OpFAdd %94 %97 
					                                                     OpStore %87 %98 
					                                Output f32* %100 = OpAccessChain %72 %22 %68 
					                                        f32 %101 = OpLoad %100 
					                                        f32 %102 = OpFNegate %101 
					                                Output f32* %103 = OpAccessChain %72 %22 %68 
					                                                     OpStore %103 %102 
					                                                     OpReturn
					                                                     OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 1
					; Bound: 103
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Fragment %4 "main" %16 %96 %99 
					                                                      OpExecutionMode %4 OriginUpperLeft 
					                                                      OpDecorate %9 RelaxedPrecision 
					                                                      OpDecorate %13 RelaxedPrecision 
					                                                      OpDecorate %13 DescriptorSet 13 
					                                                      OpDecorate %13 Binding 13 
					                                                      OpDecorate %14 RelaxedPrecision 
					                                                      OpDecorate %16 Location 16 
					                                                      OpDecorate %20 RelaxedPrecision 
					                                                      OpDecorate %22 RelaxedPrecision 
					                                                      OpDecorate %23 RelaxedPrecision 
					                                                      OpDecorate %24 RelaxedPrecision 
					                                                      OpMemberDecorate %25 0 RelaxedPrecision 
					                                                      OpMemberDecorate %25 0 Offset 25 
					                                                      OpMemberDecorate %25 1 RelaxedPrecision 
					                                                      OpMemberDecorate %25 1 Offset 25 
					                                                      OpMemberDecorate %25 2 Offset 25 
					                                                      OpMemberDecorate %25 3 Offset 25 
					                                                      OpMemberDecorate %25 4 Offset 25 
					                                                      OpDecorate %25 Block 
					                                                      OpDecorate %27 DescriptorSet 27 
					                                                      OpDecorate %27 Binding 27 
					                                                      OpDecorate %32 RelaxedPrecision 
					                                                      OpDecorate %33 RelaxedPrecision 
					                                                      OpDecorate %34 RelaxedPrecision 
					                                                      OpDecorate %35 RelaxedPrecision 
					                                                      OpDecorate %36 RelaxedPrecision 
					                                                      OpDecorate %39 RelaxedPrecision 
					                                                      OpDecorate %40 RelaxedPrecision 
					                                                      OpDecorate %42 RelaxedPrecision 
					                                                      OpDecorate %53 RelaxedPrecision 
					                                                      OpDecorate %54 RelaxedPrecision 
					                                                      OpDecorate %55 RelaxedPrecision 
					                                                      OpDecorate %56 RelaxedPrecision 
					                                                      OpDecorate %57 RelaxedPrecision 
					                                                      OpDecorate %58 RelaxedPrecision 
					                                                      OpDecorate %59 RelaxedPrecision 
					                                                      OpDecorate %61 RelaxedPrecision 
					                                                      OpDecorate %71 RelaxedPrecision 
					                                                      OpDecorate %72 RelaxedPrecision 
					                                                      OpDecorate %73 RelaxedPrecision 
					                                                      OpDecorate %74 RelaxedPrecision 
					                                                      OpDecorate %75 RelaxedPrecision 
					                                                      OpDecorate %76 RelaxedPrecision 
					                                                      OpDecorate %77 RelaxedPrecision 
					                                                      OpDecorate %91 RelaxedPrecision 
					                                                      OpDecorate %94 RelaxedPrecision 
					                                                      OpDecorate %96 RelaxedPrecision 
					                                                      OpDecorate %96 Location 96 
					                                                      OpDecorate %97 RelaxedPrecision 
					                                                      OpDecorate %99 RelaxedPrecision 
					                                                      OpDecorate %99 Location 99 
					                                                      OpDecorate %100 RelaxedPrecision 
					                                                      OpDecorate %101 RelaxedPrecision 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 2 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_2* %9 = OpVariable Private 
					                                              %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                              %11 = OpTypeSampledImage %10 
					                                              %12 = OpTypePointer UniformConstant %11 
					  UniformConstant read_only Texture2DSampled* %13 = OpVariable UniformConstant 
					                                              %15 = OpTypePointer Input %7 
					                                 Input f32_2* %16 = OpVariable Input 
					                                              %18 = OpTypeVector %6 4 
					                                              %21 = OpTypePointer Private %18 
					                               Private f32_4* %22 = OpVariable Private 
					                                              %25 = OpTypeStruct %18 %18 %6 %6 %6 
					                                              %26 = OpTypePointer Uniform %25 
					Uniform struct {f32_4; f32_4; f32; f32; f32;}* %27 = OpVariable Uniform 
					                                              %28 = OpTypeInt 32 1 
					                                          i32 %29 = OpConstant 1 
					                                              %30 = OpTypePointer Uniform %18 
					                               Private f32_4* %34 = OpVariable Private 
					                                          i32 %37 = OpConstant 0 
					                               Private f32_4* %41 = OpVariable Private 
					                                          i32 %43 = OpConstant 4 
					                                              %44 = OpTypePointer Uniform %6 
					                               Private f32_4* %60 = OpVariable Private 
					                                          i32 %62 = OpConstant 3 
					                                          i32 %81 = OpConstant 2 
					                                          f32 %88 = OpConstant 3.674022E-40 
					                                        f32_4 %89 = OpConstantComposite %88 %88 %88 %88 
					                                          f32 %92 = OpConstant 3.674022E-40 
					                                        f32_4 %93 = OpConstantComposite %92 %92 %92 %92 
					                                              %95 = OpTypePointer Output %18 
					                                Output f32_4* %96 = OpVariable Output 
					                                              %98 = OpTypePointer Input %18 
					                                 Input f32_4* %99 = OpVariable Input 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                   read_only Texture2DSampled %14 = OpLoad %13 
					                                        f32_2 %17 = OpLoad %16 
					                                        f32_4 %19 = OpImageSampleImplicitLod %14 %17 
					                                        f32_2 %20 = OpVectorShuffle %19 %19 0 1 
					                                                      OpStore %9 %20 
					                                        f32_2 %23 = OpLoad %9 
					                                        f32_4 %24 = OpVectorShuffle %23 %23 0 0 0 0 
					                               Uniform f32_4* %31 = OpAccessChain %27 %29 
					                                        f32_4 %32 = OpLoad %31 
					                                        f32_4 %33 = OpFMul %24 %32 
					                                                      OpStore %22 %33 
					                                        f32_2 %35 = OpLoad %9 
					                                        f32_4 %36 = OpVectorShuffle %35 %35 1 1 1 1 
					                               Uniform f32_4* %38 = OpAccessChain %27 %37 
					                                        f32_4 %39 = OpLoad %38 
					                                        f32_4 %40 = OpFMul %36 %39 
					                                                      OpStore %34 %40 
					                                        f32_4 %42 = OpLoad %22 
					                                 Uniform f32* %45 = OpAccessChain %27 %43 
					                                          f32 %46 = OpLoad %45 
					                                 Uniform f32* %47 = OpAccessChain %27 %43 
					                                          f32 %48 = OpLoad %47 
					                                 Uniform f32* %49 = OpAccessChain %27 %43 
					                                          f32 %50 = OpLoad %49 
					                                 Uniform f32* %51 = OpAccessChain %27 %43 
					                                          f32 %52 = OpLoad %51 
					                                        f32_4 %53 = OpCompositeConstruct %46 %48 %50 %52 
					                                          f32 %54 = OpCompositeExtract %53 0 
					                                          f32 %55 = OpCompositeExtract %53 1 
					                                          f32 %56 = OpCompositeExtract %53 2 
					                                          f32 %57 = OpCompositeExtract %53 3 
					                                        f32_4 %58 = OpCompositeConstruct %54 %55 %56 %57 
					                                        f32_4 %59 = OpFMul %42 %58 
					                                                      OpStore %41 %59 
					                                        f32_4 %61 = OpLoad %34 
					                                 Uniform f32* %63 = OpAccessChain %27 %62 
					                                          f32 %64 = OpLoad %63 
					                                 Uniform f32* %65 = OpAccessChain %27 %62 
					                                          f32 %66 = OpLoad %65 
					                                 Uniform f32* %67 = OpAccessChain %27 %62 
					                                          f32 %68 = OpLoad %67 
					                                 Uniform f32* %69 = OpAccessChain %27 %62 
					                                          f32 %70 = OpLoad %69 
					                                        f32_4 %71 = OpCompositeConstruct %64 %66 %68 %70 
					                                          f32 %72 = OpCompositeExtract %71 0 
					                                          f32 %73 = OpCompositeExtract %71 1 
					                                          f32 %74 = OpCompositeExtract %71 2 
					                                          f32 %75 = OpCompositeExtract %71 3 
					                                        f32_4 %76 = OpCompositeConstruct %72 %73 %74 %75 
					                                        f32_4 %77 = OpFMul %61 %76 
					                                        f32_4 %78 = OpLoad %41 
					                                        f32_4 %79 = OpFAdd %77 %78 
					                                                      OpStore %60 %79 
					                                        f32_4 %80 = OpLoad %60 
					                                 Uniform f32* %82 = OpAccessChain %27 %81 
					                                          f32 %83 = OpLoad %82 
					                                        f32_4 %84 = OpCompositeConstruct %83 %83 %83 %83 
					                                        f32_4 %85 = OpFNegate %84 
					                                        f32_4 %86 = OpFAdd %80 %85 
					                                                      OpStore %60 %86 
					                                        f32_4 %87 = OpLoad %60 
					                                        f32_4 %90 = OpExtInst %1 40 %87 %89 
					                                                      OpStore %34 %90 
					                                        f32_4 %91 = OpLoad %34 
					                                        f32_4 %94 = OpExtInst %1 37 %91 %93 
					                                                      OpStore %34 %94 
					                                        f32_4 %97 = OpLoad %34 
					                                       f32_4 %100 = OpLoad %99 
					                                       f32_4 %101 = OpFMul %97 %100 
					                                                      OpStore %96 %101 
					                                                      OpReturn
					                                                      OpFunctionEnd"
				}
				SubProgram "vulkan hw_tier01 " {
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 1
					; Bound: 105
					; Schema: 0
					                                                     OpCapability Shader 
					                                              %1 = OpExtInstImport "GLSL.std.450" 
					                                                     OpMemoryModel Logical GLSL450 
					                                                     OpEntryPoint Vertex %4 "main" %11 %72 %82 %83 %87 %89 
					                                                     OpDecorate %11 Location 11 
					                                                     OpDecorate %16 ArrayStride 16 
					                                                     OpDecorate %17 ArrayStride 17 
					                                                     OpMemberDecorate %18 0 Offset 18 
					                                                     OpMemberDecorate %18 1 Offset 18 
					                                                     OpMemberDecorate %18 2 Offset 18 
					                                                     OpDecorate %18 Block 
					                                                     OpDecorate %20 DescriptorSet 20 
					                                                     OpDecorate %20 Binding 20 
					                                                     OpMemberDecorate %70 0 BuiltIn 70 
					                                                     OpMemberDecorate %70 1 BuiltIn 70 
					                                                     OpMemberDecorate %70 2 BuiltIn 70 
					                                                     OpDecorate %70 Block 
					                                                     OpDecorate %82 RelaxedPrecision 
					                                                     OpDecorate %82 Location 82 
					                                                     OpDecorate %83 RelaxedPrecision 
					                                                     OpDecorate %83 Location 83 
					                                                     OpDecorate %84 RelaxedPrecision 
					                                                     OpDecorate %87 Location 87 
					                                                     OpDecorate %89 Location 89 
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
					                                             %18 = OpTypeStruct %16 %17 %7 
					                                             %19 = OpTypePointer Uniform %18 
					Uniform struct {f32_4[4]; f32_4[4]; f32_4;}* %20 = OpVariable Uniform 
					                                             %21 = OpTypeInt 32 1 
					                                         i32 %22 = OpConstant 0 
					                                         i32 %23 = OpConstant 1 
					                                             %24 = OpTypePointer Uniform %7 
					                                         i32 %35 = OpConstant 2 
					                                         i32 %44 = OpConstant 3 
					                              Private f32_4* %48 = OpVariable Private 
					                                         u32 %68 = OpConstant 1 
					                                             %69 = OpTypeArray %6 %68 
					                                             %70 = OpTypeStruct %7 %6 %69 
					                                             %71 = OpTypePointer Output %70 
					        Output struct {f32_4; f32; f32[1];}* %72 = OpVariable Output 
					                                             %80 = OpTypePointer Output %7 
					                               Output f32_4* %82 = OpVariable Output 
					                                Input f32_4* %83 = OpVariable Input 
					                                             %85 = OpTypeVector %6 2 
					                                             %86 = OpTypePointer Output %85 
					                               Output f32_2* %87 = OpVariable Output 
					                                             %88 = OpTypePointer Input %85 
					                                Input f32_2* %89 = OpVariable Input 
					                                             %99 = OpTypePointer Output %6 
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
					                              Uniform f32_4* %73 = OpAccessChain %20 %23 %44 
					                                       f32_4 %74 = OpLoad %73 
					                                       f32_4 %75 = OpLoad %9 
					                                       f32_4 %76 = OpVectorShuffle %75 %75 3 3 3 3 
					                                       f32_4 %77 = OpFMul %74 %76 
					                                       f32_4 %78 = OpLoad %48 
					                                       f32_4 %79 = OpFAdd %77 %78 
					                               Output f32_4* %81 = OpAccessChain %72 %22 
					                                                     OpStore %81 %79 
					                                       f32_4 %84 = OpLoad %83 
					                                                     OpStore %82 %84 
					                                       f32_2 %90 = OpLoad %89 
					                              Uniform f32_4* %91 = OpAccessChain %20 %35 
					                                       f32_4 %92 = OpLoad %91 
					                                       f32_2 %93 = OpVectorShuffle %92 %92 0 1 
					                                       f32_2 %94 = OpFMul %90 %93 
					                              Uniform f32_4* %95 = OpAccessChain %20 %35 
					                                       f32_4 %96 = OpLoad %95 
					                                       f32_2 %97 = OpVectorShuffle %96 %96 2 3 
					                                       f32_2 %98 = OpFAdd %94 %97 
					                                                     OpStore %87 %98 
					                                Output f32* %100 = OpAccessChain %72 %22 %68 
					                                        f32 %101 = OpLoad %100 
					                                        f32 %102 = OpFNegate %101 
					                                Output f32* %103 = OpAccessChain %72 %22 %68 
					                                                     OpStore %103 %102 
					                                                     OpReturn
					                                                     OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 1
					; Bound: 103
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Fragment %4 "main" %16 %96 %99 
					                                                      OpExecutionMode %4 OriginUpperLeft 
					                                                      OpDecorate %9 RelaxedPrecision 
					                                                      OpDecorate %13 RelaxedPrecision 
					                                                      OpDecorate %13 DescriptorSet 13 
					                                                      OpDecorate %13 Binding 13 
					                                                      OpDecorate %14 RelaxedPrecision 
					                                                      OpDecorate %16 Location 16 
					                                                      OpDecorate %20 RelaxedPrecision 
					                                                      OpDecorate %22 RelaxedPrecision 
					                                                      OpDecorate %23 RelaxedPrecision 
					                                                      OpDecorate %24 RelaxedPrecision 
					                                                      OpMemberDecorate %25 0 RelaxedPrecision 
					                                                      OpMemberDecorate %25 0 Offset 25 
					                                                      OpMemberDecorate %25 1 RelaxedPrecision 
					                                                      OpMemberDecorate %25 1 Offset 25 
					                                                      OpMemberDecorate %25 2 Offset 25 
					                                                      OpMemberDecorate %25 3 Offset 25 
					                                                      OpMemberDecorate %25 4 Offset 25 
					                                                      OpDecorate %25 Block 
					                                                      OpDecorate %27 DescriptorSet 27 
					                                                      OpDecorate %27 Binding 27 
					                                                      OpDecorate %32 RelaxedPrecision 
					                                                      OpDecorate %33 RelaxedPrecision 
					                                                      OpDecorate %34 RelaxedPrecision 
					                                                      OpDecorate %35 RelaxedPrecision 
					                                                      OpDecorate %36 RelaxedPrecision 
					                                                      OpDecorate %39 RelaxedPrecision 
					                                                      OpDecorate %40 RelaxedPrecision 
					                                                      OpDecorate %42 RelaxedPrecision 
					                                                      OpDecorate %53 RelaxedPrecision 
					                                                      OpDecorate %54 RelaxedPrecision 
					                                                      OpDecorate %55 RelaxedPrecision 
					                                                      OpDecorate %56 RelaxedPrecision 
					                                                      OpDecorate %57 RelaxedPrecision 
					                                                      OpDecorate %58 RelaxedPrecision 
					                                                      OpDecorate %59 RelaxedPrecision 
					                                                      OpDecorate %61 RelaxedPrecision 
					                                                      OpDecorate %71 RelaxedPrecision 
					                                                      OpDecorate %72 RelaxedPrecision 
					                                                      OpDecorate %73 RelaxedPrecision 
					                                                      OpDecorate %74 RelaxedPrecision 
					                                                      OpDecorate %75 RelaxedPrecision 
					                                                      OpDecorate %76 RelaxedPrecision 
					                                                      OpDecorate %77 RelaxedPrecision 
					                                                      OpDecorate %91 RelaxedPrecision 
					                                                      OpDecorate %94 RelaxedPrecision 
					                                                      OpDecorate %96 RelaxedPrecision 
					                                                      OpDecorate %96 Location 96 
					                                                      OpDecorate %97 RelaxedPrecision 
					                                                      OpDecorate %99 RelaxedPrecision 
					                                                      OpDecorate %99 Location 99 
					                                                      OpDecorate %100 RelaxedPrecision 
					                                                      OpDecorate %101 RelaxedPrecision 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 2 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_2* %9 = OpVariable Private 
					                                              %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                              %11 = OpTypeSampledImage %10 
					                                              %12 = OpTypePointer UniformConstant %11 
					  UniformConstant read_only Texture2DSampled* %13 = OpVariable UniformConstant 
					                                              %15 = OpTypePointer Input %7 
					                                 Input f32_2* %16 = OpVariable Input 
					                                              %18 = OpTypeVector %6 4 
					                                              %21 = OpTypePointer Private %18 
					                               Private f32_4* %22 = OpVariable Private 
					                                              %25 = OpTypeStruct %18 %18 %6 %6 %6 
					                                              %26 = OpTypePointer Uniform %25 
					Uniform struct {f32_4; f32_4; f32; f32; f32;}* %27 = OpVariable Uniform 
					                                              %28 = OpTypeInt 32 1 
					                                          i32 %29 = OpConstant 1 
					                                              %30 = OpTypePointer Uniform %18 
					                               Private f32_4* %34 = OpVariable Private 
					                                          i32 %37 = OpConstant 0 
					                               Private f32_4* %41 = OpVariable Private 
					                                          i32 %43 = OpConstant 4 
					                                              %44 = OpTypePointer Uniform %6 
					                               Private f32_4* %60 = OpVariable Private 
					                                          i32 %62 = OpConstant 3 
					                                          i32 %81 = OpConstant 2 
					                                          f32 %88 = OpConstant 3.674022E-40 
					                                        f32_4 %89 = OpConstantComposite %88 %88 %88 %88 
					                                          f32 %92 = OpConstant 3.674022E-40 
					                                        f32_4 %93 = OpConstantComposite %92 %92 %92 %92 
					                                              %95 = OpTypePointer Output %18 
					                                Output f32_4* %96 = OpVariable Output 
					                                              %98 = OpTypePointer Input %18 
					                                 Input f32_4* %99 = OpVariable Input 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                   read_only Texture2DSampled %14 = OpLoad %13 
					                                        f32_2 %17 = OpLoad %16 
					                                        f32_4 %19 = OpImageSampleImplicitLod %14 %17 
					                                        f32_2 %20 = OpVectorShuffle %19 %19 0 1 
					                                                      OpStore %9 %20 
					                                        f32_2 %23 = OpLoad %9 
					                                        f32_4 %24 = OpVectorShuffle %23 %23 0 0 0 0 
					                               Uniform f32_4* %31 = OpAccessChain %27 %29 
					                                        f32_4 %32 = OpLoad %31 
					                                        f32_4 %33 = OpFMul %24 %32 
					                                                      OpStore %22 %33 
					                                        f32_2 %35 = OpLoad %9 
					                                        f32_4 %36 = OpVectorShuffle %35 %35 1 1 1 1 
					                               Uniform f32_4* %38 = OpAccessChain %27 %37 
					                                        f32_4 %39 = OpLoad %38 
					                                        f32_4 %40 = OpFMul %36 %39 
					                                                      OpStore %34 %40 
					                                        f32_4 %42 = OpLoad %22 
					                                 Uniform f32* %45 = OpAccessChain %27 %43 
					                                          f32 %46 = OpLoad %45 
					                                 Uniform f32* %47 = OpAccessChain %27 %43 
					                                          f32 %48 = OpLoad %47 
					                                 Uniform f32* %49 = OpAccessChain %27 %43 
					                                          f32 %50 = OpLoad %49 
					                                 Uniform f32* %51 = OpAccessChain %27 %43 
					                                          f32 %52 = OpLoad %51 
					                                        f32_4 %53 = OpCompositeConstruct %46 %48 %50 %52 
					                                          f32 %54 = OpCompositeExtract %53 0 
					                                          f32 %55 = OpCompositeExtract %53 1 
					                                          f32 %56 = OpCompositeExtract %53 2 
					                                          f32 %57 = OpCompositeExtract %53 3 
					                                        f32_4 %58 = OpCompositeConstruct %54 %55 %56 %57 
					                                        f32_4 %59 = OpFMul %42 %58 
					                                                      OpStore %41 %59 
					                                        f32_4 %61 = OpLoad %34 
					                                 Uniform f32* %63 = OpAccessChain %27 %62 
					                                          f32 %64 = OpLoad %63 
					                                 Uniform f32* %65 = OpAccessChain %27 %62 
					                                          f32 %66 = OpLoad %65 
					                                 Uniform f32* %67 = OpAccessChain %27 %62 
					                                          f32 %68 = OpLoad %67 
					                                 Uniform f32* %69 = OpAccessChain %27 %62 
					                                          f32 %70 = OpLoad %69 
					                                        f32_4 %71 = OpCompositeConstruct %64 %66 %68 %70 
					                                          f32 %72 = OpCompositeExtract %71 0 
					                                          f32 %73 = OpCompositeExtract %71 1 
					                                          f32 %74 = OpCompositeExtract %71 2 
					                                          f32 %75 = OpCompositeExtract %71 3 
					                                        f32_4 %76 = OpCompositeConstruct %72 %73 %74 %75 
					                                        f32_4 %77 = OpFMul %61 %76 
					                                        f32_4 %78 = OpLoad %41 
					                                        f32_4 %79 = OpFAdd %77 %78 
					                                                      OpStore %60 %79 
					                                        f32_4 %80 = OpLoad %60 
					                                 Uniform f32* %82 = OpAccessChain %27 %81 
					                                          f32 %83 = OpLoad %82 
					                                        f32_4 %84 = OpCompositeConstruct %83 %83 %83 %83 
					                                        f32_4 %85 = OpFNegate %84 
					                                        f32_4 %86 = OpFAdd %80 %85 
					                                                      OpStore %60 %86 
					                                        f32_4 %87 = OpLoad %60 
					                                        f32_4 %90 = OpExtInst %1 40 %87 %89 
					                                                      OpStore %34 %90 
					                                        f32_4 %91 = OpLoad %34 
					                                        f32_4 %94 = OpExtInst %1 37 %91 %93 
					                                                      OpStore %34 %94 
					                                        f32_4 %97 = OpLoad %34 
					                                       f32_4 %100 = OpLoad %99 
					                                       f32_4 %101 = OpFMul %97 %100 
					                                                      OpStore %96 %101 
					                                                      OpReturn
					                                                      OpFunctionEnd"
				}
				SubProgram "vulkan hw_tier02 " {
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 1
					; Bound: 105
					; Schema: 0
					                                                     OpCapability Shader 
					                                              %1 = OpExtInstImport "GLSL.std.450" 
					                                                     OpMemoryModel Logical GLSL450 
					                                                     OpEntryPoint Vertex %4 "main" %11 %72 %82 %83 %87 %89 
					                                                     OpDecorate %11 Location 11 
					                                                     OpDecorate %16 ArrayStride 16 
					                                                     OpDecorate %17 ArrayStride 17 
					                                                     OpMemberDecorate %18 0 Offset 18 
					                                                     OpMemberDecorate %18 1 Offset 18 
					                                                     OpMemberDecorate %18 2 Offset 18 
					                                                     OpDecorate %18 Block 
					                                                     OpDecorate %20 DescriptorSet 20 
					                                                     OpDecorate %20 Binding 20 
					                                                     OpMemberDecorate %70 0 BuiltIn 70 
					                                                     OpMemberDecorate %70 1 BuiltIn 70 
					                                                     OpMemberDecorate %70 2 BuiltIn 70 
					                                                     OpDecorate %70 Block 
					                                                     OpDecorate %82 RelaxedPrecision 
					                                                     OpDecorate %82 Location 82 
					                                                     OpDecorate %83 RelaxedPrecision 
					                                                     OpDecorate %83 Location 83 
					                                                     OpDecorate %84 RelaxedPrecision 
					                                                     OpDecorate %87 Location 87 
					                                                     OpDecorate %89 Location 89 
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
					                                             %18 = OpTypeStruct %16 %17 %7 
					                                             %19 = OpTypePointer Uniform %18 
					Uniform struct {f32_4[4]; f32_4[4]; f32_4;}* %20 = OpVariable Uniform 
					                                             %21 = OpTypeInt 32 1 
					                                         i32 %22 = OpConstant 0 
					                                         i32 %23 = OpConstant 1 
					                                             %24 = OpTypePointer Uniform %7 
					                                         i32 %35 = OpConstant 2 
					                                         i32 %44 = OpConstant 3 
					                              Private f32_4* %48 = OpVariable Private 
					                                         u32 %68 = OpConstant 1 
					                                             %69 = OpTypeArray %6 %68 
					                                             %70 = OpTypeStruct %7 %6 %69 
					                                             %71 = OpTypePointer Output %70 
					        Output struct {f32_4; f32; f32[1];}* %72 = OpVariable Output 
					                                             %80 = OpTypePointer Output %7 
					                               Output f32_4* %82 = OpVariable Output 
					                                Input f32_4* %83 = OpVariable Input 
					                                             %85 = OpTypeVector %6 2 
					                                             %86 = OpTypePointer Output %85 
					                               Output f32_2* %87 = OpVariable Output 
					                                             %88 = OpTypePointer Input %85 
					                                Input f32_2* %89 = OpVariable Input 
					                                             %99 = OpTypePointer Output %6 
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
					                              Uniform f32_4* %73 = OpAccessChain %20 %23 %44 
					                                       f32_4 %74 = OpLoad %73 
					                                       f32_4 %75 = OpLoad %9 
					                                       f32_4 %76 = OpVectorShuffle %75 %75 3 3 3 3 
					                                       f32_4 %77 = OpFMul %74 %76 
					                                       f32_4 %78 = OpLoad %48 
					                                       f32_4 %79 = OpFAdd %77 %78 
					                               Output f32_4* %81 = OpAccessChain %72 %22 
					                                                     OpStore %81 %79 
					                                       f32_4 %84 = OpLoad %83 
					                                                     OpStore %82 %84 
					                                       f32_2 %90 = OpLoad %89 
					                              Uniform f32_4* %91 = OpAccessChain %20 %35 
					                                       f32_4 %92 = OpLoad %91 
					                                       f32_2 %93 = OpVectorShuffle %92 %92 0 1 
					                                       f32_2 %94 = OpFMul %90 %93 
					                              Uniform f32_4* %95 = OpAccessChain %20 %35 
					                                       f32_4 %96 = OpLoad %95 
					                                       f32_2 %97 = OpVectorShuffle %96 %96 2 3 
					                                       f32_2 %98 = OpFAdd %94 %97 
					                                                     OpStore %87 %98 
					                                Output f32* %100 = OpAccessChain %72 %22 %68 
					                                        f32 %101 = OpLoad %100 
					                                        f32 %102 = OpFNegate %101 
					                                Output f32* %103 = OpAccessChain %72 %22 %68 
					                                                     OpStore %103 %102 
					                                                     OpReturn
					                                                     OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 1
					; Bound: 103
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Fragment %4 "main" %16 %96 %99 
					                                                      OpExecutionMode %4 OriginUpperLeft 
					                                                      OpDecorate %9 RelaxedPrecision 
					                                                      OpDecorate %13 RelaxedPrecision 
					                                                      OpDecorate %13 DescriptorSet 13 
					                                                      OpDecorate %13 Binding 13 
					                                                      OpDecorate %14 RelaxedPrecision 
					                                                      OpDecorate %16 Location 16 
					                                                      OpDecorate %20 RelaxedPrecision 
					                                                      OpDecorate %22 RelaxedPrecision 
					                                                      OpDecorate %23 RelaxedPrecision 
					                                                      OpDecorate %24 RelaxedPrecision 
					                                                      OpMemberDecorate %25 0 RelaxedPrecision 
					                                                      OpMemberDecorate %25 0 Offset 25 
					                                                      OpMemberDecorate %25 1 RelaxedPrecision 
					                                                      OpMemberDecorate %25 1 Offset 25 
					                                                      OpMemberDecorate %25 2 Offset 25 
					                                                      OpMemberDecorate %25 3 Offset 25 
					                                                      OpMemberDecorate %25 4 Offset 25 
					                                                      OpDecorate %25 Block 
					                                                      OpDecorate %27 DescriptorSet 27 
					                                                      OpDecorate %27 Binding 27 
					                                                      OpDecorate %32 RelaxedPrecision 
					                                                      OpDecorate %33 RelaxedPrecision 
					                                                      OpDecorate %34 RelaxedPrecision 
					                                                      OpDecorate %35 RelaxedPrecision 
					                                                      OpDecorate %36 RelaxedPrecision 
					                                                      OpDecorate %39 RelaxedPrecision 
					                                                      OpDecorate %40 RelaxedPrecision 
					                                                      OpDecorate %42 RelaxedPrecision 
					                                                      OpDecorate %53 RelaxedPrecision 
					                                                      OpDecorate %54 RelaxedPrecision 
					                                                      OpDecorate %55 RelaxedPrecision 
					                                                      OpDecorate %56 RelaxedPrecision 
					                                                      OpDecorate %57 RelaxedPrecision 
					                                                      OpDecorate %58 RelaxedPrecision 
					                                                      OpDecorate %59 RelaxedPrecision 
					                                                      OpDecorate %61 RelaxedPrecision 
					                                                      OpDecorate %71 RelaxedPrecision 
					                                                      OpDecorate %72 RelaxedPrecision 
					                                                      OpDecorate %73 RelaxedPrecision 
					                                                      OpDecorate %74 RelaxedPrecision 
					                                                      OpDecorate %75 RelaxedPrecision 
					                                                      OpDecorate %76 RelaxedPrecision 
					                                                      OpDecorate %77 RelaxedPrecision 
					                                                      OpDecorate %91 RelaxedPrecision 
					                                                      OpDecorate %94 RelaxedPrecision 
					                                                      OpDecorate %96 RelaxedPrecision 
					                                                      OpDecorate %96 Location 96 
					                                                      OpDecorate %97 RelaxedPrecision 
					                                                      OpDecorate %99 RelaxedPrecision 
					                                                      OpDecorate %99 Location 99 
					                                                      OpDecorate %100 RelaxedPrecision 
					                                                      OpDecorate %101 RelaxedPrecision 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 2 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_2* %9 = OpVariable Private 
					                                              %10 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                              %11 = OpTypeSampledImage %10 
					                                              %12 = OpTypePointer UniformConstant %11 
					  UniformConstant read_only Texture2DSampled* %13 = OpVariable UniformConstant 
					                                              %15 = OpTypePointer Input %7 
					                                 Input f32_2* %16 = OpVariable Input 
					                                              %18 = OpTypeVector %6 4 
					                                              %21 = OpTypePointer Private %18 
					                               Private f32_4* %22 = OpVariable Private 
					                                              %25 = OpTypeStruct %18 %18 %6 %6 %6 
					                                              %26 = OpTypePointer Uniform %25 
					Uniform struct {f32_4; f32_4; f32; f32; f32;}* %27 = OpVariable Uniform 
					                                              %28 = OpTypeInt 32 1 
					                                          i32 %29 = OpConstant 1 
					                                              %30 = OpTypePointer Uniform %18 
					                               Private f32_4* %34 = OpVariable Private 
					                                          i32 %37 = OpConstant 0 
					                               Private f32_4* %41 = OpVariable Private 
					                                          i32 %43 = OpConstant 4 
					                                              %44 = OpTypePointer Uniform %6 
					                               Private f32_4* %60 = OpVariable Private 
					                                          i32 %62 = OpConstant 3 
					                                          i32 %81 = OpConstant 2 
					                                          f32 %88 = OpConstant 3.674022E-40 
					                                        f32_4 %89 = OpConstantComposite %88 %88 %88 %88 
					                                          f32 %92 = OpConstant 3.674022E-40 
					                                        f32_4 %93 = OpConstantComposite %92 %92 %92 %92 
					                                              %95 = OpTypePointer Output %18 
					                                Output f32_4* %96 = OpVariable Output 
					                                              %98 = OpTypePointer Input %18 
					                                 Input f32_4* %99 = OpVariable Input 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                   read_only Texture2DSampled %14 = OpLoad %13 
					                                        f32_2 %17 = OpLoad %16 
					                                        f32_4 %19 = OpImageSampleImplicitLod %14 %17 
					                                        f32_2 %20 = OpVectorShuffle %19 %19 0 1 
					                                                      OpStore %9 %20 
					                                        f32_2 %23 = OpLoad %9 
					                                        f32_4 %24 = OpVectorShuffle %23 %23 0 0 0 0 
					                               Uniform f32_4* %31 = OpAccessChain %27 %29 
					                                        f32_4 %32 = OpLoad %31 
					                                        f32_4 %33 = OpFMul %24 %32 
					                                                      OpStore %22 %33 
					                                        f32_2 %35 = OpLoad %9 
					                                        f32_4 %36 = OpVectorShuffle %35 %35 1 1 1 1 
					                               Uniform f32_4* %38 = OpAccessChain %27 %37 
					                                        f32_4 %39 = OpLoad %38 
					                                        f32_4 %40 = OpFMul %36 %39 
					                                                      OpStore %34 %40 
					                                        f32_4 %42 = OpLoad %22 
					                                 Uniform f32* %45 = OpAccessChain %27 %43 
					                                          f32 %46 = OpLoad %45 
					                                 Uniform f32* %47 = OpAccessChain %27 %43 
					                                          f32 %48 = OpLoad %47 
					                                 Uniform f32* %49 = OpAccessChain %27 %43 
					                                          f32 %50 = OpLoad %49 
					                                 Uniform f32* %51 = OpAccessChain %27 %43 
					                                          f32 %52 = OpLoad %51 
					                                        f32_4 %53 = OpCompositeConstruct %46 %48 %50 %52 
					                                          f32 %54 = OpCompositeExtract %53 0 
					                                          f32 %55 = OpCompositeExtract %53 1 
					                                          f32 %56 = OpCompositeExtract %53 2 
					                                          f32 %57 = OpCompositeExtract %53 3 
					                                        f32_4 %58 = OpCompositeConstruct %54 %55 %56 %57 
					                                        f32_4 %59 = OpFMul %42 %58 
					                                                      OpStore %41 %59 
					                                        f32_4 %61 = OpLoad %34 
					                                 Uniform f32* %63 = OpAccessChain %27 %62 
					                                          f32 %64 = OpLoad %63 
					                                 Uniform f32* %65 = OpAccessChain %27 %62 
					                                          f32 %66 = OpLoad %65 
					                                 Uniform f32* %67 = OpAccessChain %27 %62 
					                                          f32 %68 = OpLoad %67 
					                                 Uniform f32* %69 = OpAccessChain %27 %62 
					                                          f32 %70 = OpLoad %69 
					                                        f32_4 %71 = OpCompositeConstruct %64 %66 %68 %70 
					                                          f32 %72 = OpCompositeExtract %71 0 
					                                          f32 %73 = OpCompositeExtract %71 1 
					                                          f32 %74 = OpCompositeExtract %71 2 
					                                          f32 %75 = OpCompositeExtract %71 3 
					                                        f32_4 %76 = OpCompositeConstruct %72 %73 %74 %75 
					                                        f32_4 %77 = OpFMul %61 %76 
					                                        f32_4 %78 = OpLoad %41 
					                                        f32_4 %79 = OpFAdd %77 %78 
					                                                      OpStore %60 %79 
					                                        f32_4 %80 = OpLoad %60 
					                                 Uniform f32* %82 = OpAccessChain %27 %81 
					                                          f32 %83 = OpLoad %82 
					                                        f32_4 %84 = OpCompositeConstruct %83 %83 %83 %83 
					                                        f32_4 %85 = OpFNegate %84 
					                                        f32_4 %86 = OpFAdd %80 %85 
					                                                      OpStore %60 %86 
					                                        f32_4 %87 = OpLoad %60 
					                                        f32_4 %90 = OpExtInst %1 40 %87 %89 
					                                                      OpStore %34 %90 
					                                        f32_4 %91 = OpLoad %34 
					                                        f32_4 %94 = OpExtInst %1 37 %91 %93 
					                                                      OpStore %34 %94 
					                                        f32_4 %97 = OpLoad %34 
					                                       f32_4 %100 = OpLoad %99 
					                                       f32_4 %101 = OpFMul %97 %100 
					                                                      OpStore %96 %101 
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
					uniform highp vec4 _MainTex_ST;
					varying lowp vec4 xlv_COLOR;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  highp vec4 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = tmpvar_1.xyz;
					  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  highp vec4 o_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6 = (tmpvar_3 * 0.5);
					  highp vec2 tmpvar_7;
					  tmpvar_7.x = tmpvar_6.x;
					  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
					  o_5.xy = (tmpvar_7 + tmpvar_6.w);
					  o_5.zw = tmpvar_3.zw;
					  tmpvar_2.xyw = o_5.xyw;
					  highp vec4 tmpvar_8;
					  tmpvar_8.w = 1.0;
					  tmpvar_8.xyz = tmpvar_1.xyz;
					  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_8)).z);
					  gl_Position = tmpvar_3;
					  xlv_COLOR = _glesColor;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _TintColor;
					uniform lowp vec4 _CoreColor;
					uniform highp float _CutOutLightCore;
					uniform highp float _TintStrength;
					uniform highp float _CoreStrength;
					uniform sampler2D _CameraDepthTexture;
					uniform highp float _InvFade;
					varying lowp vec4 xlv_COLOR;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  tmpvar_1.xyz = xlv_COLOR.xyz;
					  lowp vec4 col_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
					  highp float z_4;
					  z_4 = tmpvar_3.x;
					  highp float tmpvar_5;
					  tmpvar_5 = clamp ((_InvFade * (
					    (1.0/(((_ZBufferParams.z * z_4) + _ZBufferParams.w)))
					   - xlv_TEXCOORD1.z)), 0.0, 1.0);
					  tmpvar_1.w = (xlv_COLOR.w * tmpvar_5);
					  lowp vec4 tmpvar_6;
					  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
					  highp vec4 tmpvar_7;
					  tmpvar_7 = (((
					    (_TintColor * tmpvar_6.y)
					   * _TintStrength) + (
					    (tmpvar_6.x * _CoreColor)
					   * _CoreStrength)) - _CutOutLightCore);
					  col_2 = tmpvar_7;
					  lowp vec4 tmpvar_8;
					  tmpvar_8 = (tmpvar_1 * clamp (col_2, vec4(0.0, 0.0, 0.0, 0.0), vec4(255.0, 255.0, 255.0, 255.0)));
					  gl_FragData[0] = tmpvar_8;
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
					uniform highp vec4 _MainTex_ST;
					varying lowp vec4 xlv_COLOR;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  highp vec4 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = tmpvar_1.xyz;
					  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  highp vec4 o_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6 = (tmpvar_3 * 0.5);
					  highp vec2 tmpvar_7;
					  tmpvar_7.x = tmpvar_6.x;
					  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
					  o_5.xy = (tmpvar_7 + tmpvar_6.w);
					  o_5.zw = tmpvar_3.zw;
					  tmpvar_2.xyw = o_5.xyw;
					  highp vec4 tmpvar_8;
					  tmpvar_8.w = 1.0;
					  tmpvar_8.xyz = tmpvar_1.xyz;
					  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_8)).z);
					  gl_Position = tmpvar_3;
					  xlv_COLOR = _glesColor;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _TintColor;
					uniform lowp vec4 _CoreColor;
					uniform highp float _CutOutLightCore;
					uniform highp float _TintStrength;
					uniform highp float _CoreStrength;
					uniform sampler2D _CameraDepthTexture;
					uniform highp float _InvFade;
					varying lowp vec4 xlv_COLOR;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  tmpvar_1.xyz = xlv_COLOR.xyz;
					  lowp vec4 col_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
					  highp float z_4;
					  z_4 = tmpvar_3.x;
					  highp float tmpvar_5;
					  tmpvar_5 = clamp ((_InvFade * (
					    (1.0/(((_ZBufferParams.z * z_4) + _ZBufferParams.w)))
					   - xlv_TEXCOORD1.z)), 0.0, 1.0);
					  tmpvar_1.w = (xlv_COLOR.w * tmpvar_5);
					  lowp vec4 tmpvar_6;
					  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
					  highp vec4 tmpvar_7;
					  tmpvar_7 = (((
					    (_TintColor * tmpvar_6.y)
					   * _TintStrength) + (
					    (tmpvar_6.x * _CoreColor)
					   * _CoreStrength)) - _CutOutLightCore);
					  col_2 = tmpvar_7;
					  lowp vec4 tmpvar_8;
					  tmpvar_8 = (tmpvar_1 * clamp (col_2, vec4(0.0, 0.0, 0.0, 0.0), vec4(255.0, 255.0, 255.0, 255.0)));
					  gl_FragData[0] = tmpvar_8;
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
					uniform highp vec4 _MainTex_ST;
					varying lowp vec4 xlv_COLOR;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  highp vec4 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = tmpvar_1.xyz;
					  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  highp vec4 o_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6 = (tmpvar_3 * 0.5);
					  highp vec2 tmpvar_7;
					  tmpvar_7.x = tmpvar_6.x;
					  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
					  o_5.xy = (tmpvar_7 + tmpvar_6.w);
					  o_5.zw = tmpvar_3.zw;
					  tmpvar_2.xyw = o_5.xyw;
					  highp vec4 tmpvar_8;
					  tmpvar_8.w = 1.0;
					  tmpvar_8.xyz = tmpvar_1.xyz;
					  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_8)).z);
					  gl_Position = tmpvar_3;
					  xlv_COLOR = _glesColor;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
					uniform sampler2D _MainTex;
					uniform lowp vec4 _TintColor;
					uniform lowp vec4 _CoreColor;
					uniform highp float _CutOutLightCore;
					uniform highp float _TintStrength;
					uniform highp float _CoreStrength;
					uniform sampler2D _CameraDepthTexture;
					uniform highp float _InvFade;
					varying lowp vec4 xlv_COLOR;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  tmpvar_1.xyz = xlv_COLOR.xyz;
					  lowp vec4 col_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
					  highp float z_4;
					  z_4 = tmpvar_3.x;
					  highp float tmpvar_5;
					  tmpvar_5 = clamp ((_InvFade * (
					    (1.0/(((_ZBufferParams.z * z_4) + _ZBufferParams.w)))
					   - xlv_TEXCOORD1.z)), 0.0, 1.0);
					  tmpvar_1.w = (xlv_COLOR.w * tmpvar_5);
					  lowp vec4 tmpvar_6;
					  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
					  highp vec4 tmpvar_7;
					  tmpvar_7 = (((
					    (_TintColor * tmpvar_6.y)
					   * _TintStrength) + (
					    (tmpvar_6.x * _CoreColor)
					   * _CoreStrength)) - _CutOutLightCore);
					  col_2 = tmpvar_7;
					  lowp vec4 tmpvar_8;
					  tmpvar_8 = (tmpvar_1 * clamp (col_2, vec4(0.0, 0.0, 0.0, 0.0), vec4(255.0, 255.0, 255.0, 255.0)));
					  gl_FragData[0] = tmpvar_8;
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
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in mediump vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
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
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
					    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
					    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
					    vs_TEXCOORD1.z = (-u_xlat0.x);
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD1.w = u_xlat1.w;
					    vs_TEXCOORD1.xy = u_xlat0.zz + u_xlat0.xw;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 _TintColor;
					uniform 	mediump vec4 _CoreColor;
					uniform 	float _CutOutLightCore;
					uniform 	float _TintStrength;
					uniform 	float _CoreStrength;
					uniform 	float _InvFade;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _MainTex;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec2 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec4 u_xlat16_2;
					lowp vec2 u_xlat10_3;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
					    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
					    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
					    u_xlat0.x = u_xlat0.x * _InvFade;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
					    u_xlat10_3.xy = texture(_MainTex, vs_TEXCOORD0.xy).xy;
					    u_xlat16_1 = u_xlat10_3.xxxx * _CoreColor;
					    u_xlat16_2 = u_xlat10_3.yyyy * _TintColor;
					    u_xlat1 = u_xlat16_1 * vec4(vec4(_CoreStrength, _CoreStrength, _CoreStrength, _CoreStrength));
					    u_xlat1 = u_xlat16_2 * vec4(vec4(_TintStrength, _TintStrength, _TintStrength, _TintStrength)) + u_xlat1;
					    u_xlat1 = u_xlat1 + (-vec4(_CutOutLightCore));
					    u_xlat16_1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat16_1 = min(u_xlat16_1, vec4(255.0, 255.0, 255.0, 255.0));
					    SV_Target0.w = u_xlat0.x * u_xlat16_1.w;
					    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
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
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in mediump vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
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
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
					    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
					    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
					    vs_TEXCOORD1.z = (-u_xlat0.x);
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD1.w = u_xlat1.w;
					    vs_TEXCOORD1.xy = u_xlat0.zz + u_xlat0.xw;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 _TintColor;
					uniform 	mediump vec4 _CoreColor;
					uniform 	float _CutOutLightCore;
					uniform 	float _TintStrength;
					uniform 	float _CoreStrength;
					uniform 	float _InvFade;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _MainTex;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec2 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec4 u_xlat16_2;
					lowp vec2 u_xlat10_3;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
					    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
					    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
					    u_xlat0.x = u_xlat0.x * _InvFade;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
					    u_xlat10_3.xy = texture(_MainTex, vs_TEXCOORD0.xy).xy;
					    u_xlat16_1 = u_xlat10_3.xxxx * _CoreColor;
					    u_xlat16_2 = u_xlat10_3.yyyy * _TintColor;
					    u_xlat1 = u_xlat16_1 * vec4(vec4(_CoreStrength, _CoreStrength, _CoreStrength, _CoreStrength));
					    u_xlat1 = u_xlat16_2 * vec4(vec4(_TintStrength, _TintStrength, _TintStrength, _TintStrength)) + u_xlat1;
					    u_xlat1 = u_xlat1 + (-vec4(_CutOutLightCore));
					    u_xlat16_1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat16_1 = min(u_xlat16_1, vec4(255.0, 255.0, 255.0, 255.0));
					    SV_Target0.w = u_xlat0.x * u_xlat16_1.w;
					    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
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
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in mediump vec4 in_COLOR0;
					in highp vec2 in_TEXCOORD0;
					out mediump vec4 vs_COLOR0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
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
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
					    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
					    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
					    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
					    vs_TEXCOORD1.z = (-u_xlat0.x);
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD1.w = u_xlat1.w;
					    vs_TEXCOORD1.xy = u_xlat0.zz + u_xlat0.xw;
					    return;
					}
					
					#endif
					#ifdef FRAGMENT
					#version 300 es
					
					precision highp int;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 _TintColor;
					uniform 	mediump vec4 _CoreColor;
					uniform 	float _CutOutLightCore;
					uniform 	float _TintStrength;
					uniform 	float _CoreStrength;
					uniform 	float _InvFade;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _MainTex;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec2 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec4 u_xlat16_2;
					lowp vec2 u_xlat10_3;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
					    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
					    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
					    u_xlat0.x = u_xlat0.x * _InvFade;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
					    u_xlat10_3.xy = texture(_MainTex, vs_TEXCOORD0.xy).xy;
					    u_xlat16_1 = u_xlat10_3.xxxx * _CoreColor;
					    u_xlat16_2 = u_xlat10_3.yyyy * _TintColor;
					    u_xlat1 = u_xlat16_1 * vec4(vec4(_CoreStrength, _CoreStrength, _CoreStrength, _CoreStrength));
					    u_xlat1 = u_xlat16_2 * vec4(vec4(_TintStrength, _TintStrength, _TintStrength, _TintStrength)) + u_xlat1;
					    u_xlat1 = u_xlat1 + (-vec4(_CutOutLightCore));
					    u_xlat16_1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat16_1 = min(u_xlat16_1, vec4(255.0, 255.0, 255.0, 255.0));
					    SV_Target0.w = u_xlat0.x * u_xlat16_1.w;
					    SV_Target0.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
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
					; Bound: 177
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Vertex %4 "main" %11 %80 %84 %85 %89 %91 %139 
					                                                      OpDecorate %11 Location 11 
					                                                      OpDecorate %16 ArrayStride 16 
					                                                      OpDecorate %17 ArrayStride 17 
					                                                      OpDecorate %18 ArrayStride 18 
					                                                      OpMemberDecorate %19 0 Offset 19 
					                                                      OpMemberDecorate %19 1 Offset 19 
					                                                      OpMemberDecorate %19 2 Offset 19 
					                                                      OpMemberDecorate %19 3 Offset 19 
					                                                      OpMemberDecorate %19 4 Offset 19 
					                                                      OpDecorate %19 Block 
					                                                      OpDecorate %21 DescriptorSet 21 
					                                                      OpDecorate %21 Binding 21 
					                                                      OpMemberDecorate %78 0 BuiltIn 78 
					                                                      OpMemberDecorate %78 1 BuiltIn 78 
					                                                      OpMemberDecorate %78 2 BuiltIn 78 
					                                                      OpDecorate %78 Block 
					                                                      OpDecorate %84 RelaxedPrecision 
					                                                      OpDecorate %84 Location 84 
					                                                      OpDecorate %85 RelaxedPrecision 
					                                                      OpDecorate %85 Location 85 
					                                                      OpDecorate %86 RelaxedPrecision 
					                                                      OpDecorate %89 Location 89 
					                                                      OpDecorate %91 Location 91 
					                                                      OpDecorate %139 Location 139 
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
					                                              %19 = OpTypeStruct %7 %16 %17 %18 %7 
					                                              %20 = OpTypePointer Uniform %19 
					Uniform struct {f32_4; f32_4[4]; f32_4[4]; f32_4[4]; f32_4;}* %21 = OpVariable Uniform 
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
					                                Output f32_4* %84 = OpVariable Output 
					                                 Input f32_4* %85 = OpVariable Input 
					                                              %87 = OpTypeVector %6 2 
					                                              %88 = OpTypePointer Output %87 
					                                Output f32_2* %89 = OpVariable Output 
					                                              %90 = OpTypePointer Input %87 
					                                 Input f32_2* %91 = OpVariable Input 
					                                          i32 %93 = OpConstant 4 
					                                             %102 = OpTypePointer Private %6 
					                                Private f32* %103 = OpVariable Private 
					                                         u32 %106 = OpConstant 2 
					                                             %107 = OpTypePointer Uniform %6 
					                                         u32 %113 = OpConstant 0 
					                                         u32 %131 = OpConstant 3 
					                               Output f32_4* %139 = OpVariable Output 
					                                             %143 = OpTypePointer Output %6 
					                                         f32 %153 = OpConstant 3.674022E-40 
					                                       f32_2 %158 = OpConstantComposite %153 %153 
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
					                                        f32_4 %86 = OpLoad %85 
					                                                      OpStore %84 %86 
					                                        f32_2 %92 = OpLoad %91 
					                               Uniform f32_4* %94 = OpAccessChain %21 %93 
					                                        f32_4 %95 = OpLoad %94 
					                                        f32_2 %96 = OpVectorShuffle %95 %95 0 1 
					                                        f32_2 %97 = OpFMul %92 %96 
					                               Uniform f32_4* %98 = OpAccessChain %21 %93 
					                                        f32_4 %99 = OpLoad %98 
					                                       f32_2 %100 = OpVectorShuffle %99 %99 2 3 
					                                       f32_2 %101 = OpFAdd %97 %100 
					                                                      OpStore %89 %101 
					                                Private f32* %104 = OpAccessChain %9 %76 
					                                         f32 %105 = OpLoad %104 
					                                Uniform f32* %108 = OpAccessChain %21 %36 %23 %106 
					                                         f32 %109 = OpLoad %108 
					                                         f32 %110 = OpFMul %105 %109 
					                                                      OpStore %103 %110 
					                                Uniform f32* %111 = OpAccessChain %21 %36 %28 %106 
					                                         f32 %112 = OpLoad %111 
					                                Private f32* %114 = OpAccessChain %9 %113 
					                                         f32 %115 = OpLoad %114 
					                                         f32 %116 = OpFMul %112 %115 
					                                         f32 %117 = OpLoad %103 
					                                         f32 %118 = OpFAdd %116 %117 
					                                Private f32* %119 = OpAccessChain %9 %113 
					                                                      OpStore %119 %118 
					                                Uniform f32* %120 = OpAccessChain %21 %36 %36 %106 
					                                         f32 %121 = OpLoad %120 
					                                Private f32* %122 = OpAccessChain %9 %106 
					                                         f32 %123 = OpLoad %122 
					                                         f32 %124 = OpFMul %121 %123 
					                                Private f32* %125 = OpAccessChain %9 %113 
					                                         f32 %126 = OpLoad %125 
					                                         f32 %127 = OpFAdd %124 %126 
					                                Private f32* %128 = OpAccessChain %9 %113 
					                                                      OpStore %128 %127 
					                                Uniform f32* %129 = OpAccessChain %21 %36 %45 %106 
					                                         f32 %130 = OpLoad %129 
					                                Private f32* %132 = OpAccessChain %9 %131 
					                                         f32 %133 = OpLoad %132 
					                                         f32 %134 = OpFMul %130 %133 
					                                Private f32* %135 = OpAccessChain %9 %113 
					                                         f32 %136 = OpLoad %135 
					                                         f32 %137 = OpFAdd %134 %136 
					                                Private f32* %138 = OpAccessChain %9 %113 
					                                                      OpStore %138 %137 
					                                Private f32* %140 = OpAccessChain %9 %113 
					                                         f32 %141 = OpLoad %140 
					                                         f32 %142 = OpFNegate %141 
					                                 Output f32* %144 = OpAccessChain %139 %106 
					                                                      OpStore %144 %142 
					                                Private f32* %145 = OpAccessChain %49 %76 
					                                         f32 %146 = OpLoad %145 
					                                Uniform f32* %147 = OpAccessChain %21 %28 %113 
					                                         f32 %148 = OpLoad %147 
					                                         f32 %149 = OpFMul %146 %148 
					                                Private f32* %150 = OpAccessChain %9 %113 
					                                                      OpStore %150 %149 
					                                Private f32* %151 = OpAccessChain %9 %113 
					                                         f32 %152 = OpLoad %151 
					                                         f32 %154 = OpFMul %152 %153 
					                                Private f32* %155 = OpAccessChain %9 %131 
					                                                      OpStore %155 %154 
					                                       f32_4 %156 = OpLoad %49 
					                                       f32_2 %157 = OpVectorShuffle %156 %156 0 3 
					                                       f32_2 %159 = OpFMul %157 %158 
					                                       f32_4 %160 = OpLoad %9 
					                                       f32_4 %161 = OpVectorShuffle %160 %159 4 1 5 3 
					                                                      OpStore %9 %161 
					                                Private f32* %162 = OpAccessChain %49 %131 
					                                         f32 %163 = OpLoad %162 
					                                 Output f32* %164 = OpAccessChain %139 %131 
					                                                      OpStore %164 %163 
					                                       f32_4 %165 = OpLoad %9 
					                                       f32_2 %166 = OpVectorShuffle %165 %165 2 2 
					                                       f32_4 %167 = OpLoad %9 
					                                       f32_2 %168 = OpVectorShuffle %167 %167 0 3 
					                                       f32_2 %169 = OpFAdd %166 %168 
					                                       f32_4 %170 = OpLoad %139 
					                                       f32_4 %171 = OpVectorShuffle %170 %169 4 5 2 3 
					                                                      OpStore %139 %171 
					                                 Output f32* %172 = OpAccessChain %80 %28 %76 
					                                         f32 %173 = OpLoad %172 
					                                         f32 %174 = OpFNegate %173 
					                                 Output f32* %175 = OpAccessChain %80 %28 %76 
					                                                      OpStore %175 %174 
					                                                      OpReturn
					                                                      OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 1
					; Bound: 172
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Fragment %4 "main" %12 %74 %83 %155 
					                                                      OpExecutionMode %4 OriginUpperLeft 
					                                                      OpDecorate %12 Location 12 
					                                                      OpDecorate %21 DescriptorSet 21 
					                                                      OpDecorate %21 Binding 21 
					                                                      OpMemberDecorate %30 0 Offset 30 
					                                                      OpMemberDecorate %30 1 RelaxedPrecision 
					                                                      OpMemberDecorate %30 1 Offset 30 
					                                                      OpMemberDecorate %30 2 RelaxedPrecision 
					                                                      OpMemberDecorate %30 2 Offset 30 
					                                                      OpMemberDecorate %30 3 Offset 30 
					                                                      OpMemberDecorate %30 4 Offset 30 
					                                                      OpMemberDecorate %30 5 Offset 30 
					                                                      OpMemberDecorate %30 6 Offset 30 
					                                                      OpDecorate %30 Block 
					                                                      OpDecorate %32 DescriptorSet 32 
					                                                      OpDecorate %32 Binding 32 
					                                                      OpDecorate %74 RelaxedPrecision 
					                                                      OpDecorate %74 Location 74 
					                                                      OpDecorate %76 RelaxedPrecision 
					                                                      OpDecorate %79 RelaxedPrecision 
					                                                      OpDecorate %80 RelaxedPrecision 
					                                                      OpDecorate %80 DescriptorSet 80 
					                                                      OpDecorate %80 Binding 80 
					                                                      OpDecorate %81 RelaxedPrecision 
					                                                      OpDecorate %83 Location 83 
					                                                      OpDecorate %86 RelaxedPrecision 
					                                                      OpDecorate %88 RelaxedPrecision 
					                                                      OpDecorate %89 RelaxedPrecision 
					                                                      OpDecorate %90 RelaxedPrecision 
					                                                      OpDecorate %94 RelaxedPrecision 
					                                                      OpDecorate %95 RelaxedPrecision 
					                                                      OpDecorate %96 RelaxedPrecision 
					                                                      OpDecorate %97 RelaxedPrecision 
					                                                      OpDecorate %98 RelaxedPrecision 
					                                                      OpDecorate %101 RelaxedPrecision 
					                                                      OpDecorate %102 RelaxedPrecision 
					                                                      OpDecorate %104 RelaxedPrecision 
					                                                      OpDecorate %114 RelaxedPrecision 
					                                                      OpDecorate %115 RelaxedPrecision 
					                                                      OpDecorate %116 RelaxedPrecision 
					                                                      OpDecorate %117 RelaxedPrecision 
					                                                      OpDecorate %118 RelaxedPrecision 
					                                                      OpDecorate %119 RelaxedPrecision 
					                                                      OpDecorate %120 RelaxedPrecision 
					                                                      OpDecorate %121 RelaxedPrecision 
					                                                      OpDecorate %131 RelaxedPrecision 
					                                                      OpDecorate %132 RelaxedPrecision 
					                                                      OpDecorate %133 RelaxedPrecision 
					                                                      OpDecorate %134 RelaxedPrecision 
					                                                      OpDecorate %135 RelaxedPrecision 
					                                                      OpDecorate %136 RelaxedPrecision 
					                                                      OpDecorate %137 RelaxedPrecision 
					                                                      OpDecorate %150 RelaxedPrecision 
					                                                      OpDecorate %153 RelaxedPrecision 
					                                                      OpDecorate %155 RelaxedPrecision 
					                                                      OpDecorate %155 Location 155 
					                                                      OpDecorate %159 RelaxedPrecision 
					                                                      OpDecorate %164 RelaxedPrecision 
					                                                      OpDecorate %165 RelaxedPrecision 
					                                                      OpDecorate %166 RelaxedPrecision 
					                                                      OpDecorate %167 RelaxedPrecision 
					                                                      OpDecorate %168 RelaxedPrecision 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 2 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_2* %9 = OpVariable Private 
					                                              %10 = OpTypeVector %6 4 
					                                              %11 = OpTypePointer Input %10 
					                                 Input f32_4* %12 = OpVariable Input 
					                                              %18 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                              %19 = OpTypeSampledImage %18 
					                                              %20 = OpTypePointer UniformConstant %19 
					  UniformConstant read_only Texture2DSampled* %21 = OpVariable UniformConstant 
					                                              %25 = OpTypeInt 32 0 
					                                          u32 %26 = OpConstant 0 
					                                              %28 = OpTypePointer Private %6 
					                                              %30 = OpTypeStruct %10 %10 %10 %6 %6 %6 %6 
					                                              %31 = OpTypePointer Uniform %30 
					Uniform struct {f32_4; f32_4; f32_4; f32; f32; f32; f32;}* %32 = OpVariable Uniform 
					                                              %33 = OpTypeInt 32 1 
					                                          i32 %34 = OpConstant 0 
					                                          u32 %35 = OpConstant 2 
					                                              %36 = OpTypePointer Uniform %6 
					                                          u32 %42 = OpConstant 3 
					                                          f32 %47 = OpConstant 3.674022E-40 
					                                              %54 = OpTypePointer Input %6 
					                                          i32 %62 = OpConstant 6 
					                                          f32 %69 = OpConstant 3.674022E-40 
					                                 Input f32_4* %74 = OpVariable Input 
					                               Private f32_2* %79 = OpVariable Private 
					  UniformConstant read_only Texture2DSampled* %80 = OpVariable UniformConstant 
					                                              %82 = OpTypePointer Input %7 
					                                 Input f32_2* %83 = OpVariable Input 
					                                              %87 = OpTypePointer Private %10 
					                               Private f32_4* %88 = OpVariable Private 
					                                          i32 %91 = OpConstant 2 
					                                              %92 = OpTypePointer Uniform %10 
					                               Private f32_4* %96 = OpVariable Private 
					                                          i32 %99 = OpConstant 1 
					                              Private f32_4* %103 = OpVariable Private 
					                                         i32 %105 = OpConstant 5 
					                                         i32 %122 = OpConstant 4 
					                                         i32 %141 = OpConstant 3 
					                                       f32_4 %148 = OpConstantComposite %69 %69 %69 %69 
					                                         f32 %151 = OpConstant 3.674022E-40 
					                                       f32_4 %152 = OpConstantComposite %151 %151 %151 %151 
					                                             %154 = OpTypePointer Output %10 
					                               Output f32_4* %155 = OpVariable Output 
					                                             %161 = OpTypePointer Output %6 
					                                             %163 = OpTypeVector %6 3 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                        f32_4 %13 = OpLoad %12 
					                                        f32_2 %14 = OpVectorShuffle %13 %13 0 1 
					                                        f32_4 %15 = OpLoad %12 
					                                        f32_2 %16 = OpVectorShuffle %15 %15 3 3 
					                                        f32_2 %17 = OpFDiv %14 %16 
					                                                      OpStore %9 %17 
					                   read_only Texture2DSampled %22 = OpLoad %21 
					                                        f32_2 %23 = OpLoad %9 
					                                        f32_4 %24 = OpImageSampleImplicitLod %22 %23 
					                                          f32 %27 = OpCompositeExtract %24 0 
					                                 Private f32* %29 = OpAccessChain %9 %26 
					                                                      OpStore %29 %27 
					                                 Uniform f32* %37 = OpAccessChain %32 %34 %35 
					                                          f32 %38 = OpLoad %37 
					                                 Private f32* %39 = OpAccessChain %9 %26 
					                                          f32 %40 = OpLoad %39 
					                                          f32 %41 = OpFMul %38 %40 
					                                 Uniform f32* %43 = OpAccessChain %32 %34 %42 
					                                          f32 %44 = OpLoad %43 
					                                          f32 %45 = OpFAdd %41 %44 
					                                 Private f32* %46 = OpAccessChain %9 %26 
					                                                      OpStore %46 %45 
					                                 Private f32* %48 = OpAccessChain %9 %26 
					                                          f32 %49 = OpLoad %48 
					                                          f32 %50 = OpFDiv %47 %49 
					                                 Private f32* %51 = OpAccessChain %9 %26 
					                                                      OpStore %51 %50 
					                                 Private f32* %52 = OpAccessChain %9 %26 
					                                          f32 %53 = OpLoad %52 
					                                   Input f32* %55 = OpAccessChain %12 %35 
					                                          f32 %56 = OpLoad %55 
					                                          f32 %57 = OpFNegate %56 
					                                          f32 %58 = OpFAdd %53 %57 
					                                 Private f32* %59 = OpAccessChain %9 %26 
					                                                      OpStore %59 %58 
					                                 Private f32* %60 = OpAccessChain %9 %26 
					                                          f32 %61 = OpLoad %60 
					                                 Uniform f32* %63 = OpAccessChain %32 %62 
					                                          f32 %64 = OpLoad %63 
					                                          f32 %65 = OpFMul %61 %64 
					                                 Private f32* %66 = OpAccessChain %9 %26 
					                                                      OpStore %66 %65 
					                                 Private f32* %67 = OpAccessChain %9 %26 
					                                          f32 %68 = OpLoad %67 
					                                          f32 %70 = OpExtInst %1 43 %68 %69 %47 
					                                 Private f32* %71 = OpAccessChain %9 %26 
					                                                      OpStore %71 %70 
					                                 Private f32* %72 = OpAccessChain %9 %26 
					                                          f32 %73 = OpLoad %72 
					                                   Input f32* %75 = OpAccessChain %74 %42 
					                                          f32 %76 = OpLoad %75 
					                                          f32 %77 = OpFMul %73 %76 
					                                 Private f32* %78 = OpAccessChain %9 %26 
					                                                      OpStore %78 %77 
					                   read_only Texture2DSampled %81 = OpLoad %80 
					                                        f32_2 %84 = OpLoad %83 
					                                        f32_4 %85 = OpImageSampleImplicitLod %81 %84 
					                                        f32_2 %86 = OpVectorShuffle %85 %85 0 1 
					                                                      OpStore %79 %86 
					                                        f32_2 %89 = OpLoad %79 
					                                        f32_4 %90 = OpVectorShuffle %89 %89 0 0 0 0 
					                               Uniform f32_4* %93 = OpAccessChain %32 %91 
					                                        f32_4 %94 = OpLoad %93 
					                                        f32_4 %95 = OpFMul %90 %94 
					                                                      OpStore %88 %95 
					                                        f32_2 %97 = OpLoad %79 
					                                        f32_4 %98 = OpVectorShuffle %97 %97 1 1 1 1 
					                              Uniform f32_4* %100 = OpAccessChain %32 %99 
					                                       f32_4 %101 = OpLoad %100 
					                                       f32_4 %102 = OpFMul %98 %101 
					                                                      OpStore %96 %102 
					                                       f32_4 %104 = OpLoad %88 
					                                Uniform f32* %106 = OpAccessChain %32 %105 
					                                         f32 %107 = OpLoad %106 
					                                Uniform f32* %108 = OpAccessChain %32 %105 
					                                         f32 %109 = OpLoad %108 
					                                Uniform f32* %110 = OpAccessChain %32 %105 
					                                         f32 %111 = OpLoad %110 
					                                Uniform f32* %112 = OpAccessChain %32 %105 
					                                         f32 %113 = OpLoad %112 
					                                       f32_4 %114 = OpCompositeConstruct %107 %109 %111 %113 
					                                         f32 %115 = OpCompositeExtract %114 0 
					                                         f32 %116 = OpCompositeExtract %114 1 
					                                         f32 %117 = OpCompositeExtract %114 2 
					                                         f32 %118 = OpCompositeExtract %114 3 
					                                       f32_4 %119 = OpCompositeConstruct %115 %116 %117 %118 
					                                       f32_4 %120 = OpFMul %104 %119 
					                                                      OpStore %103 %120 
					                                       f32_4 %121 = OpLoad %96 
					                                Uniform f32* %123 = OpAccessChain %32 %122 
					                                         f32 %124 = OpLoad %123 
					                                Uniform f32* %125 = OpAccessChain %32 %122 
					                                         f32 %126 = OpLoad %125 
					                                Uniform f32* %127 = OpAccessChain %32 %122 
					                                         f32 %128 = OpLoad %127 
					                                Uniform f32* %129 = OpAccessChain %32 %122 
					                                         f32 %130 = OpLoad %129 
					                                       f32_4 %131 = OpCompositeConstruct %124 %126 %128 %130 
					                                         f32 %132 = OpCompositeExtract %131 0 
					                                         f32 %133 = OpCompositeExtract %131 1 
					                                         f32 %134 = OpCompositeExtract %131 2 
					                                         f32 %135 = OpCompositeExtract %131 3 
					                                       f32_4 %136 = OpCompositeConstruct %132 %133 %134 %135 
					                                       f32_4 %137 = OpFMul %121 %136 
					                                       f32_4 %138 = OpLoad %103 
					                                       f32_4 %139 = OpFAdd %137 %138 
					                                                      OpStore %103 %139 
					                                       f32_4 %140 = OpLoad %103 
					                                Uniform f32* %142 = OpAccessChain %32 %141 
					                                         f32 %143 = OpLoad %142 
					                                       f32_4 %144 = OpCompositeConstruct %143 %143 %143 %143 
					                                       f32_4 %145 = OpFNegate %144 
					                                       f32_4 %146 = OpFAdd %140 %145 
					                                                      OpStore %103 %146 
					                                       f32_4 %147 = OpLoad %103 
					                                       f32_4 %149 = OpExtInst %1 40 %147 %148 
					                                                      OpStore %88 %149 
					                                       f32_4 %150 = OpLoad %88 
					                                       f32_4 %153 = OpExtInst %1 37 %150 %152 
					                                                      OpStore %88 %153 
					                                Private f32* %156 = OpAccessChain %9 %26 
					                                         f32 %157 = OpLoad %156 
					                                Private f32* %158 = OpAccessChain %88 %42 
					                                         f32 %159 = OpLoad %158 
					                                         f32 %160 = OpFMul %157 %159 
					                                 Output f32* %162 = OpAccessChain %155 %42 
					                                                      OpStore %162 %160 
					                                       f32_4 %164 = OpLoad %88 
					                                       f32_3 %165 = OpVectorShuffle %164 %164 0 1 2 
					                                       f32_4 %166 = OpLoad %74 
					                                       f32_3 %167 = OpVectorShuffle %166 %166 0 1 2 
					                                       f32_3 %168 = OpFMul %165 %167 
					                                       f32_4 %169 = OpLoad %155 
					                                       f32_4 %170 = OpVectorShuffle %169 %168 4 5 6 3 
					                                                      OpStore %155 %170 
					                                                      OpReturn
					                                                      OpFunctionEnd"
				}
				SubProgram "vulkan hw_tier01 " {
					Keywords { "SOFTPARTICLES_ON" }
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 1
					; Bound: 177
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Vertex %4 "main" %11 %80 %84 %85 %89 %91 %139 
					                                                      OpDecorate %11 Location 11 
					                                                      OpDecorate %16 ArrayStride 16 
					                                                      OpDecorate %17 ArrayStride 17 
					                                                      OpDecorate %18 ArrayStride 18 
					                                                      OpMemberDecorate %19 0 Offset 19 
					                                                      OpMemberDecorate %19 1 Offset 19 
					                                                      OpMemberDecorate %19 2 Offset 19 
					                                                      OpMemberDecorate %19 3 Offset 19 
					                                                      OpMemberDecorate %19 4 Offset 19 
					                                                      OpDecorate %19 Block 
					                                                      OpDecorate %21 DescriptorSet 21 
					                                                      OpDecorate %21 Binding 21 
					                                                      OpMemberDecorate %78 0 BuiltIn 78 
					                                                      OpMemberDecorate %78 1 BuiltIn 78 
					                                                      OpMemberDecorate %78 2 BuiltIn 78 
					                                                      OpDecorate %78 Block 
					                                                      OpDecorate %84 RelaxedPrecision 
					                                                      OpDecorate %84 Location 84 
					                                                      OpDecorate %85 RelaxedPrecision 
					                                                      OpDecorate %85 Location 85 
					                                                      OpDecorate %86 RelaxedPrecision 
					                                                      OpDecorate %89 Location 89 
					                                                      OpDecorate %91 Location 91 
					                                                      OpDecorate %139 Location 139 
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
					                                              %19 = OpTypeStruct %7 %16 %17 %18 %7 
					                                              %20 = OpTypePointer Uniform %19 
					Uniform struct {f32_4; f32_4[4]; f32_4[4]; f32_4[4]; f32_4;}* %21 = OpVariable Uniform 
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
					                                Output f32_4* %84 = OpVariable Output 
					                                 Input f32_4* %85 = OpVariable Input 
					                                              %87 = OpTypeVector %6 2 
					                                              %88 = OpTypePointer Output %87 
					                                Output f32_2* %89 = OpVariable Output 
					                                              %90 = OpTypePointer Input %87 
					                                 Input f32_2* %91 = OpVariable Input 
					                                          i32 %93 = OpConstant 4 
					                                             %102 = OpTypePointer Private %6 
					                                Private f32* %103 = OpVariable Private 
					                                         u32 %106 = OpConstant 2 
					                                             %107 = OpTypePointer Uniform %6 
					                                         u32 %113 = OpConstant 0 
					                                         u32 %131 = OpConstant 3 
					                               Output f32_4* %139 = OpVariable Output 
					                                             %143 = OpTypePointer Output %6 
					                                         f32 %153 = OpConstant 3.674022E-40 
					                                       f32_2 %158 = OpConstantComposite %153 %153 
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
					                                        f32_4 %86 = OpLoad %85 
					                                                      OpStore %84 %86 
					                                        f32_2 %92 = OpLoad %91 
					                               Uniform f32_4* %94 = OpAccessChain %21 %93 
					                                        f32_4 %95 = OpLoad %94 
					                                        f32_2 %96 = OpVectorShuffle %95 %95 0 1 
					                                        f32_2 %97 = OpFMul %92 %96 
					                               Uniform f32_4* %98 = OpAccessChain %21 %93 
					                                        f32_4 %99 = OpLoad %98 
					                                       f32_2 %100 = OpVectorShuffle %99 %99 2 3 
					                                       f32_2 %101 = OpFAdd %97 %100 
					                                                      OpStore %89 %101 
					                                Private f32* %104 = OpAccessChain %9 %76 
					                                         f32 %105 = OpLoad %104 
					                                Uniform f32* %108 = OpAccessChain %21 %36 %23 %106 
					                                         f32 %109 = OpLoad %108 
					                                         f32 %110 = OpFMul %105 %109 
					                                                      OpStore %103 %110 
					                                Uniform f32* %111 = OpAccessChain %21 %36 %28 %106 
					                                         f32 %112 = OpLoad %111 
					                                Private f32* %114 = OpAccessChain %9 %113 
					                                         f32 %115 = OpLoad %114 
					                                         f32 %116 = OpFMul %112 %115 
					                                         f32 %117 = OpLoad %103 
					                                         f32 %118 = OpFAdd %116 %117 
					                                Private f32* %119 = OpAccessChain %9 %113 
					                                                      OpStore %119 %118 
					                                Uniform f32* %120 = OpAccessChain %21 %36 %36 %106 
					                                         f32 %121 = OpLoad %120 
					                                Private f32* %122 = OpAccessChain %9 %106 
					                                         f32 %123 = OpLoad %122 
					                                         f32 %124 = OpFMul %121 %123 
					                                Private f32* %125 = OpAccessChain %9 %113 
					                                         f32 %126 = OpLoad %125 
					                                         f32 %127 = OpFAdd %124 %126 
					                                Private f32* %128 = OpAccessChain %9 %113 
					                                                      OpStore %128 %127 
					                                Uniform f32* %129 = OpAccessChain %21 %36 %45 %106 
					                                         f32 %130 = OpLoad %129 
					                                Private f32* %132 = OpAccessChain %9 %131 
					                                         f32 %133 = OpLoad %132 
					                                         f32 %134 = OpFMul %130 %133 
					                                Private f32* %135 = OpAccessChain %9 %113 
					                                         f32 %136 = OpLoad %135 
					                                         f32 %137 = OpFAdd %134 %136 
					                                Private f32* %138 = OpAccessChain %9 %113 
					                                                      OpStore %138 %137 
					                                Private f32* %140 = OpAccessChain %9 %113 
					                                         f32 %141 = OpLoad %140 
					                                         f32 %142 = OpFNegate %141 
					                                 Output f32* %144 = OpAccessChain %139 %106 
					                                                      OpStore %144 %142 
					                                Private f32* %145 = OpAccessChain %49 %76 
					                                         f32 %146 = OpLoad %145 
					                                Uniform f32* %147 = OpAccessChain %21 %28 %113 
					                                         f32 %148 = OpLoad %147 
					                                         f32 %149 = OpFMul %146 %148 
					                                Private f32* %150 = OpAccessChain %9 %113 
					                                                      OpStore %150 %149 
					                                Private f32* %151 = OpAccessChain %9 %113 
					                                         f32 %152 = OpLoad %151 
					                                         f32 %154 = OpFMul %152 %153 
					                                Private f32* %155 = OpAccessChain %9 %131 
					                                                      OpStore %155 %154 
					                                       f32_4 %156 = OpLoad %49 
					                                       f32_2 %157 = OpVectorShuffle %156 %156 0 3 
					                                       f32_2 %159 = OpFMul %157 %158 
					                                       f32_4 %160 = OpLoad %9 
					                                       f32_4 %161 = OpVectorShuffle %160 %159 4 1 5 3 
					                                                      OpStore %9 %161 
					                                Private f32* %162 = OpAccessChain %49 %131 
					                                         f32 %163 = OpLoad %162 
					                                 Output f32* %164 = OpAccessChain %139 %131 
					                                                      OpStore %164 %163 
					                                       f32_4 %165 = OpLoad %9 
					                                       f32_2 %166 = OpVectorShuffle %165 %165 2 2 
					                                       f32_4 %167 = OpLoad %9 
					                                       f32_2 %168 = OpVectorShuffle %167 %167 0 3 
					                                       f32_2 %169 = OpFAdd %166 %168 
					                                       f32_4 %170 = OpLoad %139 
					                                       f32_4 %171 = OpVectorShuffle %170 %169 4 5 2 3 
					                                                      OpStore %139 %171 
					                                 Output f32* %172 = OpAccessChain %80 %28 %76 
					                                         f32 %173 = OpLoad %172 
					                                         f32 %174 = OpFNegate %173 
					                                 Output f32* %175 = OpAccessChain %80 %28 %76 
					                                                      OpStore %175 %174 
					                                                      OpReturn
					                                                      OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 1
					; Bound: 172
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Fragment %4 "main" %12 %74 %83 %155 
					                                                      OpExecutionMode %4 OriginUpperLeft 
					                                                      OpDecorate %12 Location 12 
					                                                      OpDecorate %21 DescriptorSet 21 
					                                                      OpDecorate %21 Binding 21 
					                                                      OpMemberDecorate %30 0 Offset 30 
					                                                      OpMemberDecorate %30 1 RelaxedPrecision 
					                                                      OpMemberDecorate %30 1 Offset 30 
					                                                      OpMemberDecorate %30 2 RelaxedPrecision 
					                                                      OpMemberDecorate %30 2 Offset 30 
					                                                      OpMemberDecorate %30 3 Offset 30 
					                                                      OpMemberDecorate %30 4 Offset 30 
					                                                      OpMemberDecorate %30 5 Offset 30 
					                                                      OpMemberDecorate %30 6 Offset 30 
					                                                      OpDecorate %30 Block 
					                                                      OpDecorate %32 DescriptorSet 32 
					                                                      OpDecorate %32 Binding 32 
					                                                      OpDecorate %74 RelaxedPrecision 
					                                                      OpDecorate %74 Location 74 
					                                                      OpDecorate %76 RelaxedPrecision 
					                                                      OpDecorate %79 RelaxedPrecision 
					                                                      OpDecorate %80 RelaxedPrecision 
					                                                      OpDecorate %80 DescriptorSet 80 
					                                                      OpDecorate %80 Binding 80 
					                                                      OpDecorate %81 RelaxedPrecision 
					                                                      OpDecorate %83 Location 83 
					                                                      OpDecorate %86 RelaxedPrecision 
					                                                      OpDecorate %88 RelaxedPrecision 
					                                                      OpDecorate %89 RelaxedPrecision 
					                                                      OpDecorate %90 RelaxedPrecision 
					                                                      OpDecorate %94 RelaxedPrecision 
					                                                      OpDecorate %95 RelaxedPrecision 
					                                                      OpDecorate %96 RelaxedPrecision 
					                                                      OpDecorate %97 RelaxedPrecision 
					                                                      OpDecorate %98 RelaxedPrecision 
					                                                      OpDecorate %101 RelaxedPrecision 
					                                                      OpDecorate %102 RelaxedPrecision 
					                                                      OpDecorate %104 RelaxedPrecision 
					                                                      OpDecorate %114 RelaxedPrecision 
					                                                      OpDecorate %115 RelaxedPrecision 
					                                                      OpDecorate %116 RelaxedPrecision 
					                                                      OpDecorate %117 RelaxedPrecision 
					                                                      OpDecorate %118 RelaxedPrecision 
					                                                      OpDecorate %119 RelaxedPrecision 
					                                                      OpDecorate %120 RelaxedPrecision 
					                                                      OpDecorate %121 RelaxedPrecision 
					                                                      OpDecorate %131 RelaxedPrecision 
					                                                      OpDecorate %132 RelaxedPrecision 
					                                                      OpDecorate %133 RelaxedPrecision 
					                                                      OpDecorate %134 RelaxedPrecision 
					                                                      OpDecorate %135 RelaxedPrecision 
					                                                      OpDecorate %136 RelaxedPrecision 
					                                                      OpDecorate %137 RelaxedPrecision 
					                                                      OpDecorate %150 RelaxedPrecision 
					                                                      OpDecorate %153 RelaxedPrecision 
					                                                      OpDecorate %155 RelaxedPrecision 
					                                                      OpDecorate %155 Location 155 
					                                                      OpDecorate %159 RelaxedPrecision 
					                                                      OpDecorate %164 RelaxedPrecision 
					                                                      OpDecorate %165 RelaxedPrecision 
					                                                      OpDecorate %166 RelaxedPrecision 
					                                                      OpDecorate %167 RelaxedPrecision 
					                                                      OpDecorate %168 RelaxedPrecision 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 2 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_2* %9 = OpVariable Private 
					                                              %10 = OpTypeVector %6 4 
					                                              %11 = OpTypePointer Input %10 
					                                 Input f32_4* %12 = OpVariable Input 
					                                              %18 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                              %19 = OpTypeSampledImage %18 
					                                              %20 = OpTypePointer UniformConstant %19 
					  UniformConstant read_only Texture2DSampled* %21 = OpVariable UniformConstant 
					                                              %25 = OpTypeInt 32 0 
					                                          u32 %26 = OpConstant 0 
					                                              %28 = OpTypePointer Private %6 
					                                              %30 = OpTypeStruct %10 %10 %10 %6 %6 %6 %6 
					                                              %31 = OpTypePointer Uniform %30 
					Uniform struct {f32_4; f32_4; f32_4; f32; f32; f32; f32;}* %32 = OpVariable Uniform 
					                                              %33 = OpTypeInt 32 1 
					                                          i32 %34 = OpConstant 0 
					                                          u32 %35 = OpConstant 2 
					                                              %36 = OpTypePointer Uniform %6 
					                                          u32 %42 = OpConstant 3 
					                                          f32 %47 = OpConstant 3.674022E-40 
					                                              %54 = OpTypePointer Input %6 
					                                          i32 %62 = OpConstant 6 
					                                          f32 %69 = OpConstant 3.674022E-40 
					                                 Input f32_4* %74 = OpVariable Input 
					                               Private f32_2* %79 = OpVariable Private 
					  UniformConstant read_only Texture2DSampled* %80 = OpVariable UniformConstant 
					                                              %82 = OpTypePointer Input %7 
					                                 Input f32_2* %83 = OpVariable Input 
					                                              %87 = OpTypePointer Private %10 
					                               Private f32_4* %88 = OpVariable Private 
					                                          i32 %91 = OpConstant 2 
					                                              %92 = OpTypePointer Uniform %10 
					                               Private f32_4* %96 = OpVariable Private 
					                                          i32 %99 = OpConstant 1 
					                              Private f32_4* %103 = OpVariable Private 
					                                         i32 %105 = OpConstant 5 
					                                         i32 %122 = OpConstant 4 
					                                         i32 %141 = OpConstant 3 
					                                       f32_4 %148 = OpConstantComposite %69 %69 %69 %69 
					                                         f32 %151 = OpConstant 3.674022E-40 
					                                       f32_4 %152 = OpConstantComposite %151 %151 %151 %151 
					                                             %154 = OpTypePointer Output %10 
					                               Output f32_4* %155 = OpVariable Output 
					                                             %161 = OpTypePointer Output %6 
					                                             %163 = OpTypeVector %6 3 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                        f32_4 %13 = OpLoad %12 
					                                        f32_2 %14 = OpVectorShuffle %13 %13 0 1 
					                                        f32_4 %15 = OpLoad %12 
					                                        f32_2 %16 = OpVectorShuffle %15 %15 3 3 
					                                        f32_2 %17 = OpFDiv %14 %16 
					                                                      OpStore %9 %17 
					                   read_only Texture2DSampled %22 = OpLoad %21 
					                                        f32_2 %23 = OpLoad %9 
					                                        f32_4 %24 = OpImageSampleImplicitLod %22 %23 
					                                          f32 %27 = OpCompositeExtract %24 0 
					                                 Private f32* %29 = OpAccessChain %9 %26 
					                                                      OpStore %29 %27 
					                                 Uniform f32* %37 = OpAccessChain %32 %34 %35 
					                                          f32 %38 = OpLoad %37 
					                                 Private f32* %39 = OpAccessChain %9 %26 
					                                          f32 %40 = OpLoad %39 
					                                          f32 %41 = OpFMul %38 %40 
					                                 Uniform f32* %43 = OpAccessChain %32 %34 %42 
					                                          f32 %44 = OpLoad %43 
					                                          f32 %45 = OpFAdd %41 %44 
					                                 Private f32* %46 = OpAccessChain %9 %26 
					                                                      OpStore %46 %45 
					                                 Private f32* %48 = OpAccessChain %9 %26 
					                                          f32 %49 = OpLoad %48 
					                                          f32 %50 = OpFDiv %47 %49 
					                                 Private f32* %51 = OpAccessChain %9 %26 
					                                                      OpStore %51 %50 
					                                 Private f32* %52 = OpAccessChain %9 %26 
					                                          f32 %53 = OpLoad %52 
					                                   Input f32* %55 = OpAccessChain %12 %35 
					                                          f32 %56 = OpLoad %55 
					                                          f32 %57 = OpFNegate %56 
					                                          f32 %58 = OpFAdd %53 %57 
					                                 Private f32* %59 = OpAccessChain %9 %26 
					                                                      OpStore %59 %58 
					                                 Private f32* %60 = OpAccessChain %9 %26 
					                                          f32 %61 = OpLoad %60 
					                                 Uniform f32* %63 = OpAccessChain %32 %62 
					                                          f32 %64 = OpLoad %63 
					                                          f32 %65 = OpFMul %61 %64 
					                                 Private f32* %66 = OpAccessChain %9 %26 
					                                                      OpStore %66 %65 
					                                 Private f32* %67 = OpAccessChain %9 %26 
					                                          f32 %68 = OpLoad %67 
					                                          f32 %70 = OpExtInst %1 43 %68 %69 %47 
					                                 Private f32* %71 = OpAccessChain %9 %26 
					                                                      OpStore %71 %70 
					                                 Private f32* %72 = OpAccessChain %9 %26 
					                                          f32 %73 = OpLoad %72 
					                                   Input f32* %75 = OpAccessChain %74 %42 
					                                          f32 %76 = OpLoad %75 
					                                          f32 %77 = OpFMul %73 %76 
					                                 Private f32* %78 = OpAccessChain %9 %26 
					                                                      OpStore %78 %77 
					                   read_only Texture2DSampled %81 = OpLoad %80 
					                                        f32_2 %84 = OpLoad %83 
					                                        f32_4 %85 = OpImageSampleImplicitLod %81 %84 
					                                        f32_2 %86 = OpVectorShuffle %85 %85 0 1 
					                                                      OpStore %79 %86 
					                                        f32_2 %89 = OpLoad %79 
					                                        f32_4 %90 = OpVectorShuffle %89 %89 0 0 0 0 
					                               Uniform f32_4* %93 = OpAccessChain %32 %91 
					                                        f32_4 %94 = OpLoad %93 
					                                        f32_4 %95 = OpFMul %90 %94 
					                                                      OpStore %88 %95 
					                                        f32_2 %97 = OpLoad %79 
					                                        f32_4 %98 = OpVectorShuffle %97 %97 1 1 1 1 
					                              Uniform f32_4* %100 = OpAccessChain %32 %99 
					                                       f32_4 %101 = OpLoad %100 
					                                       f32_4 %102 = OpFMul %98 %101 
					                                                      OpStore %96 %102 
					                                       f32_4 %104 = OpLoad %88 
					                                Uniform f32* %106 = OpAccessChain %32 %105 
					                                         f32 %107 = OpLoad %106 
					                                Uniform f32* %108 = OpAccessChain %32 %105 
					                                         f32 %109 = OpLoad %108 
					                                Uniform f32* %110 = OpAccessChain %32 %105 
					                                         f32 %111 = OpLoad %110 
					                                Uniform f32* %112 = OpAccessChain %32 %105 
					                                         f32 %113 = OpLoad %112 
					                                       f32_4 %114 = OpCompositeConstruct %107 %109 %111 %113 
					                                         f32 %115 = OpCompositeExtract %114 0 
					                                         f32 %116 = OpCompositeExtract %114 1 
					                                         f32 %117 = OpCompositeExtract %114 2 
					                                         f32 %118 = OpCompositeExtract %114 3 
					                                       f32_4 %119 = OpCompositeConstruct %115 %116 %117 %118 
					                                       f32_4 %120 = OpFMul %104 %119 
					                                                      OpStore %103 %120 
					                                       f32_4 %121 = OpLoad %96 
					                                Uniform f32* %123 = OpAccessChain %32 %122 
					                                         f32 %124 = OpLoad %123 
					                                Uniform f32* %125 = OpAccessChain %32 %122 
					                                         f32 %126 = OpLoad %125 
					                                Uniform f32* %127 = OpAccessChain %32 %122 
					                                         f32 %128 = OpLoad %127 
					                                Uniform f32* %129 = OpAccessChain %32 %122 
					                                         f32 %130 = OpLoad %129 
					                                       f32_4 %131 = OpCompositeConstruct %124 %126 %128 %130 
					                                         f32 %132 = OpCompositeExtract %131 0 
					                                         f32 %133 = OpCompositeExtract %131 1 
					                                         f32 %134 = OpCompositeExtract %131 2 
					                                         f32 %135 = OpCompositeExtract %131 3 
					                                       f32_4 %136 = OpCompositeConstruct %132 %133 %134 %135 
					                                       f32_4 %137 = OpFMul %121 %136 
					                                       f32_4 %138 = OpLoad %103 
					                                       f32_4 %139 = OpFAdd %137 %138 
					                                                      OpStore %103 %139 
					                                       f32_4 %140 = OpLoad %103 
					                                Uniform f32* %142 = OpAccessChain %32 %141 
					                                         f32 %143 = OpLoad %142 
					                                       f32_4 %144 = OpCompositeConstruct %143 %143 %143 %143 
					                                       f32_4 %145 = OpFNegate %144 
					                                       f32_4 %146 = OpFAdd %140 %145 
					                                                      OpStore %103 %146 
					                                       f32_4 %147 = OpLoad %103 
					                                       f32_4 %149 = OpExtInst %1 40 %147 %148 
					                                                      OpStore %88 %149 
					                                       f32_4 %150 = OpLoad %88 
					                                       f32_4 %153 = OpExtInst %1 37 %150 %152 
					                                                      OpStore %88 %153 
					                                Private f32* %156 = OpAccessChain %9 %26 
					                                         f32 %157 = OpLoad %156 
					                                Private f32* %158 = OpAccessChain %88 %42 
					                                         f32 %159 = OpLoad %158 
					                                         f32 %160 = OpFMul %157 %159 
					                                 Output f32* %162 = OpAccessChain %155 %42 
					                                                      OpStore %162 %160 
					                                       f32_4 %164 = OpLoad %88 
					                                       f32_3 %165 = OpVectorShuffle %164 %164 0 1 2 
					                                       f32_4 %166 = OpLoad %74 
					                                       f32_3 %167 = OpVectorShuffle %166 %166 0 1 2 
					                                       f32_3 %168 = OpFMul %165 %167 
					                                       f32_4 %169 = OpLoad %155 
					                                       f32_4 %170 = OpVectorShuffle %169 %168 4 5 6 3 
					                                                      OpStore %155 %170 
					                                                      OpReturn
					                                                      OpFunctionEnd"
				}
				SubProgram "vulkan hw_tier02 " {
					Keywords { "SOFTPARTICLES_ON" }
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 1
					; Bound: 177
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Vertex %4 "main" %11 %80 %84 %85 %89 %91 %139 
					                                                      OpDecorate %11 Location 11 
					                                                      OpDecorate %16 ArrayStride 16 
					                                                      OpDecorate %17 ArrayStride 17 
					                                                      OpDecorate %18 ArrayStride 18 
					                                                      OpMemberDecorate %19 0 Offset 19 
					                                                      OpMemberDecorate %19 1 Offset 19 
					                                                      OpMemberDecorate %19 2 Offset 19 
					                                                      OpMemberDecorate %19 3 Offset 19 
					                                                      OpMemberDecorate %19 4 Offset 19 
					                                                      OpDecorate %19 Block 
					                                                      OpDecorate %21 DescriptorSet 21 
					                                                      OpDecorate %21 Binding 21 
					                                                      OpMemberDecorate %78 0 BuiltIn 78 
					                                                      OpMemberDecorate %78 1 BuiltIn 78 
					                                                      OpMemberDecorate %78 2 BuiltIn 78 
					                                                      OpDecorate %78 Block 
					                                                      OpDecorate %84 RelaxedPrecision 
					                                                      OpDecorate %84 Location 84 
					                                                      OpDecorate %85 RelaxedPrecision 
					                                                      OpDecorate %85 Location 85 
					                                                      OpDecorate %86 RelaxedPrecision 
					                                                      OpDecorate %89 Location 89 
					                                                      OpDecorate %91 Location 91 
					                                                      OpDecorate %139 Location 139 
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
					                                              %19 = OpTypeStruct %7 %16 %17 %18 %7 
					                                              %20 = OpTypePointer Uniform %19 
					Uniform struct {f32_4; f32_4[4]; f32_4[4]; f32_4[4]; f32_4;}* %21 = OpVariable Uniform 
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
					                                Output f32_4* %84 = OpVariable Output 
					                                 Input f32_4* %85 = OpVariable Input 
					                                              %87 = OpTypeVector %6 2 
					                                              %88 = OpTypePointer Output %87 
					                                Output f32_2* %89 = OpVariable Output 
					                                              %90 = OpTypePointer Input %87 
					                                 Input f32_2* %91 = OpVariable Input 
					                                          i32 %93 = OpConstant 4 
					                                             %102 = OpTypePointer Private %6 
					                                Private f32* %103 = OpVariable Private 
					                                         u32 %106 = OpConstant 2 
					                                             %107 = OpTypePointer Uniform %6 
					                                         u32 %113 = OpConstant 0 
					                                         u32 %131 = OpConstant 3 
					                               Output f32_4* %139 = OpVariable Output 
					                                             %143 = OpTypePointer Output %6 
					                                         f32 %153 = OpConstant 3.674022E-40 
					                                       f32_2 %158 = OpConstantComposite %153 %153 
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
					                                        f32_4 %86 = OpLoad %85 
					                                                      OpStore %84 %86 
					                                        f32_2 %92 = OpLoad %91 
					                               Uniform f32_4* %94 = OpAccessChain %21 %93 
					                                        f32_4 %95 = OpLoad %94 
					                                        f32_2 %96 = OpVectorShuffle %95 %95 0 1 
					                                        f32_2 %97 = OpFMul %92 %96 
					                               Uniform f32_4* %98 = OpAccessChain %21 %93 
					                                        f32_4 %99 = OpLoad %98 
					                                       f32_2 %100 = OpVectorShuffle %99 %99 2 3 
					                                       f32_2 %101 = OpFAdd %97 %100 
					                                                      OpStore %89 %101 
					                                Private f32* %104 = OpAccessChain %9 %76 
					                                         f32 %105 = OpLoad %104 
					                                Uniform f32* %108 = OpAccessChain %21 %36 %23 %106 
					                                         f32 %109 = OpLoad %108 
					                                         f32 %110 = OpFMul %105 %109 
					                                                      OpStore %103 %110 
					                                Uniform f32* %111 = OpAccessChain %21 %36 %28 %106 
					                                         f32 %112 = OpLoad %111 
					                                Private f32* %114 = OpAccessChain %9 %113 
					                                         f32 %115 = OpLoad %114 
					                                         f32 %116 = OpFMul %112 %115 
					                                         f32 %117 = OpLoad %103 
					                                         f32 %118 = OpFAdd %116 %117 
					                                Private f32* %119 = OpAccessChain %9 %113 
					                                                      OpStore %119 %118 
					                                Uniform f32* %120 = OpAccessChain %21 %36 %36 %106 
					                                         f32 %121 = OpLoad %120 
					                                Private f32* %122 = OpAccessChain %9 %106 
					                                         f32 %123 = OpLoad %122 
					                                         f32 %124 = OpFMul %121 %123 
					                                Private f32* %125 = OpAccessChain %9 %113 
					                                         f32 %126 = OpLoad %125 
					                                         f32 %127 = OpFAdd %124 %126 
					                                Private f32* %128 = OpAccessChain %9 %113 
					                                                      OpStore %128 %127 
					                                Uniform f32* %129 = OpAccessChain %21 %36 %45 %106 
					                                         f32 %130 = OpLoad %129 
					                                Private f32* %132 = OpAccessChain %9 %131 
					                                         f32 %133 = OpLoad %132 
					                                         f32 %134 = OpFMul %130 %133 
					                                Private f32* %135 = OpAccessChain %9 %113 
					                                         f32 %136 = OpLoad %135 
					                                         f32 %137 = OpFAdd %134 %136 
					                                Private f32* %138 = OpAccessChain %9 %113 
					                                                      OpStore %138 %137 
					                                Private f32* %140 = OpAccessChain %9 %113 
					                                         f32 %141 = OpLoad %140 
					                                         f32 %142 = OpFNegate %141 
					                                 Output f32* %144 = OpAccessChain %139 %106 
					                                                      OpStore %144 %142 
					                                Private f32* %145 = OpAccessChain %49 %76 
					                                         f32 %146 = OpLoad %145 
					                                Uniform f32* %147 = OpAccessChain %21 %28 %113 
					                                         f32 %148 = OpLoad %147 
					                                         f32 %149 = OpFMul %146 %148 
					                                Private f32* %150 = OpAccessChain %9 %113 
					                                                      OpStore %150 %149 
					                                Private f32* %151 = OpAccessChain %9 %113 
					                                         f32 %152 = OpLoad %151 
					                                         f32 %154 = OpFMul %152 %153 
					                                Private f32* %155 = OpAccessChain %9 %131 
					                                                      OpStore %155 %154 
					                                       f32_4 %156 = OpLoad %49 
					                                       f32_2 %157 = OpVectorShuffle %156 %156 0 3 
					                                       f32_2 %159 = OpFMul %157 %158 
					                                       f32_4 %160 = OpLoad %9 
					                                       f32_4 %161 = OpVectorShuffle %160 %159 4 1 5 3 
					                                                      OpStore %9 %161 
					                                Private f32* %162 = OpAccessChain %49 %131 
					                                         f32 %163 = OpLoad %162 
					                                 Output f32* %164 = OpAccessChain %139 %131 
					                                                      OpStore %164 %163 
					                                       f32_4 %165 = OpLoad %9 
					                                       f32_2 %166 = OpVectorShuffle %165 %165 2 2 
					                                       f32_4 %167 = OpLoad %9 
					                                       f32_2 %168 = OpVectorShuffle %167 %167 0 3 
					                                       f32_2 %169 = OpFAdd %166 %168 
					                                       f32_4 %170 = OpLoad %139 
					                                       f32_4 %171 = OpVectorShuffle %170 %169 4 5 2 3 
					                                                      OpStore %139 %171 
					                                 Output f32* %172 = OpAccessChain %80 %28 %76 
					                                         f32 %173 = OpLoad %172 
					                                         f32 %174 = OpFNegate %173 
					                                 Output f32* %175 = OpAccessChain %80 %28 %76 
					                                                      OpStore %175 %174 
					                                                      OpReturn
					                                                      OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 1
					; Bound: 172
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Fragment %4 "main" %12 %74 %83 %155 
					                                                      OpExecutionMode %4 OriginUpperLeft 
					                                                      OpDecorate %12 Location 12 
					                                                      OpDecorate %21 DescriptorSet 21 
					                                                      OpDecorate %21 Binding 21 
					                                                      OpMemberDecorate %30 0 Offset 30 
					                                                      OpMemberDecorate %30 1 RelaxedPrecision 
					                                                      OpMemberDecorate %30 1 Offset 30 
					                                                      OpMemberDecorate %30 2 RelaxedPrecision 
					                                                      OpMemberDecorate %30 2 Offset 30 
					                                                      OpMemberDecorate %30 3 Offset 30 
					                                                      OpMemberDecorate %30 4 Offset 30 
					                                                      OpMemberDecorate %30 5 Offset 30 
					                                                      OpMemberDecorate %30 6 Offset 30 
					                                                      OpDecorate %30 Block 
					                                                      OpDecorate %32 DescriptorSet 32 
					                                                      OpDecorate %32 Binding 32 
					                                                      OpDecorate %74 RelaxedPrecision 
					                                                      OpDecorate %74 Location 74 
					                                                      OpDecorate %76 RelaxedPrecision 
					                                                      OpDecorate %79 RelaxedPrecision 
					                                                      OpDecorate %80 RelaxedPrecision 
					                                                      OpDecorate %80 DescriptorSet 80 
					                                                      OpDecorate %80 Binding 80 
					                                                      OpDecorate %81 RelaxedPrecision 
					                                                      OpDecorate %83 Location 83 
					                                                      OpDecorate %86 RelaxedPrecision 
					                                                      OpDecorate %88 RelaxedPrecision 
					                                                      OpDecorate %89 RelaxedPrecision 
					                                                      OpDecorate %90 RelaxedPrecision 
					                                                      OpDecorate %94 RelaxedPrecision 
					                                                      OpDecorate %95 RelaxedPrecision 
					                                                      OpDecorate %96 RelaxedPrecision 
					                                                      OpDecorate %97 RelaxedPrecision 
					                                                      OpDecorate %98 RelaxedPrecision 
					                                                      OpDecorate %101 RelaxedPrecision 
					                                                      OpDecorate %102 RelaxedPrecision 
					                                                      OpDecorate %104 RelaxedPrecision 
					                                                      OpDecorate %114 RelaxedPrecision 
					                                                      OpDecorate %115 RelaxedPrecision 
					                                                      OpDecorate %116 RelaxedPrecision 
					                                                      OpDecorate %117 RelaxedPrecision 
					                                                      OpDecorate %118 RelaxedPrecision 
					                                                      OpDecorate %119 RelaxedPrecision 
					                                                      OpDecorate %120 RelaxedPrecision 
					                                                      OpDecorate %121 RelaxedPrecision 
					                                                      OpDecorate %131 RelaxedPrecision 
					                                                      OpDecorate %132 RelaxedPrecision 
					                                                      OpDecorate %133 RelaxedPrecision 
					                                                      OpDecorate %134 RelaxedPrecision 
					                                                      OpDecorate %135 RelaxedPrecision 
					                                                      OpDecorate %136 RelaxedPrecision 
					                                                      OpDecorate %137 RelaxedPrecision 
					                                                      OpDecorate %150 RelaxedPrecision 
					                                                      OpDecorate %153 RelaxedPrecision 
					                                                      OpDecorate %155 RelaxedPrecision 
					                                                      OpDecorate %155 Location 155 
					                                                      OpDecorate %159 RelaxedPrecision 
					                                                      OpDecorate %164 RelaxedPrecision 
					                                                      OpDecorate %165 RelaxedPrecision 
					                                                      OpDecorate %166 RelaxedPrecision 
					                                                      OpDecorate %167 RelaxedPrecision 
					                                                      OpDecorate %168 RelaxedPrecision 
					                                               %2 = OpTypeVoid 
					                                               %3 = OpTypeFunction %2 
					                                               %6 = OpTypeFloat 32 
					                                               %7 = OpTypeVector %6 2 
					                                               %8 = OpTypePointer Private %7 
					                                Private f32_2* %9 = OpVariable Private 
					                                              %10 = OpTypeVector %6 4 
					                                              %11 = OpTypePointer Input %10 
					                                 Input f32_4* %12 = OpVariable Input 
					                                              %18 = OpTypeImage %6 Dim2D 0 0 0 1 Unknown 
					                                              %19 = OpTypeSampledImage %18 
					                                              %20 = OpTypePointer UniformConstant %19 
					  UniformConstant read_only Texture2DSampled* %21 = OpVariable UniformConstant 
					                                              %25 = OpTypeInt 32 0 
					                                          u32 %26 = OpConstant 0 
					                                              %28 = OpTypePointer Private %6 
					                                              %30 = OpTypeStruct %10 %10 %10 %6 %6 %6 %6 
					                                              %31 = OpTypePointer Uniform %30 
					Uniform struct {f32_4; f32_4; f32_4; f32; f32; f32; f32;}* %32 = OpVariable Uniform 
					                                              %33 = OpTypeInt 32 1 
					                                          i32 %34 = OpConstant 0 
					                                          u32 %35 = OpConstant 2 
					                                              %36 = OpTypePointer Uniform %6 
					                                          u32 %42 = OpConstant 3 
					                                          f32 %47 = OpConstant 3.674022E-40 
					                                              %54 = OpTypePointer Input %6 
					                                          i32 %62 = OpConstant 6 
					                                          f32 %69 = OpConstant 3.674022E-40 
					                                 Input f32_4* %74 = OpVariable Input 
					                               Private f32_2* %79 = OpVariable Private 
					  UniformConstant read_only Texture2DSampled* %80 = OpVariable UniformConstant 
					                                              %82 = OpTypePointer Input %7 
					                                 Input f32_2* %83 = OpVariable Input 
					                                              %87 = OpTypePointer Private %10 
					                               Private f32_4* %88 = OpVariable Private 
					                                          i32 %91 = OpConstant 2 
					                                              %92 = OpTypePointer Uniform %10 
					                               Private f32_4* %96 = OpVariable Private 
					                                          i32 %99 = OpConstant 1 
					                              Private f32_4* %103 = OpVariable Private 
					                                         i32 %105 = OpConstant 5 
					                                         i32 %122 = OpConstant 4 
					                                         i32 %141 = OpConstant 3 
					                                       f32_4 %148 = OpConstantComposite %69 %69 %69 %69 
					                                         f32 %151 = OpConstant 3.674022E-40 
					                                       f32_4 %152 = OpConstantComposite %151 %151 %151 %151 
					                                             %154 = OpTypePointer Output %10 
					                               Output f32_4* %155 = OpVariable Output 
					                                             %161 = OpTypePointer Output %6 
					                                             %163 = OpTypeVector %6 3 
					                                          void %4 = OpFunction None %3 
					                                               %5 = OpLabel 
					                                        f32_4 %13 = OpLoad %12 
					                                        f32_2 %14 = OpVectorShuffle %13 %13 0 1 
					                                        f32_4 %15 = OpLoad %12 
					                                        f32_2 %16 = OpVectorShuffle %15 %15 3 3 
					                                        f32_2 %17 = OpFDiv %14 %16 
					                                                      OpStore %9 %17 
					                   read_only Texture2DSampled %22 = OpLoad %21 
					                                        f32_2 %23 = OpLoad %9 
					                                        f32_4 %24 = OpImageSampleImplicitLod %22 %23 
					                                          f32 %27 = OpCompositeExtract %24 0 
					                                 Private f32* %29 = OpAccessChain %9 %26 
					                                                      OpStore %29 %27 
					                                 Uniform f32* %37 = OpAccessChain %32 %34 %35 
					                                          f32 %38 = OpLoad %37 
					                                 Private f32* %39 = OpAccessChain %9 %26 
					                                          f32 %40 = OpLoad %39 
					                                          f32 %41 = OpFMul %38 %40 
					                                 Uniform f32* %43 = OpAccessChain %32 %34 %42 
					                                          f32 %44 = OpLoad %43 
					                                          f32 %45 = OpFAdd %41 %44 
					                                 Private f32* %46 = OpAccessChain %9 %26 
					                                                      OpStore %46 %45 
					                                 Private f32* %48 = OpAccessChain %9 %26 
					                                          f32 %49 = OpLoad %48 
					                                          f32 %50 = OpFDiv %47 %49 
					                                 Private f32* %51 = OpAccessChain %9 %26 
					                                                      OpStore %51 %50 
					                                 Private f32* %52 = OpAccessChain %9 %26 
					                                          f32 %53 = OpLoad %52 
					                                   Input f32* %55 = OpAccessChain %12 %35 
					                                          f32 %56 = OpLoad %55 
					                                          f32 %57 = OpFNegate %56 
					                                          f32 %58 = OpFAdd %53 %57 
					                                 Private f32* %59 = OpAccessChain %9 %26 
					                                                      OpStore %59 %58 
					                                 Private f32* %60 = OpAccessChain %9 %26 
					                                          f32 %61 = OpLoad %60 
					                                 Uniform f32* %63 = OpAccessChain %32 %62 
					                                          f32 %64 = OpLoad %63 
					                                          f32 %65 = OpFMul %61 %64 
					                                 Private f32* %66 = OpAccessChain %9 %26 
					                                                      OpStore %66 %65 
					                                 Private f32* %67 = OpAccessChain %9 %26 
					                                          f32 %68 = OpLoad %67 
					                                          f32 %70 = OpExtInst %1 43 %68 %69 %47 
					                                 Private f32* %71 = OpAccessChain %9 %26 
					                                                      OpStore %71 %70 
					                                 Private f32* %72 = OpAccessChain %9 %26 
					                                          f32 %73 = OpLoad %72 
					                                   Input f32* %75 = OpAccessChain %74 %42 
					                                          f32 %76 = OpLoad %75 
					                                          f32 %77 = OpFMul %73 %76 
					                                 Private f32* %78 = OpAccessChain %9 %26 
					                                                      OpStore %78 %77 
					                   read_only Texture2DSampled %81 = OpLoad %80 
					                                        f32_2 %84 = OpLoad %83 
					                                        f32_4 %85 = OpImageSampleImplicitLod %81 %84 
					                                        f32_2 %86 = OpVectorShuffle %85 %85 0 1 
					                                                      OpStore %79 %86 
					                                        f32_2 %89 = OpLoad %79 
					                                        f32_4 %90 = OpVectorShuffle %89 %89 0 0 0 0 
					                               Uniform f32_4* %93 = OpAccessChain %32 %91 
					                                        f32_4 %94 = OpLoad %93 
					                                        f32_4 %95 = OpFMul %90 %94 
					                                                      OpStore %88 %95 
					                                        f32_2 %97 = OpLoad %79 
					                                        f32_4 %98 = OpVectorShuffle %97 %97 1 1 1 1 
					                              Uniform f32_4* %100 = OpAccessChain %32 %99 
					                                       f32_4 %101 = OpLoad %100 
					                                       f32_4 %102 = OpFMul %98 %101 
					                                                      OpStore %96 %102 
					                                       f32_4 %104 = OpLoad %88 
					                                Uniform f32* %106 = OpAccessChain %32 %105 
					                                         f32 %107 = OpLoad %106 
					                                Uniform f32* %108 = OpAccessChain %32 %105 
					                                         f32 %109 = OpLoad %108 
					                                Uniform f32* %110 = OpAccessChain %32 %105 
					                                         f32 %111 = OpLoad %110 
					                                Uniform f32* %112 = OpAccessChain %32 %105 
					                                         f32 %113 = OpLoad %112 
					                                       f32_4 %114 = OpCompositeConstruct %107 %109 %111 %113 
					                                         f32 %115 = OpCompositeExtract %114 0 
					                                         f32 %116 = OpCompositeExtract %114 1 
					                                         f32 %117 = OpCompositeExtract %114 2 
					                                         f32 %118 = OpCompositeExtract %114 3 
					                                       f32_4 %119 = OpCompositeConstruct %115 %116 %117 %118 
					                                       f32_4 %120 = OpFMul %104 %119 
					                                                      OpStore %103 %120 
					                                       f32_4 %121 = OpLoad %96 
					                                Uniform f32* %123 = OpAccessChain %32 %122 
					                                         f32 %124 = OpLoad %123 
					                                Uniform f32* %125 = OpAccessChain %32 %122 
					                                         f32 %126 = OpLoad %125 
					                                Uniform f32* %127 = OpAccessChain %32 %122 
					                                         f32 %128 = OpLoad %127 
					                                Uniform f32* %129 = OpAccessChain %32 %122 
					                                         f32 %130 = OpLoad %129 
					                                       f32_4 %131 = OpCompositeConstruct %124 %126 %128 %130 
					                                         f32 %132 = OpCompositeExtract %131 0 
					                                         f32 %133 = OpCompositeExtract %131 1 
					                                         f32 %134 = OpCompositeExtract %131 2 
					                                         f32 %135 = OpCompositeExtract %131 3 
					                                       f32_4 %136 = OpCompositeConstruct %132 %133 %134 %135 
					                                       f32_4 %137 = OpFMul %121 %136 
					                                       f32_4 %138 = OpLoad %103 
					                                       f32_4 %139 = OpFAdd %137 %138 
					                                                      OpStore %103 %139 
					                                       f32_4 %140 = OpLoad %103 
					                                Uniform f32* %142 = OpAccessChain %32 %141 
					                                         f32 %143 = OpLoad %142 
					                                       f32_4 %144 = OpCompositeConstruct %143 %143 %143 %143 
					                                       f32_4 %145 = OpFNegate %144 
					                                       f32_4 %146 = OpFAdd %140 %145 
					                                                      OpStore %103 %146 
					                                       f32_4 %147 = OpLoad %103 
					                                       f32_4 %149 = OpExtInst %1 40 %147 %148 
					                                                      OpStore %88 %149 
					                                       f32_4 %150 = OpLoad %88 
					                                       f32_4 %153 = OpExtInst %1 37 %150 %152 
					                                                      OpStore %88 %153 
					                                Private f32* %156 = OpAccessChain %9 %26 
					                                         f32 %157 = OpLoad %156 
					                                Private f32* %158 = OpAccessChain %88 %42 
					                                         f32 %159 = OpLoad %158 
					                                         f32 %160 = OpFMul %157 %159 
					                                 Output f32* %162 = OpAccessChain %155 %42 
					                                                      OpStore %162 %160 
					                                       f32_4 %164 = OpLoad %88 
					                                       f32_3 %165 = OpVectorShuffle %164 %164 0 1 2 
					                                       f32_4 %166 = OpLoad %74 
					                                       f32_3 %167 = OpVectorShuffle %166 %166 0 1 2 
					                                       f32_3 %168 = OpFMul %165 %167 
					                                       f32_4 %169 = OpLoad %155 
					                                       f32_4 %170 = OpVectorShuffle %169 %168 4 5 6 3 
					                                                      OpStore %155 %170 
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
}
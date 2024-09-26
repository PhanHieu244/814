Shader "Effects/GlowAdditiveSimple" {
	Properties {
		_TintColor ("Tint Color", Vector) = (0.5,0.5,0.5,0.5)
		_CoreColor ("Core Color", Vector) = (0.5,0.5,0.5,0.5)
		_MainTex ("Particle Texture", 2D) = "white" {}
		_TintStrength ("Tint Color Strength", Float) = 1
		_CoreStrength ("Core Color Strength", Float) = 1
		_CutOutLightCore ("CutOut Light Core", Range(0, 1)) = 0.5
	}
	SubShader {
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha One, SrcAlpha One
			ZClip Off
			ZWrite Off
			Cull Off
			GpuProgramID 47623
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
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1.w = 1.0;
					  tmpvar_1.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
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
					  tmpvar_4 = clamp (col_1, vec4(0.0, 0.0, 0.0, 0.0), vec4(255.0, 255.0, 255.0, 255.0));
					  gl_FragData[0] = tmpvar_4;
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
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1.w = 1.0;
					  tmpvar_1.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
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
					  tmpvar_4 = clamp (col_1, vec4(0.0, 0.0, 0.0, 0.0), vec4(255.0, 255.0, 255.0, 255.0));
					  gl_FragData[0] = tmpvar_4;
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
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1.w = 1.0;
					  tmpvar_1.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
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
					  tmpvar_4 = clamp (col_1, vec4(0.0, 0.0, 0.0, 0.0), vec4(255.0, 255.0, 255.0, 255.0));
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
					in highp vec2 in_TEXCOORD0;
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
					    SV_Target0 = min(u_xlat16_0, vec4(255.0, 255.0, 255.0, 255.0));
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
					in highp vec2 in_TEXCOORD0;
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
					    SV_Target0 = min(u_xlat16_0, vec4(255.0, 255.0, 255.0, 255.0));
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
					in highp vec2 in_TEXCOORD0;
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
					    SV_Target0 = min(u_xlat16_0, vec4(255.0, 255.0, 255.0, 255.0));
					    return;
					}
					
					#endif"
				}
				SubProgram "vulkan hw_tier00 " {
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 1
					; Bound: 102
					; Schema: 0
					                                                     OpCapability Shader 
					                                              %1 = OpExtInstImport "GLSL.std.450" 
					                                                     OpMemoryModel Logical GLSL450 
					                                                     OpEntryPoint Vertex %4 "main" %11 %72 %84 %86 
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
					                                                     OpDecorate %84 Location 84 
					                                                     OpDecorate %86 Location 86 
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
					                                             %82 = OpTypeVector %6 2 
					                                             %83 = OpTypePointer Output %82 
					                               Output f32_2* %84 = OpVariable Output 
					                                             %85 = OpTypePointer Input %82 
					                                Input f32_2* %86 = OpVariable Input 
					                                             %96 = OpTypePointer Output %6 
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
					                                       f32_2 %87 = OpLoad %86 
					                              Uniform f32_4* %88 = OpAccessChain %20 %35 
					                                       f32_4 %89 = OpLoad %88 
					                                       f32_2 %90 = OpVectorShuffle %89 %89 0 1 
					                                       f32_2 %91 = OpFMul %87 %90 
					                              Uniform f32_4* %92 = OpAccessChain %20 %35 
					                                       f32_4 %93 = OpLoad %92 
					                                       f32_2 %94 = OpVectorShuffle %93 %93 2 3 
					                                       f32_2 %95 = OpFAdd %91 %94 
					                                                     OpStore %84 %95 
					                                 Output f32* %97 = OpAccessChain %72 %22 %68 
					                                         f32 %98 = OpLoad %97 
					                                         f32 %99 = OpFNegate %98 
					                                Output f32* %100 = OpAccessChain %72 %22 %68 
					                                                     OpStore %100 %99 
					                                                     OpReturn
					                                                     OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 1
					; Bound: 98
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Fragment %4 "main" %16 %92 
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
					                                                      OpDecorate %92 RelaxedPrecision 
					                                                      OpDecorate %92 Location 92 
					                                                      OpDecorate %93 RelaxedPrecision 
					                                                      OpDecorate %96 RelaxedPrecision 
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
					                                              %91 = OpTypePointer Output %18 
					                                Output f32_4* %92 = OpVariable Output 
					                                          f32 %94 = OpConstant 3.674022E-40 
					                                        f32_4 %95 = OpConstantComposite %94 %94 %94 %94 
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
					                                        f32_4 %93 = OpLoad %34 
					                                        f32_4 %96 = OpExtInst %1 37 %93 %95 
					                                                      OpStore %92 %96 
					                                                      OpReturn
					                                                      OpFunctionEnd"
				}
				SubProgram "vulkan hw_tier01 " {
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 1
					; Bound: 102
					; Schema: 0
					                                                     OpCapability Shader 
					                                              %1 = OpExtInstImport "GLSL.std.450" 
					                                                     OpMemoryModel Logical GLSL450 
					                                                     OpEntryPoint Vertex %4 "main" %11 %72 %84 %86 
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
					                                                     OpDecorate %84 Location 84 
					                                                     OpDecorate %86 Location 86 
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
					                                             %82 = OpTypeVector %6 2 
					                                             %83 = OpTypePointer Output %82 
					                               Output f32_2* %84 = OpVariable Output 
					                                             %85 = OpTypePointer Input %82 
					                                Input f32_2* %86 = OpVariable Input 
					                                             %96 = OpTypePointer Output %6 
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
					                                       f32_2 %87 = OpLoad %86 
					                              Uniform f32_4* %88 = OpAccessChain %20 %35 
					                                       f32_4 %89 = OpLoad %88 
					                                       f32_2 %90 = OpVectorShuffle %89 %89 0 1 
					                                       f32_2 %91 = OpFMul %87 %90 
					                              Uniform f32_4* %92 = OpAccessChain %20 %35 
					                                       f32_4 %93 = OpLoad %92 
					                                       f32_2 %94 = OpVectorShuffle %93 %93 2 3 
					                                       f32_2 %95 = OpFAdd %91 %94 
					                                                     OpStore %84 %95 
					                                 Output f32* %97 = OpAccessChain %72 %22 %68 
					                                         f32 %98 = OpLoad %97 
					                                         f32 %99 = OpFNegate %98 
					                                Output f32* %100 = OpAccessChain %72 %22 %68 
					                                                     OpStore %100 %99 
					                                                     OpReturn
					                                                     OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 1
					; Bound: 98
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Fragment %4 "main" %16 %92 
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
					                                                      OpDecorate %92 RelaxedPrecision 
					                                                      OpDecorate %92 Location 92 
					                                                      OpDecorate %93 RelaxedPrecision 
					                                                      OpDecorate %96 RelaxedPrecision 
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
					                                              %91 = OpTypePointer Output %18 
					                                Output f32_4* %92 = OpVariable Output 
					                                          f32 %94 = OpConstant 3.674022E-40 
					                                        f32_4 %95 = OpConstantComposite %94 %94 %94 %94 
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
					                                        f32_4 %93 = OpLoad %34 
					                                        f32_4 %96 = OpExtInst %1 37 %93 %95 
					                                                      OpStore %92 %96 
					                                                      OpReturn
					                                                      OpFunctionEnd"
				}
				SubProgram "vulkan hw_tier02 " {
					"spirv
					
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 1
					; Bound: 102
					; Schema: 0
					                                                     OpCapability Shader 
					                                              %1 = OpExtInstImport "GLSL.std.450" 
					                                                     OpMemoryModel Logical GLSL450 
					                                                     OpEntryPoint Vertex %4 "main" %11 %72 %84 %86 
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
					                                                     OpDecorate %84 Location 84 
					                                                     OpDecorate %86 Location 86 
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
					                                             %82 = OpTypeVector %6 2 
					                                             %83 = OpTypePointer Output %82 
					                               Output f32_2* %84 = OpVariable Output 
					                                             %85 = OpTypePointer Input %82 
					                                Input f32_2* %86 = OpVariable Input 
					                                             %96 = OpTypePointer Output %6 
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
					                                       f32_2 %87 = OpLoad %86 
					                              Uniform f32_4* %88 = OpAccessChain %20 %35 
					                                       f32_4 %89 = OpLoad %88 
					                                       f32_2 %90 = OpVectorShuffle %89 %89 0 1 
					                                       f32_2 %91 = OpFMul %87 %90 
					                              Uniform f32_4* %92 = OpAccessChain %20 %35 
					                                       f32_4 %93 = OpLoad %92 
					                                       f32_2 %94 = OpVectorShuffle %93 %93 2 3 
					                                       f32_2 %95 = OpFAdd %91 %94 
					                                                     OpStore %84 %95 
					                                 Output f32* %97 = OpAccessChain %72 %22 %68 
					                                         f32 %98 = OpLoad %97 
					                                         f32 %99 = OpFNegate %98 
					                                Output f32* %100 = OpAccessChain %72 %22 %68 
					                                                     OpStore %100 %99 
					                                                     OpReturn
					                                                     OpFunctionEnd
					; SPIR-V
					; Version: 1.0
					; Generator: Khronos Glslang Reference Front End; 1
					; Bound: 98
					; Schema: 0
					                                                      OpCapability Shader 
					                                               %1 = OpExtInstImport "GLSL.std.450" 
					                                                      OpMemoryModel Logical GLSL450 
					                                                      OpEntryPoint Fragment %4 "main" %16 %92 
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
					                                                      OpDecorate %92 RelaxedPrecision 
					                                                      OpDecorate %92 Location 92 
					                                                      OpDecorate %93 RelaxedPrecision 
					                                                      OpDecorate %96 RelaxedPrecision 
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
					                                              %91 = OpTypePointer Output %18 
					                                Output f32_4* %92 = OpVariable Output 
					                                          f32 %94 = OpConstant 3.674022E-40 
					                                        f32_4 %95 = OpConstantComposite %94 %94 %94 %94 
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
					                                        f32_4 %93 = OpLoad %34 
					                                        f32_4 %96 = OpExtInst %1 37 %93 %95 
					                                                      OpStore %92 %96 
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
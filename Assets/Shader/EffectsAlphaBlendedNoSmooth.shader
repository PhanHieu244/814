Shader "Effects/AlphaBlendedNoSmooth" {
	Properties {
		_TintColor ("Tint Color", Vector) = (0.5,0.5,0.5,1)
		_ColorStrength ("Color strength", Float) = 1
		_MainTex ("Particle Texture", 2D) = "white" {}
	}
	SubShader {
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZClip Off
			ZWrite Off
			Cull Off
			GpuProgramID 21110
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
					uniform lowp float _ColorStrength;
					varying lowp vec4 xlv_COLOR;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 res_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = ((2.0 * xlv_COLOR) * ((texture2D (_MainTex, xlv_TEXCOORD0) * _TintColor) * _ColorStrength));
					  res_1.xyz = tmpvar_2.xyz;
					  res_1.w = clamp (tmpvar_2.w, 0.0, 1.0);
					  gl_FragData[0] = res_1;
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
					uniform lowp float _ColorStrength;
					varying lowp vec4 xlv_COLOR;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 res_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = ((2.0 * xlv_COLOR) * ((texture2D (_MainTex, xlv_TEXCOORD0) * _TintColor) * _ColorStrength));
					  res_1.xyz = tmpvar_2.xyz;
					  res_1.w = clamp (tmpvar_2.w, 0.0, 1.0);
					  gl_FragData[0] = res_1;
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
					uniform lowp float _ColorStrength;
					varying lowp vec4 xlv_COLOR;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 res_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = ((2.0 * xlv_COLOR) * ((texture2D (_MainTex, xlv_TEXCOORD0) * _TintColor) * _ColorStrength));
					  res_1.xyz = tmpvar_2.xyz;
					  res_1.w = clamp (tmpvar_2.w, 0.0, 1.0);
					  gl_FragData[0] = res_1;
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
					uniform 	mediump float _ColorStrength;
					uniform lowp sampler2D _MainTex;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					mediump vec4 u_xlat16_1;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_1 = vs_COLOR0 + vs_COLOR0;
					    u_xlat16_0 = u_xlat10_0 * u_xlat16_1;
					    u_xlat16_0 = u_xlat16_0 * _TintColor;
					    u_xlat16_0 = u_xlat16_0 * vec4(_ColorStrength);
					    SV_Target0.w = u_xlat16_0.w;
					#ifdef UNITY_ADRENO_ES3
					    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
					#else
					    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
					#endif
					    SV_Target0.xyz = u_xlat16_0.xyz;
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
					uniform 	mediump float _ColorStrength;
					uniform lowp sampler2D _MainTex;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					mediump vec4 u_xlat16_1;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_1 = vs_COLOR0 + vs_COLOR0;
					    u_xlat16_0 = u_xlat10_0 * u_xlat16_1;
					    u_xlat16_0 = u_xlat16_0 * _TintColor;
					    u_xlat16_0 = u_xlat16_0 * vec4(_ColorStrength);
					    SV_Target0.w = u_xlat16_0.w;
					#ifdef UNITY_ADRENO_ES3
					    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
					#else
					    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
					#endif
					    SV_Target0.xyz = u_xlat16_0.xyz;
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
					uniform 	mediump float _ColorStrength;
					uniform lowp sampler2D _MainTex;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					mediump vec4 u_xlat16_1;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_1 = vs_COLOR0 + vs_COLOR0;
					    u_xlat16_0 = u_xlat10_0 * u_xlat16_1;
					    u_xlat16_0 = u_xlat16_0 * _TintColor;
					    u_xlat16_0 = u_xlat16_0 * vec4(_ColorStrength);
					    SV_Target0.w = u_xlat16_0.w;
					#ifdef UNITY_ADRENO_ES3
					    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
					#else
					    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
					#endif
					    SV_Target0.xyz = u_xlat16_0.xyz;
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
					; Bound: 68
					; Schema: 0
					                                                    OpCapability Shader 
					                                             %1 = OpExtInstImport "GLSL.std.450" 
					                                                    OpMemoryModel Logical GLSL450 
					                                                    OpEntryPoint Fragment %4 "main" %17 %22 %48 
					                                                    OpExecutionMode %4 OriginUpperLeft 
					                                                    OpDecorate %9 RelaxedPrecision 
					                                                    OpDecorate %13 RelaxedPrecision 
					                                                    OpDecorate %13 DescriptorSet 13 
					                                                    OpDecorate %13 Binding 13 
					                                                    OpDecorate %14 RelaxedPrecision 
					                                                    OpDecorate %17 Location 17 
					                                                    OpDecorate %20 RelaxedPrecision 
					                                                    OpDecorate %22 RelaxedPrecision 
					                                                    OpDecorate %22 Location 22 
					                                                    OpDecorate %23 RelaxedPrecision 
					                                                    OpDecorate %24 RelaxedPrecision 
					                                                    OpDecorate %25 RelaxedPrecision 
					                                                    OpDecorate %26 RelaxedPrecision 
					                                                    OpDecorate %27 RelaxedPrecision 
					                                                    OpDecorate %28 RelaxedPrecision 
					                                                    OpDecorate %29 RelaxedPrecision 
					                                                    OpDecorate %30 RelaxedPrecision 
					                                                    OpMemberDecorate %31 0 RelaxedPrecision 
					                                                    OpMemberDecorate %31 0 Offset 31 
					                                                    OpMemberDecorate %31 1 RelaxedPrecision 
					                                                    OpMemberDecorate %31 1 Offset 31 
					                                                    OpDecorate %31 Block 
					                                                    OpDecorate %33 DescriptorSet 33 
					                                                    OpDecorate %33 Binding 33 
					                                                    OpDecorate %38 RelaxedPrecision 
					                                                    OpDecorate %39 RelaxedPrecision 
					                                                    OpDecorate %40 RelaxedPrecision 
					                                                    OpDecorate %44 RelaxedPrecision 
					                                                    OpDecorate %45 RelaxedPrecision 
					                                                    OpDecorate %46 RelaxedPrecision 
					                                                    OpDecorate %48 RelaxedPrecision 
					                                                    OpDecorate %48 Location 48 
					                                                    OpDecorate %53 RelaxedPrecision 
					                                                    OpDecorate %57 RelaxedPrecision 
					                                                    OpDecorate %60 RelaxedPrecision 
					                                                    OpDecorate %63 RelaxedPrecision 
					                                                    OpDecorate %64 RelaxedPrecision 
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
					                             Private f32_4* %20 = OpVariable Private 
					                                            %21 = OpTypePointer Input %7 
					                               Input f32_4* %22 = OpVariable Input 
					                             Private f32_4* %26 = OpVariable Private 
					                                            %31 = OpTypeStruct %7 %6 
					                                            %32 = OpTypePointer Uniform %31 
					              Uniform struct {f32_4; f32;}* %33 = OpVariable Uniform 
					                                            %34 = OpTypeInt 32 1 
					                                        i32 %35 = OpConstant 0 
					                                            %36 = OpTypePointer Uniform %7 
					                                        i32 %41 = OpConstant 1 
					                                            %42 = OpTypePointer Uniform %6 
					                                            %47 = OpTypePointer Output %7 
					                              Output f32_4* %48 = OpVariable Output 
					                                            %49 = OpTypeInt 32 0 
					                                        u32 %50 = OpConstant 3 
					                                            %51 = OpTypePointer Private %6 
					                                            %54 = OpTypePointer Output %6 
					                                        f32 %58 = OpConstant 3.674022E-40 
					                                        f32 %59 = OpConstant 3.674022E-40 
					                                            %62 = OpTypeVector %6 3 
					                                        void %4 = OpFunction None %3 
					                                             %5 = OpLabel 
					                 read_only Texture2DSampled %14 = OpLoad %13 
					                                      f32_2 %18 = OpLoad %17 
					                                      f32_4 %19 = OpImageSampleImplicitLod %14 %18 
					                                                    OpStore %9 %19 
					                                      f32_4 %23 = OpLoad %22 
					                                      f32_4 %24 = OpLoad %22 
					                                      f32_4 %25 = OpFAdd %23 %24 
					                                                    OpStore %20 %25 
					                                      f32_4 %27 = OpLoad %9 
					                                      f32_4 %28 = OpLoad %20 
					                                      f32_4 %29 = OpFMul %27 %28 
					                                                    OpStore %26 %29 
					                                      f32_4 %30 = OpLoad %26 
					                             Uniform f32_4* %37 = OpAccessChain %33 %35 
					                                      f32_4 %38 = OpLoad %37 
					                                      f32_4 %39 = OpFMul %30 %38 
					                                                    OpStore %26 %39 
					                                      f32_4 %40 = OpLoad %26 
					                               Uniform f32* %43 = OpAccessChain %33 %41 
					                                        f32 %44 = OpLoad %43 
					                                      f32_4 %45 = OpCompositeConstruct %44 %44 %44 %44 
					                                      f32_4 %46 = OpFMul %40 %45 
					                                                    OpStore %26 %46 
					                               Private f32* %52 = OpAccessChain %26 %50 
					                                        f32 %53 = OpLoad %52 
					                                Output f32* %55 = OpAccessChain %48 %50 
					                                                    OpStore %55 %53 
					                                Output f32* %56 = OpAccessChain %48 %50 
					                                        f32 %57 = OpLoad %56 
					                                        f32 %60 = OpExtInst %1 43 %57 %58 %59 
					                                Output f32* %61 = OpAccessChain %48 %50 
					                                                    OpStore %61 %60 
					                                      f32_4 %63 = OpLoad %26 
					                                      f32_3 %64 = OpVectorShuffle %63 %63 0 1 2 
					                                      f32_4 %65 = OpLoad %48 
					                                      f32_4 %66 = OpVectorShuffle %65 %64 4 5 6 3 
					                                                    OpStore %48 %66 
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
					; Bound: 68
					; Schema: 0
					                                                    OpCapability Shader 
					                                             %1 = OpExtInstImport "GLSL.std.450" 
					                                                    OpMemoryModel Logical GLSL450 
					                                                    OpEntryPoint Fragment %4 "main" %17 %22 %48 
					                                                    OpExecutionMode %4 OriginUpperLeft 
					                                                    OpDecorate %9 RelaxedPrecision 
					                                                    OpDecorate %13 RelaxedPrecision 
					                                                    OpDecorate %13 DescriptorSet 13 
					                                                    OpDecorate %13 Binding 13 
					                                                    OpDecorate %14 RelaxedPrecision 
					                                                    OpDecorate %17 Location 17 
					                                                    OpDecorate %20 RelaxedPrecision 
					                                                    OpDecorate %22 RelaxedPrecision 
					                                                    OpDecorate %22 Location 22 
					                                                    OpDecorate %23 RelaxedPrecision 
					                                                    OpDecorate %24 RelaxedPrecision 
					                                                    OpDecorate %25 RelaxedPrecision 
					                                                    OpDecorate %26 RelaxedPrecision 
					                                                    OpDecorate %27 RelaxedPrecision 
					                                                    OpDecorate %28 RelaxedPrecision 
					                                                    OpDecorate %29 RelaxedPrecision 
					                                                    OpDecorate %30 RelaxedPrecision 
					                                                    OpMemberDecorate %31 0 RelaxedPrecision 
					                                                    OpMemberDecorate %31 0 Offset 31 
					                                                    OpMemberDecorate %31 1 RelaxedPrecision 
					                                                    OpMemberDecorate %31 1 Offset 31 
					                                                    OpDecorate %31 Block 
					                                                    OpDecorate %33 DescriptorSet 33 
					                                                    OpDecorate %33 Binding 33 
					                                                    OpDecorate %38 RelaxedPrecision 
					                                                    OpDecorate %39 RelaxedPrecision 
					                                                    OpDecorate %40 RelaxedPrecision 
					                                                    OpDecorate %44 RelaxedPrecision 
					                                                    OpDecorate %45 RelaxedPrecision 
					                                                    OpDecorate %46 RelaxedPrecision 
					                                                    OpDecorate %48 RelaxedPrecision 
					                                                    OpDecorate %48 Location 48 
					                                                    OpDecorate %53 RelaxedPrecision 
					                                                    OpDecorate %57 RelaxedPrecision 
					                                                    OpDecorate %60 RelaxedPrecision 
					                                                    OpDecorate %63 RelaxedPrecision 
					                                                    OpDecorate %64 RelaxedPrecision 
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
					                             Private f32_4* %20 = OpVariable Private 
					                                            %21 = OpTypePointer Input %7 
					                               Input f32_4* %22 = OpVariable Input 
					                             Private f32_4* %26 = OpVariable Private 
					                                            %31 = OpTypeStruct %7 %6 
					                                            %32 = OpTypePointer Uniform %31 
					              Uniform struct {f32_4; f32;}* %33 = OpVariable Uniform 
					                                            %34 = OpTypeInt 32 1 
					                                        i32 %35 = OpConstant 0 
					                                            %36 = OpTypePointer Uniform %7 
					                                        i32 %41 = OpConstant 1 
					                                            %42 = OpTypePointer Uniform %6 
					                                            %47 = OpTypePointer Output %7 
					                              Output f32_4* %48 = OpVariable Output 
					                                            %49 = OpTypeInt 32 0 
					                                        u32 %50 = OpConstant 3 
					                                            %51 = OpTypePointer Private %6 
					                                            %54 = OpTypePointer Output %6 
					                                        f32 %58 = OpConstant 3.674022E-40 
					                                        f32 %59 = OpConstant 3.674022E-40 
					                                            %62 = OpTypeVector %6 3 
					                                        void %4 = OpFunction None %3 
					                                             %5 = OpLabel 
					                 read_only Texture2DSampled %14 = OpLoad %13 
					                                      f32_2 %18 = OpLoad %17 
					                                      f32_4 %19 = OpImageSampleImplicitLod %14 %18 
					                                                    OpStore %9 %19 
					                                      f32_4 %23 = OpLoad %22 
					                                      f32_4 %24 = OpLoad %22 
					                                      f32_4 %25 = OpFAdd %23 %24 
					                                                    OpStore %20 %25 
					                                      f32_4 %27 = OpLoad %9 
					                                      f32_4 %28 = OpLoad %20 
					                                      f32_4 %29 = OpFMul %27 %28 
					                                                    OpStore %26 %29 
					                                      f32_4 %30 = OpLoad %26 
					                             Uniform f32_4* %37 = OpAccessChain %33 %35 
					                                      f32_4 %38 = OpLoad %37 
					                                      f32_4 %39 = OpFMul %30 %38 
					                                                    OpStore %26 %39 
					                                      f32_4 %40 = OpLoad %26 
					                               Uniform f32* %43 = OpAccessChain %33 %41 
					                                        f32 %44 = OpLoad %43 
					                                      f32_4 %45 = OpCompositeConstruct %44 %44 %44 %44 
					                                      f32_4 %46 = OpFMul %40 %45 
					                                                    OpStore %26 %46 
					                               Private f32* %52 = OpAccessChain %26 %50 
					                                        f32 %53 = OpLoad %52 
					                                Output f32* %55 = OpAccessChain %48 %50 
					                                                    OpStore %55 %53 
					                                Output f32* %56 = OpAccessChain %48 %50 
					                                        f32 %57 = OpLoad %56 
					                                        f32 %60 = OpExtInst %1 43 %57 %58 %59 
					                                Output f32* %61 = OpAccessChain %48 %50 
					                                                    OpStore %61 %60 
					                                      f32_4 %63 = OpLoad %26 
					                                      f32_3 %64 = OpVectorShuffle %63 %63 0 1 2 
					                                      f32_4 %65 = OpLoad %48 
					                                      f32_4 %66 = OpVectorShuffle %65 %64 4 5 6 3 
					                                                    OpStore %48 %66 
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
					; Bound: 68
					; Schema: 0
					                                                    OpCapability Shader 
					                                             %1 = OpExtInstImport "GLSL.std.450" 
					                                                    OpMemoryModel Logical GLSL450 
					                                                    OpEntryPoint Fragment %4 "main" %17 %22 %48 
					                                                    OpExecutionMode %4 OriginUpperLeft 
					                                                    OpDecorate %9 RelaxedPrecision 
					                                                    OpDecorate %13 RelaxedPrecision 
					                                                    OpDecorate %13 DescriptorSet 13 
					                                                    OpDecorate %13 Binding 13 
					                                                    OpDecorate %14 RelaxedPrecision 
					                                                    OpDecorate %17 Location 17 
					                                                    OpDecorate %20 RelaxedPrecision 
					                                                    OpDecorate %22 RelaxedPrecision 
					                                                    OpDecorate %22 Location 22 
					                                                    OpDecorate %23 RelaxedPrecision 
					                                                    OpDecorate %24 RelaxedPrecision 
					                                                    OpDecorate %25 RelaxedPrecision 
					                                                    OpDecorate %26 RelaxedPrecision 
					                                                    OpDecorate %27 RelaxedPrecision 
					                                                    OpDecorate %28 RelaxedPrecision 
					                                                    OpDecorate %29 RelaxedPrecision 
					                                                    OpDecorate %30 RelaxedPrecision 
					                                                    OpMemberDecorate %31 0 RelaxedPrecision 
					                                                    OpMemberDecorate %31 0 Offset 31 
					                                                    OpMemberDecorate %31 1 RelaxedPrecision 
					                                                    OpMemberDecorate %31 1 Offset 31 
					                                                    OpDecorate %31 Block 
					                                                    OpDecorate %33 DescriptorSet 33 
					                                                    OpDecorate %33 Binding 33 
					                                                    OpDecorate %38 RelaxedPrecision 
					                                                    OpDecorate %39 RelaxedPrecision 
					                                                    OpDecorate %40 RelaxedPrecision 
					                                                    OpDecorate %44 RelaxedPrecision 
					                                                    OpDecorate %45 RelaxedPrecision 
					                                                    OpDecorate %46 RelaxedPrecision 
					                                                    OpDecorate %48 RelaxedPrecision 
					                                                    OpDecorate %48 Location 48 
					                                                    OpDecorate %53 RelaxedPrecision 
					                                                    OpDecorate %57 RelaxedPrecision 
					                                                    OpDecorate %60 RelaxedPrecision 
					                                                    OpDecorate %63 RelaxedPrecision 
					                                                    OpDecorate %64 RelaxedPrecision 
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
					                             Private f32_4* %20 = OpVariable Private 
					                                            %21 = OpTypePointer Input %7 
					                               Input f32_4* %22 = OpVariable Input 
					                             Private f32_4* %26 = OpVariable Private 
					                                            %31 = OpTypeStruct %7 %6 
					                                            %32 = OpTypePointer Uniform %31 
					              Uniform struct {f32_4; f32;}* %33 = OpVariable Uniform 
					                                            %34 = OpTypeInt 32 1 
					                                        i32 %35 = OpConstant 0 
					                                            %36 = OpTypePointer Uniform %7 
					                                        i32 %41 = OpConstant 1 
					                                            %42 = OpTypePointer Uniform %6 
					                                            %47 = OpTypePointer Output %7 
					                              Output f32_4* %48 = OpVariable Output 
					                                            %49 = OpTypeInt 32 0 
					                                        u32 %50 = OpConstant 3 
					                                            %51 = OpTypePointer Private %6 
					                                            %54 = OpTypePointer Output %6 
					                                        f32 %58 = OpConstant 3.674022E-40 
					                                        f32 %59 = OpConstant 3.674022E-40 
					                                            %62 = OpTypeVector %6 3 
					                                        void %4 = OpFunction None %3 
					                                             %5 = OpLabel 
					                 read_only Texture2DSampled %14 = OpLoad %13 
					                                      f32_2 %18 = OpLoad %17 
					                                      f32_4 %19 = OpImageSampleImplicitLod %14 %18 
					                                                    OpStore %9 %19 
					                                      f32_4 %23 = OpLoad %22 
					                                      f32_4 %24 = OpLoad %22 
					                                      f32_4 %25 = OpFAdd %23 %24 
					                                                    OpStore %20 %25 
					                                      f32_4 %27 = OpLoad %9 
					                                      f32_4 %28 = OpLoad %20 
					                                      f32_4 %29 = OpFMul %27 %28 
					                                                    OpStore %26 %29 
					                                      f32_4 %30 = OpLoad %26 
					                             Uniform f32_4* %37 = OpAccessChain %33 %35 
					                                      f32_4 %38 = OpLoad %37 
					                                      f32_4 %39 = OpFMul %30 %38 
					                                                    OpStore %26 %39 
					                                      f32_4 %40 = OpLoad %26 
					                               Uniform f32* %43 = OpAccessChain %33 %41 
					                                        f32 %44 = OpLoad %43 
					                                      f32_4 %45 = OpCompositeConstruct %44 %44 %44 %44 
					                                      f32_4 %46 = OpFMul %40 %45 
					                                                    OpStore %26 %46 
					                               Private f32* %52 = OpAccessChain %26 %50 
					                                        f32 %53 = OpLoad %52 
					                                Output f32* %55 = OpAccessChain %48 %50 
					                                                    OpStore %55 %53 
					                                Output f32* %56 = OpAccessChain %48 %50 
					                                        f32 %57 = OpLoad %56 
					                                        f32 %60 = OpExtInst %1 43 %57 %58 %59 
					                                Output f32* %61 = OpAccessChain %48 %50 
					                                                    OpStore %61 %60 
					                                      f32_4 %63 = OpLoad %26 
					                                      f32_3 %64 = OpVectorShuffle %63 %63 0 1 2 
					                                      f32_4 %65 = OpLoad %48 
					                                      f32_4 %66 = OpVectorShuffle %65 %64 4 5 6 3 
					                                                    OpStore %48 %66 
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
					uniform lowp float _ColorStrength;
					varying lowp vec4 xlv_COLOR;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 res_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = ((2.0 * xlv_COLOR) * ((texture2D (_MainTex, xlv_TEXCOORD0) * _TintColor) * _ColorStrength));
					  res_1.xyz = tmpvar_2.xyz;
					  res_1.w = clamp (tmpvar_2.w, 0.0, 1.0);
					  gl_FragData[0] = res_1;
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
					uniform lowp float _ColorStrength;
					varying lowp vec4 xlv_COLOR;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 res_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = ((2.0 * xlv_COLOR) * ((texture2D (_MainTex, xlv_TEXCOORD0) * _TintColor) * _ColorStrength));
					  res_1.xyz = tmpvar_2.xyz;
					  res_1.w = clamp (tmpvar_2.w, 0.0, 1.0);
					  gl_FragData[0] = res_1;
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
					uniform lowp float _ColorStrength;
					varying lowp vec4 xlv_COLOR;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 res_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = ((2.0 * xlv_COLOR) * ((texture2D (_MainTex, xlv_TEXCOORD0) * _TintColor) * _ColorStrength));
					  res_1.xyz = tmpvar_2.xyz;
					  res_1.w = clamp (tmpvar_2.w, 0.0, 1.0);
					  gl_FragData[0] = res_1;
					}
					
					
					#endif"
				}
				SubProgram "gles3 hw_tier00 " {
					Keywords { "SOFTPARTICLES_ON" }
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
					uniform 	mediump float _ColorStrength;
					uniform lowp sampler2D _MainTex;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					mediump vec4 u_xlat16_1;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_1 = vs_COLOR0 + vs_COLOR0;
					    u_xlat16_0 = u_xlat10_0 * u_xlat16_1;
					    u_xlat16_0 = u_xlat16_0 * _TintColor;
					    u_xlat16_0 = u_xlat16_0 * vec4(_ColorStrength);
					    SV_Target0.w = u_xlat16_0.w;
					#ifdef UNITY_ADRENO_ES3
					    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
					#else
					    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
					#endif
					    SV_Target0.xyz = u_xlat16_0.xyz;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier01 " {
					Keywords { "SOFTPARTICLES_ON" }
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
					uniform 	mediump float _ColorStrength;
					uniform lowp sampler2D _MainTex;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					mediump vec4 u_xlat16_1;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_1 = vs_COLOR0 + vs_COLOR0;
					    u_xlat16_0 = u_xlat10_0 * u_xlat16_1;
					    u_xlat16_0 = u_xlat16_0 * _TintColor;
					    u_xlat16_0 = u_xlat16_0 * vec4(_ColorStrength);
					    SV_Target0.w = u_xlat16_0.w;
					#ifdef UNITY_ADRENO_ES3
					    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
					#else
					    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
					#endif
					    SV_Target0.xyz = u_xlat16_0.xyz;
					    return;
					}
					
					#endif"
				}
				SubProgram "gles3 hw_tier02 " {
					Keywords { "SOFTPARTICLES_ON" }
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
					uniform 	mediump float _ColorStrength;
					uniform lowp sampler2D _MainTex;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					mediump vec4 u_xlat16_1;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_1 = vs_COLOR0 + vs_COLOR0;
					    u_xlat16_0 = u_xlat10_0 * u_xlat16_1;
					    u_xlat16_0 = u_xlat16_0 * _TintColor;
					    u_xlat16_0 = u_xlat16_0 * vec4(_ColorStrength);
					    SV_Target0.w = u_xlat16_0.w;
					#ifdef UNITY_ADRENO_ES3
					    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
					#else
					    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
					#endif
					    SV_Target0.xyz = u_xlat16_0.xyz;
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
					; Bound: 68
					; Schema: 0
					                                                    OpCapability Shader 
					                                             %1 = OpExtInstImport "GLSL.std.450" 
					                                                    OpMemoryModel Logical GLSL450 
					                                                    OpEntryPoint Fragment %4 "main" %17 %22 %48 
					                                                    OpExecutionMode %4 OriginUpperLeft 
					                                                    OpDecorate %9 RelaxedPrecision 
					                                                    OpDecorate %13 RelaxedPrecision 
					                                                    OpDecorate %13 DescriptorSet 13 
					                                                    OpDecorate %13 Binding 13 
					                                                    OpDecorate %14 RelaxedPrecision 
					                                                    OpDecorate %17 Location 17 
					                                                    OpDecorate %20 RelaxedPrecision 
					                                                    OpDecorate %22 RelaxedPrecision 
					                                                    OpDecorate %22 Location 22 
					                                                    OpDecorate %23 RelaxedPrecision 
					                                                    OpDecorate %24 RelaxedPrecision 
					                                                    OpDecorate %25 RelaxedPrecision 
					                                                    OpDecorate %26 RelaxedPrecision 
					                                                    OpDecorate %27 RelaxedPrecision 
					                                                    OpDecorate %28 RelaxedPrecision 
					                                                    OpDecorate %29 RelaxedPrecision 
					                                                    OpDecorate %30 RelaxedPrecision 
					                                                    OpMemberDecorate %31 0 RelaxedPrecision 
					                                                    OpMemberDecorate %31 0 Offset 31 
					                                                    OpMemberDecorate %31 1 RelaxedPrecision 
					                                                    OpMemberDecorate %31 1 Offset 31 
					                                                    OpDecorate %31 Block 
					                                                    OpDecorate %33 DescriptorSet 33 
					                                                    OpDecorate %33 Binding 33 
					                                                    OpDecorate %38 RelaxedPrecision 
					                                                    OpDecorate %39 RelaxedPrecision 
					                                                    OpDecorate %40 RelaxedPrecision 
					                                                    OpDecorate %44 RelaxedPrecision 
					                                                    OpDecorate %45 RelaxedPrecision 
					                                                    OpDecorate %46 RelaxedPrecision 
					                                                    OpDecorate %48 RelaxedPrecision 
					                                                    OpDecorate %48 Location 48 
					                                                    OpDecorate %53 RelaxedPrecision 
					                                                    OpDecorate %57 RelaxedPrecision 
					                                                    OpDecorate %60 RelaxedPrecision 
					                                                    OpDecorate %63 RelaxedPrecision 
					                                                    OpDecorate %64 RelaxedPrecision 
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
					                             Private f32_4* %20 = OpVariable Private 
					                                            %21 = OpTypePointer Input %7 
					                               Input f32_4* %22 = OpVariable Input 
					                             Private f32_4* %26 = OpVariable Private 
					                                            %31 = OpTypeStruct %7 %6 
					                                            %32 = OpTypePointer Uniform %31 
					              Uniform struct {f32_4; f32;}* %33 = OpVariable Uniform 
					                                            %34 = OpTypeInt 32 1 
					                                        i32 %35 = OpConstant 0 
					                                            %36 = OpTypePointer Uniform %7 
					                                        i32 %41 = OpConstant 1 
					                                            %42 = OpTypePointer Uniform %6 
					                                            %47 = OpTypePointer Output %7 
					                              Output f32_4* %48 = OpVariable Output 
					                                            %49 = OpTypeInt 32 0 
					                                        u32 %50 = OpConstant 3 
					                                            %51 = OpTypePointer Private %6 
					                                            %54 = OpTypePointer Output %6 
					                                        f32 %58 = OpConstant 3.674022E-40 
					                                        f32 %59 = OpConstant 3.674022E-40 
					                                            %62 = OpTypeVector %6 3 
					                                        void %4 = OpFunction None %3 
					                                             %5 = OpLabel 
					                 read_only Texture2DSampled %14 = OpLoad %13 
					                                      f32_2 %18 = OpLoad %17 
					                                      f32_4 %19 = OpImageSampleImplicitLod %14 %18 
					                                                    OpStore %9 %19 
					                                      f32_4 %23 = OpLoad %22 
					                                      f32_4 %24 = OpLoad %22 
					                                      f32_4 %25 = OpFAdd %23 %24 
					                                                    OpStore %20 %25 
					                                      f32_4 %27 = OpLoad %9 
					                                      f32_4 %28 = OpLoad %20 
					                                      f32_4 %29 = OpFMul %27 %28 
					                                                    OpStore %26 %29 
					                                      f32_4 %30 = OpLoad %26 
					                             Uniform f32_4* %37 = OpAccessChain %33 %35 
					                                      f32_4 %38 = OpLoad %37 
					                                      f32_4 %39 = OpFMul %30 %38 
					                                                    OpStore %26 %39 
					                                      f32_4 %40 = OpLoad %26 
					                               Uniform f32* %43 = OpAccessChain %33 %41 
					                                        f32 %44 = OpLoad %43 
					                                      f32_4 %45 = OpCompositeConstruct %44 %44 %44 %44 
					                                      f32_4 %46 = OpFMul %40 %45 
					                                                    OpStore %26 %46 
					                               Private f32* %52 = OpAccessChain %26 %50 
					                                        f32 %53 = OpLoad %52 
					                                Output f32* %55 = OpAccessChain %48 %50 
					                                                    OpStore %55 %53 
					                                Output f32* %56 = OpAccessChain %48 %50 
					                                        f32 %57 = OpLoad %56 
					                                        f32 %60 = OpExtInst %1 43 %57 %58 %59 
					                                Output f32* %61 = OpAccessChain %48 %50 
					                                                    OpStore %61 %60 
					                                      f32_4 %63 = OpLoad %26 
					                                      f32_3 %64 = OpVectorShuffle %63 %63 0 1 2 
					                                      f32_4 %65 = OpLoad %48 
					                                      f32_4 %66 = OpVectorShuffle %65 %64 4 5 6 3 
					                                                    OpStore %48 %66 
					                                                    OpReturn
					                                                    OpFunctionEnd"
				}
				SubProgram "vulkan hw_tier01 " {
					Keywords { "SOFTPARTICLES_ON" }
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
					; Bound: 68
					; Schema: 0
					                                                    OpCapability Shader 
					                                             %1 = OpExtInstImport "GLSL.std.450" 
					                                                    OpMemoryModel Logical GLSL450 
					                                                    OpEntryPoint Fragment %4 "main" %17 %22 %48 
					                                                    OpExecutionMode %4 OriginUpperLeft 
					                                                    OpDecorate %9 RelaxedPrecision 
					                                                    OpDecorate %13 RelaxedPrecision 
					                                                    OpDecorate %13 DescriptorSet 13 
					                                                    OpDecorate %13 Binding 13 
					                                                    OpDecorate %14 RelaxedPrecision 
					                                                    OpDecorate %17 Location 17 
					                                                    OpDecorate %20 RelaxedPrecision 
					                                                    OpDecorate %22 RelaxedPrecision 
					                                                    OpDecorate %22 Location 22 
					                                                    OpDecorate %23 RelaxedPrecision 
					                                                    OpDecorate %24 RelaxedPrecision 
					                                                    OpDecorate %25 RelaxedPrecision 
					                                                    OpDecorate %26 RelaxedPrecision 
					                                                    OpDecorate %27 RelaxedPrecision 
					                                                    OpDecorate %28 RelaxedPrecision 
					                                                    OpDecorate %29 RelaxedPrecision 
					                                                    OpDecorate %30 RelaxedPrecision 
					                                                    OpMemberDecorate %31 0 RelaxedPrecision 
					                                                    OpMemberDecorate %31 0 Offset 31 
					                                                    OpMemberDecorate %31 1 RelaxedPrecision 
					                                                    OpMemberDecorate %31 1 Offset 31 
					                                                    OpDecorate %31 Block 
					                                                    OpDecorate %33 DescriptorSet 33 
					                                                    OpDecorate %33 Binding 33 
					                                                    OpDecorate %38 RelaxedPrecision 
					                                                    OpDecorate %39 RelaxedPrecision 
					                                                    OpDecorate %40 RelaxedPrecision 
					                                                    OpDecorate %44 RelaxedPrecision 
					                                                    OpDecorate %45 RelaxedPrecision 
					                                                    OpDecorate %46 RelaxedPrecision 
					                                                    OpDecorate %48 RelaxedPrecision 
					                                                    OpDecorate %48 Location 48 
					                                                    OpDecorate %53 RelaxedPrecision 
					                                                    OpDecorate %57 RelaxedPrecision 
					                                                    OpDecorate %60 RelaxedPrecision 
					                                                    OpDecorate %63 RelaxedPrecision 
					                                                    OpDecorate %64 RelaxedPrecision 
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
					                             Private f32_4* %20 = OpVariable Private 
					                                            %21 = OpTypePointer Input %7 
					                               Input f32_4* %22 = OpVariable Input 
					                             Private f32_4* %26 = OpVariable Private 
					                                            %31 = OpTypeStruct %7 %6 
					                                            %32 = OpTypePointer Uniform %31 
					              Uniform struct {f32_4; f32;}* %33 = OpVariable Uniform 
					                                            %34 = OpTypeInt 32 1 
					                                        i32 %35 = OpConstant 0 
					                                            %36 = OpTypePointer Uniform %7 
					                                        i32 %41 = OpConstant 1 
					                                            %42 = OpTypePointer Uniform %6 
					                                            %47 = OpTypePointer Output %7 
					                              Output f32_4* %48 = OpVariable Output 
					                                            %49 = OpTypeInt 32 0 
					                                        u32 %50 = OpConstant 3 
					                                            %51 = OpTypePointer Private %6 
					                                            %54 = OpTypePointer Output %6 
					                                        f32 %58 = OpConstant 3.674022E-40 
					                                        f32 %59 = OpConstant 3.674022E-40 
					                                            %62 = OpTypeVector %6 3 
					                                        void %4 = OpFunction None %3 
					                                             %5 = OpLabel 
					                 read_only Texture2DSampled %14 = OpLoad %13 
					                                      f32_2 %18 = OpLoad %17 
					                                      f32_4 %19 = OpImageSampleImplicitLod %14 %18 
					                                                    OpStore %9 %19 
					                                      f32_4 %23 = OpLoad %22 
					                                      f32_4 %24 = OpLoad %22 
					                                      f32_4 %25 = OpFAdd %23 %24 
					                                                    OpStore %20 %25 
					                                      f32_4 %27 = OpLoad %9 
					                                      f32_4 %28 = OpLoad %20 
					                                      f32_4 %29 = OpFMul %27 %28 
					                                                    OpStore %26 %29 
					                                      f32_4 %30 = OpLoad %26 
					                             Uniform f32_4* %37 = OpAccessChain %33 %35 
					                                      f32_4 %38 = OpLoad %37 
					                                      f32_4 %39 = OpFMul %30 %38 
					                                                    OpStore %26 %39 
					                                      f32_4 %40 = OpLoad %26 
					                               Uniform f32* %43 = OpAccessChain %33 %41 
					                                        f32 %44 = OpLoad %43 
					                                      f32_4 %45 = OpCompositeConstruct %44 %44 %44 %44 
					                                      f32_4 %46 = OpFMul %40 %45 
					                                                    OpStore %26 %46 
					                               Private f32* %52 = OpAccessChain %26 %50 
					                                        f32 %53 = OpLoad %52 
					                                Output f32* %55 = OpAccessChain %48 %50 
					                                                    OpStore %55 %53 
					                                Output f32* %56 = OpAccessChain %48 %50 
					                                        f32 %57 = OpLoad %56 
					                                        f32 %60 = OpExtInst %1 43 %57 %58 %59 
					                                Output f32* %61 = OpAccessChain %48 %50 
					                                                    OpStore %61 %60 
					                                      f32_4 %63 = OpLoad %26 
					                                      f32_3 %64 = OpVectorShuffle %63 %63 0 1 2 
					                                      f32_4 %65 = OpLoad %48 
					                                      f32_4 %66 = OpVectorShuffle %65 %64 4 5 6 3 
					                                                    OpStore %48 %66 
					                                                    OpReturn
					                                                    OpFunctionEnd"
				}
				SubProgram "vulkan hw_tier02 " {
					Keywords { "SOFTPARTICLES_ON" }
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
					; Bound: 68
					; Schema: 0
					                                                    OpCapability Shader 
					                                             %1 = OpExtInstImport "GLSL.std.450" 
					                                                    OpMemoryModel Logical GLSL450 
					                                                    OpEntryPoint Fragment %4 "main" %17 %22 %48 
					                                                    OpExecutionMode %4 OriginUpperLeft 
					                                                    OpDecorate %9 RelaxedPrecision 
					                                                    OpDecorate %13 RelaxedPrecision 
					                                                    OpDecorate %13 DescriptorSet 13 
					                                                    OpDecorate %13 Binding 13 
					                                                    OpDecorate %14 RelaxedPrecision 
					                                                    OpDecorate %17 Location 17 
					                                                    OpDecorate %20 RelaxedPrecision 
					                                                    OpDecorate %22 RelaxedPrecision 
					                                                    OpDecorate %22 Location 22 
					                                                    OpDecorate %23 RelaxedPrecision 
					                                                    OpDecorate %24 RelaxedPrecision 
					                                                    OpDecorate %25 RelaxedPrecision 
					                                                    OpDecorate %26 RelaxedPrecision 
					                                                    OpDecorate %27 RelaxedPrecision 
					                                                    OpDecorate %28 RelaxedPrecision 
					                                                    OpDecorate %29 RelaxedPrecision 
					                                                    OpDecorate %30 RelaxedPrecision 
					                                                    OpMemberDecorate %31 0 RelaxedPrecision 
					                                                    OpMemberDecorate %31 0 Offset 31 
					                                                    OpMemberDecorate %31 1 RelaxedPrecision 
					                                                    OpMemberDecorate %31 1 Offset 31 
					                                                    OpDecorate %31 Block 
					                                                    OpDecorate %33 DescriptorSet 33 
					                                                    OpDecorate %33 Binding 33 
					                                                    OpDecorate %38 RelaxedPrecision 
					                                                    OpDecorate %39 RelaxedPrecision 
					                                                    OpDecorate %40 RelaxedPrecision 
					                                                    OpDecorate %44 RelaxedPrecision 
					                                                    OpDecorate %45 RelaxedPrecision 
					                                                    OpDecorate %46 RelaxedPrecision 
					                                                    OpDecorate %48 RelaxedPrecision 
					                                                    OpDecorate %48 Location 48 
					                                                    OpDecorate %53 RelaxedPrecision 
					                                                    OpDecorate %57 RelaxedPrecision 
					                                                    OpDecorate %60 RelaxedPrecision 
					                                                    OpDecorate %63 RelaxedPrecision 
					                                                    OpDecorate %64 RelaxedPrecision 
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
					                             Private f32_4* %20 = OpVariable Private 
					                                            %21 = OpTypePointer Input %7 
					                               Input f32_4* %22 = OpVariable Input 
					                             Private f32_4* %26 = OpVariable Private 
					                                            %31 = OpTypeStruct %7 %6 
					                                            %32 = OpTypePointer Uniform %31 
					              Uniform struct {f32_4; f32;}* %33 = OpVariable Uniform 
					                                            %34 = OpTypeInt 32 1 
					                                        i32 %35 = OpConstant 0 
					                                            %36 = OpTypePointer Uniform %7 
					                                        i32 %41 = OpConstant 1 
					                                            %42 = OpTypePointer Uniform %6 
					                                            %47 = OpTypePointer Output %7 
					                              Output f32_4* %48 = OpVariable Output 
					                                            %49 = OpTypeInt 32 0 
					                                        u32 %50 = OpConstant 3 
					                                            %51 = OpTypePointer Private %6 
					                                            %54 = OpTypePointer Output %6 
					                                        f32 %58 = OpConstant 3.674022E-40 
					                                        f32 %59 = OpConstant 3.674022E-40 
					                                            %62 = OpTypeVector %6 3 
					                                        void %4 = OpFunction None %3 
					                                             %5 = OpLabel 
					                 read_only Texture2DSampled %14 = OpLoad %13 
					                                      f32_2 %18 = OpLoad %17 
					                                      f32_4 %19 = OpImageSampleImplicitLod %14 %18 
					                                                    OpStore %9 %19 
					                                      f32_4 %23 = OpLoad %22 
					                                      f32_4 %24 = OpLoad %22 
					                                      f32_4 %25 = OpFAdd %23 %24 
					                                                    OpStore %20 %25 
					                                      f32_4 %27 = OpLoad %9 
					                                      f32_4 %28 = OpLoad %20 
					                                      f32_4 %29 = OpFMul %27 %28 
					                                                    OpStore %26 %29 
					                                      f32_4 %30 = OpLoad %26 
					                             Uniform f32_4* %37 = OpAccessChain %33 %35 
					                                      f32_4 %38 = OpLoad %37 
					                                      f32_4 %39 = OpFMul %30 %38 
					                                                    OpStore %26 %39 
					                                      f32_4 %40 = OpLoad %26 
					                               Uniform f32* %43 = OpAccessChain %33 %41 
					                                        f32 %44 = OpLoad %43 
					                                      f32_4 %45 = OpCompositeConstruct %44 %44 %44 %44 
					                                      f32_4 %46 = OpFMul %40 %45 
					                                                    OpStore %26 %46 
					                               Private f32* %52 = OpAccessChain %26 %50 
					                                        f32 %53 = OpLoad %52 
					                                Output f32* %55 = OpAccessChain %48 %50 
					                                                    OpStore %55 %53 
					                                Output f32* %56 = OpAccessChain %48 %50 
					                                        f32 %57 = OpLoad %56 
					                                        f32 %60 = OpExtInst %1 43 %57 %58 %59 
					                                Output f32* %61 = OpAccessChain %48 %50 
					                                                    OpStore %61 %60 
					                                      f32_4 %63 = OpLoad %26 
					                                      f32_3 %64 = OpVectorShuffle %63 %63 0 1 2 
					                                      f32_4 %65 = OpLoad %48 
					                                      f32_4 %66 = OpVectorShuffle %65 %64 4 5 6 3 
					                                                    OpStore %48 %66 
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
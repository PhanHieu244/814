Shader "Effects/GlowAdditive" {
	Properties {
		_TintColor ("Tint Color", Vector) = (0.5,0.5,0.5,0.5)
		_MainTex ("Particle Texture", 2D) = "white" {}
		_CutOutLightCore ("CutOut Light Core", Range(0, 1)) = 0.5
		_InvFade ("Soft Particles Factor", Range(0.01, 3)) = 1
	}
	SubShader {
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha One, SrcAlpha One
			ColorMask RGB -1
			ZClip Off
			ZWrite Off
			Cull Off
			GpuProgramID 14905
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
					uniform highp float _CutOutLightCore;
					varying lowp vec4 xlv_COLOR;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  if ((tmpvar_2.x > _CutOutLightCore)) {
					    tmpvar_1 = ((2.0 * xlv_COLOR) * _TintColor.w);
					  } else {
					    tmpvar_1 = ((tmpvar_2.y * _TintColor) * (xlv_COLOR * 3.0));
					  };
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
					uniform highp float _CutOutLightCore;
					varying lowp vec4 xlv_COLOR;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  if ((tmpvar_2.x > _CutOutLightCore)) {
					    tmpvar_1 = ((2.0 * xlv_COLOR) * _TintColor.w);
					  } else {
					    tmpvar_1 = ((tmpvar_2.y * _TintColor) * (xlv_COLOR * 3.0));
					  };
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
					uniform highp float _CutOutLightCore;
					varying lowp vec4 xlv_COLOR;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  if ((tmpvar_2.x > _CutOutLightCore)) {
					    tmpvar_1 = ((2.0 * xlv_COLOR) * _TintColor.w);
					  } else {
					    tmpvar_1 = ((tmpvar_2.y * _TintColor) * (xlv_COLOR * 3.0));
					  };
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
					uniform 	float _CutOutLightCore;
					uniform lowp sampler2D _MainTex;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec4 u_xlat16_0;
					lowp vec2 u_xlat10_0;
					bool u_xlatb0;
					mediump vec4 u_xlat16_1;
					void main()
					{
					    u_xlat10_0.xy = texture(_MainTex, vs_TEXCOORD0.xy).xy;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_CutOutLightCore<u_xlat10_0.x);
					#else
					    u_xlatb0 = _CutOutLightCore<u_xlat10_0.x;
					#endif
					    if(u_xlatb0){
					        u_xlat16_1 = vs_COLOR0 + vs_COLOR0;
					        u_xlat16_1 = u_xlat16_1 * _TintColor.wwww;
					        SV_Target0 = u_xlat16_1;
					        return;
					    } else {
					        u_xlat16_0 = u_xlat10_0.yyyy * _TintColor;
					        u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
					        SV_Target0 = u_xlat16_0 * vec4(3.0, 3.0, 3.0, 3.0);
					        return;
					    //ENDIF
					    }
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
					uniform 	float _CutOutLightCore;
					uniform lowp sampler2D _MainTex;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec4 u_xlat16_0;
					lowp vec2 u_xlat10_0;
					bool u_xlatb0;
					mediump vec4 u_xlat16_1;
					void main()
					{
					    u_xlat10_0.xy = texture(_MainTex, vs_TEXCOORD0.xy).xy;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_CutOutLightCore<u_xlat10_0.x);
					#else
					    u_xlatb0 = _CutOutLightCore<u_xlat10_0.x;
					#endif
					    if(u_xlatb0){
					        u_xlat16_1 = vs_COLOR0 + vs_COLOR0;
					        u_xlat16_1 = u_xlat16_1 * _TintColor.wwww;
					        SV_Target0 = u_xlat16_1;
					        return;
					    } else {
					        u_xlat16_0 = u_xlat10_0.yyyy * _TintColor;
					        u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
					        SV_Target0 = u_xlat16_0 * vec4(3.0, 3.0, 3.0, 3.0);
					        return;
					    //ENDIF
					    }
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
					uniform 	float _CutOutLightCore;
					uniform lowp sampler2D _MainTex;
					in mediump vec4 vs_COLOR0;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec4 u_xlat16_0;
					lowp vec2 u_xlat10_0;
					bool u_xlatb0;
					mediump vec4 u_xlat16_1;
					void main()
					{
					    u_xlat10_0.xy = texture(_MainTex, vs_TEXCOORD0.xy).xy;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(_CutOutLightCore<u_xlat10_0.x);
					#else
					    u_xlatb0 = _CutOutLightCore<u_xlat10_0.x;
					#endif
					    if(u_xlatb0){
					        u_xlat16_1 = vs_COLOR0 + vs_COLOR0;
					        u_xlat16_1 = u_xlat16_1 * _TintColor.wwww;
					        SV_Target0 = u_xlat16_1;
					        return;
					    } else {
					        u_xlat16_0 = u_xlat10_0.yyyy * _TintColor;
					        u_xlat16_0 = u_xlat16_0 * vs_COLOR0;
					        SV_Target0 = u_xlat16_0 * vec4(3.0, 3.0, 3.0, 3.0);
					        return;
					    //ENDIF
					    }
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
					; Bound: 75
					; Schema: 0
					                                                    OpCapability Shader 
					                                             %1 = OpExtInstImport "GLSL.std.450" 
					                                                    OpMemoryModel Logical GLSL450 
					                                                    OpEntryPoint Fragment %4 "main" %16 %44 %56 
					                                                    OpExecutionMode %4 OriginUpperLeft 
					                                                    OpDecorate %9 RelaxedPrecision 
					                                                    OpDecorate %13 RelaxedPrecision 
					                                                    OpDecorate %13 DescriptorSet 13 
					                                                    OpDecorate %13 Binding 13 
					                                                    OpDecorate %14 RelaxedPrecision 
					                                                    OpDecorate %16 Location 16 
					                                                    OpDecorate %20 RelaxedPrecision 
					                                                    OpMemberDecorate %24 0 RelaxedPrecision 
					                                                    OpMemberDecorate %24 0 Offset 24 
					                                                    OpMemberDecorate %24 1 Offset 24 
					                                                    OpDecorate %24 Block 
					                                                    OpDecorate %26 DescriptorSet 26 
					                                                    OpDecorate %26 Binding 26 
					                                                    OpDecorate %36 RelaxedPrecision 
					                                                    OpDecorate %42 RelaxedPrecision 
					                                                    OpDecorate %44 RelaxedPrecision 
					                                                    OpDecorate %44 Location 44 
					                                                    OpDecorate %45 RelaxedPrecision 
					                                                    OpDecorate %46 RelaxedPrecision 
					                                                    OpDecorate %47 RelaxedPrecision 
					                                                    OpDecorate %48 RelaxedPrecision 
					                                                    OpDecorate %52 RelaxedPrecision 
					                                                    OpDecorate %53 RelaxedPrecision 
					                                                    OpDecorate %54 RelaxedPrecision 
					                                                    OpDecorate %56 RelaxedPrecision 
					                                                    OpDecorate %56 Location 56 
					                                                    OpDecorate %57 RelaxedPrecision 
					                                                    OpDecorate %60 RelaxedPrecision 
					                                                    OpDecorate %61 RelaxedPrecision 
					                                                    OpDecorate %62 RelaxedPrecision 
					                                                    OpDecorate %64 RelaxedPrecision 
					                                                    OpDecorate %65 RelaxedPrecision 
					                                                    OpDecorate %66 RelaxedPrecision 
					                                                    OpDecorate %67 RelaxedPrecision 
					                                                    OpDecorate %68 RelaxedPrecision 
					                                                    OpDecorate %69 RelaxedPrecision 
					                                                    OpDecorate %72 RelaxedPrecision 
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
					                                            %21 = OpTypeBool 
					                                            %22 = OpTypePointer Private %21 
					                              Private bool* %23 = OpVariable Private 
					                                            %24 = OpTypeStruct %18 %6 
					                                            %25 = OpTypePointer Uniform %24 
					              Uniform struct {f32_4; f32;}* %26 = OpVariable Uniform 
					                                            %27 = OpTypeInt 32 1 
					                                        i32 %28 = OpConstant 1 
					                                            %29 = OpTypePointer Uniform %6 
					                                            %32 = OpTypeInt 32 0 
					                                        u32 %33 = OpConstant 0 
					                                            %34 = OpTypePointer Private %6 
					                                            %41 = OpTypePointer Private %18 
					                             Private f32_4* %42 = OpVariable Private 
					                                            %43 = OpTypePointer Input %18 
					                               Input f32_4* %44 = OpVariable Input 
					                                        i32 %49 = OpConstant 0 
					                                            %50 = OpTypePointer Uniform %18 
					                                            %55 = OpTypePointer Output %18 
					                              Output f32_4* %56 = OpVariable Output 
					                             Private f32_4* %60 = OpVariable Private 
					                                        f32 %70 = OpConstant 3.674022E-40 
					                                      f32_4 %71 = OpConstantComposite %70 %70 %70 %70 
					                                        void %4 = OpFunction None %3 
					                                             %5 = OpLabel 
					                 read_only Texture2DSampled %14 = OpLoad %13 
					                                      f32_2 %17 = OpLoad %16 
					                                      f32_4 %19 = OpImageSampleImplicitLod %14 %17 
					                                      f32_2 %20 = OpVectorShuffle %19 %19 0 1 
					                                                    OpStore %9 %20 
					                               Uniform f32* %30 = OpAccessChain %26 %28 
					                                        f32 %31 = OpLoad %30 
					                               Private f32* %35 = OpAccessChain %9 %33 
					                                        f32 %36 = OpLoad %35 
					                                       bool %37 = OpFOrdLessThan %31 %36 
					                                                    OpStore %23 %37 
					                                       bool %38 = OpLoad %23 
					                                                    OpSelectionMerge %40 None 
					                                                    OpBranchConditional %38 %39 %59 
					                                            %39 = OpLabel 
					                                      f32_4 %45 = OpLoad %44 
					                                      f32_4 %46 = OpLoad %44 
					                                      f32_4 %47 = OpFAdd %45 %46 
					                                                    OpStore %42 %47 
					                                      f32_4 %48 = OpLoad %42 
					                             Uniform f32_4* %51 = OpAccessChain %26 %49 
					                                      f32_4 %52 = OpLoad %51 
					                                      f32_4 %53 = OpVectorShuffle %52 %52 3 3 3 3 
					                                      f32_4 %54 = OpFMul %48 %53 
					                                                    OpStore %42 %54 
					                                      f32_4 %57 = OpLoad %42 
					                                                    OpStore %56 %57 
					                                                    OpReturn
					                                            %59 = OpLabel 
					                                      f32_2 %61 = OpLoad %9 
					                                      f32_4 %62 = OpVectorShuffle %61 %61 1 1 1 1 
					                             Uniform f32_4* %63 = OpAccessChain %26 %49 
					                                      f32_4 %64 = OpLoad %63 
					                                      f32_4 %65 = OpFMul %62 %64 
					                                                    OpStore %60 %65 
					                                      f32_4 %66 = OpLoad %60 
					                                      f32_4 %67 = OpLoad %44 
					                                      f32_4 %68 = OpFMul %66 %67 
					                                                    OpStore %60 %68 
					                                      f32_4 %69 = OpLoad %60 
					                                      f32_4 %72 = OpFMul %69 %71 
					                                                    OpStore %56 %72 
					                                                    OpReturn
					                                            %40 = OpLabel 
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
					; Bound: 75
					; Schema: 0
					                                                    OpCapability Shader 
					                                             %1 = OpExtInstImport "GLSL.std.450" 
					                                                    OpMemoryModel Logical GLSL450 
					                                                    OpEntryPoint Fragment %4 "main" %16 %44 %56 
					                                                    OpExecutionMode %4 OriginUpperLeft 
					                                                    OpDecorate %9 RelaxedPrecision 
					                                                    OpDecorate %13 RelaxedPrecision 
					                                                    OpDecorate %13 DescriptorSet 13 
					                                                    OpDecorate %13 Binding 13 
					                                                    OpDecorate %14 RelaxedPrecision 
					                                                    OpDecorate %16 Location 16 
					                                                    OpDecorate %20 RelaxedPrecision 
					                                                    OpMemberDecorate %24 0 RelaxedPrecision 
					                                                    OpMemberDecorate %24 0 Offset 24 
					                                                    OpMemberDecorate %24 1 Offset 24 
					                                                    OpDecorate %24 Block 
					                                                    OpDecorate %26 DescriptorSet 26 
					                                                    OpDecorate %26 Binding 26 
					                                                    OpDecorate %36 RelaxedPrecision 
					                                                    OpDecorate %42 RelaxedPrecision 
					                                                    OpDecorate %44 RelaxedPrecision 
					                                                    OpDecorate %44 Location 44 
					                                                    OpDecorate %45 RelaxedPrecision 
					                                                    OpDecorate %46 RelaxedPrecision 
					                                                    OpDecorate %47 RelaxedPrecision 
					                                                    OpDecorate %48 RelaxedPrecision 
					                                                    OpDecorate %52 RelaxedPrecision 
					                                                    OpDecorate %53 RelaxedPrecision 
					                                                    OpDecorate %54 RelaxedPrecision 
					                                                    OpDecorate %56 RelaxedPrecision 
					                                                    OpDecorate %56 Location 56 
					                                                    OpDecorate %57 RelaxedPrecision 
					                                                    OpDecorate %60 RelaxedPrecision 
					                                                    OpDecorate %61 RelaxedPrecision 
					                                                    OpDecorate %62 RelaxedPrecision 
					                                                    OpDecorate %64 RelaxedPrecision 
					                                                    OpDecorate %65 RelaxedPrecision 
					                                                    OpDecorate %66 RelaxedPrecision 
					                                                    OpDecorate %67 RelaxedPrecision 
					                                                    OpDecorate %68 RelaxedPrecision 
					                                                    OpDecorate %69 RelaxedPrecision 
					                                                    OpDecorate %72 RelaxedPrecision 
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
					                                            %21 = OpTypeBool 
					                                            %22 = OpTypePointer Private %21 
					                              Private bool* %23 = OpVariable Private 
					                                            %24 = OpTypeStruct %18 %6 
					                                            %25 = OpTypePointer Uniform %24 
					              Uniform struct {f32_4; f32;}* %26 = OpVariable Uniform 
					                                            %27 = OpTypeInt 32 1 
					                                        i32 %28 = OpConstant 1 
					                                            %29 = OpTypePointer Uniform %6 
					                                            %32 = OpTypeInt 32 0 
					                                        u32 %33 = OpConstant 0 
					                                            %34 = OpTypePointer Private %6 
					                                            %41 = OpTypePointer Private %18 
					                             Private f32_4* %42 = OpVariable Private 
					                                            %43 = OpTypePointer Input %18 
					                               Input f32_4* %44 = OpVariable Input 
					                                        i32 %49 = OpConstant 0 
					                                            %50 = OpTypePointer Uniform %18 
					                                            %55 = OpTypePointer Output %18 
					                              Output f32_4* %56 = OpVariable Output 
					                             Private f32_4* %60 = OpVariable Private 
					                                        f32 %70 = OpConstant 3.674022E-40 
					                                      f32_4 %71 = OpConstantComposite %70 %70 %70 %70 
					                                        void %4 = OpFunction None %3 
					                                             %5 = OpLabel 
					                 read_only Texture2DSampled %14 = OpLoad %13 
					                                      f32_2 %17 = OpLoad %16 
					                                      f32_4 %19 = OpImageSampleImplicitLod %14 %17 
					                                      f32_2 %20 = OpVectorShuffle %19 %19 0 1 
					                                                    OpStore %9 %20 
					                               Uniform f32* %30 = OpAccessChain %26 %28 
					                                        f32 %31 = OpLoad %30 
					                               Private f32* %35 = OpAccessChain %9 %33 
					                                        f32 %36 = OpLoad %35 
					                                       bool %37 = OpFOrdLessThan %31 %36 
					                                                    OpStore %23 %37 
					                                       bool %38 = OpLoad %23 
					                                                    OpSelectionMerge %40 None 
					                                                    OpBranchConditional %38 %39 %59 
					                                            %39 = OpLabel 
					                                      f32_4 %45 = OpLoad %44 
					                                      f32_4 %46 = OpLoad %44 
					                                      f32_4 %47 = OpFAdd %45 %46 
					                                                    OpStore %42 %47 
					                                      f32_4 %48 = OpLoad %42 
					                             Uniform f32_4* %51 = OpAccessChain %26 %49 
					                                      f32_4 %52 = OpLoad %51 
					                                      f32_4 %53 = OpVectorShuffle %52 %52 3 3 3 3 
					                                      f32_4 %54 = OpFMul %48 %53 
					                                                    OpStore %42 %54 
					                                      f32_4 %57 = OpLoad %42 
					                                                    OpStore %56 %57 
					                                                    OpReturn
					                                            %59 = OpLabel 
					                                      f32_2 %61 = OpLoad %9 
					                                      f32_4 %62 = OpVectorShuffle %61 %61 1 1 1 1 
					                             Uniform f32_4* %63 = OpAccessChain %26 %49 
					                                      f32_4 %64 = OpLoad %63 
					                                      f32_4 %65 = OpFMul %62 %64 
					                                                    OpStore %60 %65 
					                                      f32_4 %66 = OpLoad %60 
					                                      f32_4 %67 = OpLoad %44 
					                                      f32_4 %68 = OpFMul %66 %67 
					                                                    OpStore %60 %68 
					                                      f32_4 %69 = OpLoad %60 
					                                      f32_4 %72 = OpFMul %69 %71 
					                                                    OpStore %56 %72 
					                                                    OpReturn
					                                            %40 = OpLabel 
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
					; Bound: 75
					; Schema: 0
					                                                    OpCapability Shader 
					                                             %1 = OpExtInstImport "GLSL.std.450" 
					                                                    OpMemoryModel Logical GLSL450 
					                                                    OpEntryPoint Fragment %4 "main" %16 %44 %56 
					                                                    OpExecutionMode %4 OriginUpperLeft 
					                                                    OpDecorate %9 RelaxedPrecision 
					                                                    OpDecorate %13 RelaxedPrecision 
					                                                    OpDecorate %13 DescriptorSet 13 
					                                                    OpDecorate %13 Binding 13 
					                                                    OpDecorate %14 RelaxedPrecision 
					                                                    OpDecorate %16 Location 16 
					                                                    OpDecorate %20 RelaxedPrecision 
					                                                    OpMemberDecorate %24 0 RelaxedPrecision 
					                                                    OpMemberDecorate %24 0 Offset 24 
					                                                    OpMemberDecorate %24 1 Offset 24 
					                                                    OpDecorate %24 Block 
					                                                    OpDecorate %26 DescriptorSet 26 
					                                                    OpDecorate %26 Binding 26 
					                                                    OpDecorate %36 RelaxedPrecision 
					                                                    OpDecorate %42 RelaxedPrecision 
					                                                    OpDecorate %44 RelaxedPrecision 
					                                                    OpDecorate %44 Location 44 
					                                                    OpDecorate %45 RelaxedPrecision 
					                                                    OpDecorate %46 RelaxedPrecision 
					                                                    OpDecorate %47 RelaxedPrecision 
					                                                    OpDecorate %48 RelaxedPrecision 
					                                                    OpDecorate %52 RelaxedPrecision 
					                                                    OpDecorate %53 RelaxedPrecision 
					                                                    OpDecorate %54 RelaxedPrecision 
					                                                    OpDecorate %56 RelaxedPrecision 
					                                                    OpDecorate %56 Location 56 
					                                                    OpDecorate %57 RelaxedPrecision 
					                                                    OpDecorate %60 RelaxedPrecision 
					                                                    OpDecorate %61 RelaxedPrecision 
					                                                    OpDecorate %62 RelaxedPrecision 
					                                                    OpDecorate %64 RelaxedPrecision 
					                                                    OpDecorate %65 RelaxedPrecision 
					                                                    OpDecorate %66 RelaxedPrecision 
					                                                    OpDecorate %67 RelaxedPrecision 
					                                                    OpDecorate %68 RelaxedPrecision 
					                                                    OpDecorate %69 RelaxedPrecision 
					                                                    OpDecorate %72 RelaxedPrecision 
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
					                                            %21 = OpTypeBool 
					                                            %22 = OpTypePointer Private %21 
					                              Private bool* %23 = OpVariable Private 
					                                            %24 = OpTypeStruct %18 %6 
					                                            %25 = OpTypePointer Uniform %24 
					              Uniform struct {f32_4; f32;}* %26 = OpVariable Uniform 
					                                            %27 = OpTypeInt 32 1 
					                                        i32 %28 = OpConstant 1 
					                                            %29 = OpTypePointer Uniform %6 
					                                            %32 = OpTypeInt 32 0 
					                                        u32 %33 = OpConstant 0 
					                                            %34 = OpTypePointer Private %6 
					                                            %41 = OpTypePointer Private %18 
					                             Private f32_4* %42 = OpVariable Private 
					                                            %43 = OpTypePointer Input %18 
					                               Input f32_4* %44 = OpVariable Input 
					                                        i32 %49 = OpConstant 0 
					                                            %50 = OpTypePointer Uniform %18 
					                                            %55 = OpTypePointer Output %18 
					                              Output f32_4* %56 = OpVariable Output 
					                             Private f32_4* %60 = OpVariable Private 
					                                        f32 %70 = OpConstant 3.674022E-40 
					                                      f32_4 %71 = OpConstantComposite %70 %70 %70 %70 
					                                        void %4 = OpFunction None %3 
					                                             %5 = OpLabel 
					                 read_only Texture2DSampled %14 = OpLoad %13 
					                                      f32_2 %17 = OpLoad %16 
					                                      f32_4 %19 = OpImageSampleImplicitLod %14 %17 
					                                      f32_2 %20 = OpVectorShuffle %19 %19 0 1 
					                                                    OpStore %9 %20 
					                               Uniform f32* %30 = OpAccessChain %26 %28 
					                                        f32 %31 = OpLoad %30 
					                               Private f32* %35 = OpAccessChain %9 %33 
					                                        f32 %36 = OpLoad %35 
					                                       bool %37 = OpFOrdLessThan %31 %36 
					                                                    OpStore %23 %37 
					                                       bool %38 = OpLoad %23 
					                                                    OpSelectionMerge %40 None 
					                                                    OpBranchConditional %38 %39 %59 
					                                            %39 = OpLabel 
					                                      f32_4 %45 = OpLoad %44 
					                                      f32_4 %46 = OpLoad %44 
					                                      f32_4 %47 = OpFAdd %45 %46 
					                                                    OpStore %42 %47 
					                                      f32_4 %48 = OpLoad %42 
					                             Uniform f32_4* %51 = OpAccessChain %26 %49 
					                                      f32_4 %52 = OpLoad %51 
					                                      f32_4 %53 = OpVectorShuffle %52 %52 3 3 3 3 
					                                      f32_4 %54 = OpFMul %48 %53 
					                                                    OpStore %42 %54 
					                                      f32_4 %57 = OpLoad %42 
					                                                    OpStore %56 %57 
					                                                    OpReturn
					                                            %59 = OpLabel 
					                                      f32_2 %61 = OpLoad %9 
					                                      f32_4 %62 = OpVectorShuffle %61 %61 1 1 1 1 
					                             Uniform f32_4* %63 = OpAccessChain %26 %49 
					                                      f32_4 %64 = OpLoad %63 
					                                      f32_4 %65 = OpFMul %62 %64 
					                                                    OpStore %60 %65 
					                                      f32_4 %66 = OpLoad %60 
					                                      f32_4 %67 = OpLoad %44 
					                                      f32_4 %68 = OpFMul %66 %67 
					                                                    OpStore %60 %68 
					                                      f32_4 %69 = OpLoad %60 
					                                      f32_4 %72 = OpFMul %69 %71 
					                                                    OpStore %56 %72 
					                                                    OpReturn
					                                            %40 = OpLabel 
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
					uniform highp float _CutOutLightCore;
					uniform sampler2D _CameraDepthTexture;
					uniform highp float _InvFade;
					varying lowp vec4 xlv_COLOR;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  tmpvar_1.xyz = xlv_COLOR.xyz;
					  lowp vec4 tmpvar_2;
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
					  if ((tmpvar_6.x > _CutOutLightCore)) {
					    tmpvar_2 = ((2.0 * tmpvar_1) * _TintColor.w);
					  } else {
					    tmpvar_2 = ((tmpvar_6.y * _TintColor) * (tmpvar_1 * 3.0));
					  };
					  gl_FragData[0] = tmpvar_2;
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
					uniform highp float _CutOutLightCore;
					uniform sampler2D _CameraDepthTexture;
					uniform highp float _InvFade;
					varying lowp vec4 xlv_COLOR;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  tmpvar_1.xyz = xlv_COLOR.xyz;
					  lowp vec4 tmpvar_2;
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
					  if ((tmpvar_6.x > _CutOutLightCore)) {
					    tmpvar_2 = ((2.0 * tmpvar_1) * _TintColor.w);
					  } else {
					    tmpvar_2 = ((tmpvar_6.y * _TintColor) * (tmpvar_1 * 3.0));
					  };
					  gl_FragData[0] = tmpvar_2;
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
					uniform highp float _CutOutLightCore;
					uniform sampler2D _CameraDepthTexture;
					uniform highp float _InvFade;
					varying lowp vec4 xlv_COLOR;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  tmpvar_1.xyz = xlv_COLOR.xyz;
					  lowp vec4 tmpvar_2;
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
					  if ((tmpvar_6.x > _CutOutLightCore)) {
					    tmpvar_2 = ((2.0 * tmpvar_1) * _TintColor.w);
					  } else {
					    tmpvar_2 = ((tmpvar_6.y * _TintColor) * (tmpvar_1 * 3.0));
					  };
					  gl_FragData[0] = tmpvar_2;
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
					uniform 	float _CutOutLightCore;
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
					bool u_xlatb3;
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
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(_CutOutLightCore<u_xlat10_3.x);
					#else
					    u_xlatb3 = _CutOutLightCore<u_xlat10_3.x;
					#endif
					    if(u_xlatb3){
					        u_xlat1.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
					        u_xlat1.w = u_xlat0.x + u_xlat0.x;
					        u_xlat1 = u_xlat1 * _TintColor.wwww;
					        SV_Target0 = u_xlat1;
					        return;
					    } else {
					        u_xlat16_1 = u_xlat10_3.yyyy * _TintColor;
					        u_xlat16_2.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
					        u_xlat16_2.w = u_xlat0.x * u_xlat16_1.w;
					        SV_Target0 = u_xlat16_2 * vec4(3.0, 3.0, 3.0, 3.0);
					        return;
					    //ENDIF
					    }
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
					uniform 	float _CutOutLightCore;
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
					bool u_xlatb3;
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
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(_CutOutLightCore<u_xlat10_3.x);
					#else
					    u_xlatb3 = _CutOutLightCore<u_xlat10_3.x;
					#endif
					    if(u_xlatb3){
					        u_xlat1.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
					        u_xlat1.w = u_xlat0.x + u_xlat0.x;
					        u_xlat1 = u_xlat1 * _TintColor.wwww;
					        SV_Target0 = u_xlat1;
					        return;
					    } else {
					        u_xlat16_1 = u_xlat10_3.yyyy * _TintColor;
					        u_xlat16_2.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
					        u_xlat16_2.w = u_xlat0.x * u_xlat16_1.w;
					        SV_Target0 = u_xlat16_2 * vec4(3.0, 3.0, 3.0, 3.0);
					        return;
					    //ENDIF
					    }
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
					uniform 	float _CutOutLightCore;
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
					bool u_xlatb3;
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
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(_CutOutLightCore<u_xlat10_3.x);
					#else
					    u_xlatb3 = _CutOutLightCore<u_xlat10_3.x;
					#endif
					    if(u_xlatb3){
					        u_xlat1.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
					        u_xlat1.w = u_xlat0.x + u_xlat0.x;
					        u_xlat1 = u_xlat1 * _TintColor.wwww;
					        SV_Target0 = u_xlat1;
					        return;
					    } else {
					        u_xlat16_1 = u_xlat10_3.yyyy * _TintColor;
					        u_xlat16_2.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
					        u_xlat16_2.w = u_xlat0.x * u_xlat16_1.w;
					        SV_Target0 = u_xlat16_2 * vec4(3.0, 3.0, 3.0, 3.0);
					        return;
					    //ENDIF
					    }
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
					; Bound: 153
					; Schema: 0
					                                                    OpCapability Shader 
					                                             %1 = OpExtInstImport "GLSL.std.450" 
					                                                    OpMemoryModel Logical GLSL450 
					                                                    OpEntryPoint Fragment %4 "main" %12 %74 %83 %123 
					                                                    OpExecutionMode %4 OriginUpperLeft 
					                                                    OpDecorate %12 Location 12 
					                                                    OpDecorate %21 DescriptorSet 21 
					                                                    OpDecorate %21 Binding 21 
					                                                    OpMemberDecorate %30 0 Offset 30 
					                                                    OpMemberDecorate %30 1 RelaxedPrecision 
					                                                    OpMemberDecorate %30 1 Offset 30 
					                                                    OpMemberDecorate %30 2 Offset 30 
					                                                    OpMemberDecorate %30 3 Offset 30 
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
					                                                    OpDecorate %94 RelaxedPrecision 
					                                                    OpDecorate %102 RelaxedPrecision 
					                                                    OpDecorate %103 RelaxedPrecision 
					                                                    OpDecorate %104 RelaxedPrecision 
					                                                    OpDecorate %105 RelaxedPrecision 
					                                                    OpDecorate %106 RelaxedPrecision 
					                                                    OpDecorate %119 RelaxedPrecision 
					                                                    OpDecorate %120 RelaxedPrecision 
					                                                    OpDecorate %123 RelaxedPrecision 
					                                                    OpDecorate %123 Location 123 
					                                                    OpDecorate %127 RelaxedPrecision 
					                                                    OpDecorate %128 RelaxedPrecision 
					                                                    OpDecorate %129 RelaxedPrecision 
					                                                    OpDecorate %131 RelaxedPrecision 
					                                                    OpDecorate %132 RelaxedPrecision 
					                                                    OpDecorate %133 RelaxedPrecision 
					                                                    OpDecorate %134 RelaxedPrecision 
					                                                    OpDecorate %135 RelaxedPrecision 
					                                                    OpDecorate %136 RelaxedPrecision 
					                                                    OpDecorate %137 RelaxedPrecision 
					                                                    OpDecorate %138 RelaxedPrecision 
					                                                    OpDecorate %144 RelaxedPrecision 
					                                                    OpDecorate %147 RelaxedPrecision 
					                                                    OpDecorate %150 RelaxedPrecision 
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
					                                            %30 = OpTypeStruct %10 %10 %6 %6 
					                                            %31 = OpTypePointer Uniform %30 
					  Uniform struct {f32_4; f32_4; f32; f32;}* %32 = OpVariable Uniform 
					                                            %33 = OpTypeInt 32 1 
					                                        i32 %34 = OpConstant 0 
					                                        u32 %35 = OpConstant 2 
					                                            %36 = OpTypePointer Uniform %6 
					                                        u32 %42 = OpConstant 3 
					                                        f32 %47 = OpConstant 3.674022E-40 
					                                            %54 = OpTypePointer Input %6 
					                                        i32 %62 = OpConstant 3 
					                                        f32 %69 = OpConstant 3.674022E-40 
					                               Input f32_4* %74 = OpVariable Input 
					                             Private f32_2* %79 = OpVariable Private 
					UniformConstant read_only Texture2DSampled* %80 = OpVariable UniformConstant 
					                                            %82 = OpTypePointer Input %7 
					                               Input f32_2* %83 = OpVariable Input 
					                                            %87 = OpTypeBool 
					                                            %88 = OpTypePointer Private %87 
					                              Private bool* %89 = OpVariable Private 
					                                        i32 %90 = OpConstant 2 
					                                            %99 = OpTypePointer Private %10 
					                            Private f32_4* %100 = OpVariable Private 
					                                           %101 = OpTypeVector %6 3 
					                                       i32 %116 = OpConstant 1 
					                                           %117 = OpTypePointer Uniform %10 
					                                           %122 = OpTypePointer Output %10 
					                             Output f32_4* %123 = OpVariable Output 
					                            Private f32_4* %127 = OpVariable Private 
					                            Private f32_4* %133 = OpVariable Private 
					                                       f32 %148 = OpConstant 3.674022E-40 
					                                     f32_4 %149 = OpConstantComposite %148 %148 %148 %148 
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
					                               Uniform f32* %91 = OpAccessChain %32 %90 
					                                        f32 %92 = OpLoad %91 
					                               Private f32* %93 = OpAccessChain %79 %26 
					                                        f32 %94 = OpLoad %93 
					                                       bool %95 = OpFOrdLessThan %92 %94 
					                                                    OpStore %89 %95 
					                                       bool %96 = OpLoad %89 
					                                                    OpSelectionMerge %98 None 
					                                                    OpBranchConditional %96 %97 %126 
					                                            %97 = OpLabel 
					                                     f32_4 %102 = OpLoad %74 
					                                     f32_3 %103 = OpVectorShuffle %102 %102 0 1 2 
					                                     f32_4 %104 = OpLoad %74 
					                                     f32_3 %105 = OpVectorShuffle %104 %104 0 1 2 
					                                     f32_3 %106 = OpFAdd %103 %105 
					                                     f32_4 %107 = OpLoad %100 
					                                     f32_4 %108 = OpVectorShuffle %107 %106 4 5 6 3 
					                                                    OpStore %100 %108 
					                              Private f32* %109 = OpAccessChain %9 %26 
					                                       f32 %110 = OpLoad %109 
					                              Private f32* %111 = OpAccessChain %9 %26 
					                                       f32 %112 = OpLoad %111 
					                                       f32 %113 = OpFAdd %110 %112 
					                              Private f32* %114 = OpAccessChain %100 %42 
					                                                    OpStore %114 %113 
					                                     f32_4 %115 = OpLoad %100 
					                            Uniform f32_4* %118 = OpAccessChain %32 %116 
					                                     f32_4 %119 = OpLoad %118 
					                                     f32_4 %120 = OpVectorShuffle %119 %119 3 3 3 3 
					                                     f32_4 %121 = OpFMul %115 %120 
					                                                    OpStore %100 %121 
					                                     f32_4 %124 = OpLoad %100 
					                                                    OpStore %123 %124 
					                                                    OpReturn
					                                           %126 = OpLabel 
					                                     f32_2 %128 = OpLoad %79 
					                                     f32_4 %129 = OpVectorShuffle %128 %128 1 1 1 1 
					                            Uniform f32_4* %130 = OpAccessChain %32 %116 
					                                     f32_4 %131 = OpLoad %130 
					                                     f32_4 %132 = OpFMul %129 %131 
					                                                    OpStore %127 %132 
					                                     f32_4 %134 = OpLoad %127 
					                                     f32_3 %135 = OpVectorShuffle %134 %134 0 1 2 
					                                     f32_4 %136 = OpLoad %74 
					                                     f32_3 %137 = OpVectorShuffle %136 %136 0 1 2 
					                                     f32_3 %138 = OpFMul %135 %137 
					                                     f32_4 %139 = OpLoad %133 
					                                     f32_4 %140 = OpVectorShuffle %139 %138 4 5 6 3 
					                                                    OpStore %133 %140 
					                              Private f32* %141 = OpAccessChain %9 %26 
					                                       f32 %142 = OpLoad %141 
					                              Private f32* %143 = OpAccessChain %127 %42 
					                                       f32 %144 = OpLoad %143 
					                                       f32 %145 = OpFMul %142 %144 
					                              Private f32* %146 = OpAccessChain %133 %42 
					                                                    OpStore %146 %145 
					                                     f32_4 %147 = OpLoad %133 
					                                     f32_4 %150 = OpFMul %147 %149 
					                                                    OpStore %123 %150 
					                                                    OpReturn
					                                            %98 = OpLabel 
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
					; Bound: 153
					; Schema: 0
					                                                    OpCapability Shader 
					                                             %1 = OpExtInstImport "GLSL.std.450" 
					                                                    OpMemoryModel Logical GLSL450 
					                                                    OpEntryPoint Fragment %4 "main" %12 %74 %83 %123 
					                                                    OpExecutionMode %4 OriginUpperLeft 
					                                                    OpDecorate %12 Location 12 
					                                                    OpDecorate %21 DescriptorSet 21 
					                                                    OpDecorate %21 Binding 21 
					                                                    OpMemberDecorate %30 0 Offset 30 
					                                                    OpMemberDecorate %30 1 RelaxedPrecision 
					                                                    OpMemberDecorate %30 1 Offset 30 
					                                                    OpMemberDecorate %30 2 Offset 30 
					                                                    OpMemberDecorate %30 3 Offset 30 
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
					                                                    OpDecorate %94 RelaxedPrecision 
					                                                    OpDecorate %102 RelaxedPrecision 
					                                                    OpDecorate %103 RelaxedPrecision 
					                                                    OpDecorate %104 RelaxedPrecision 
					                                                    OpDecorate %105 RelaxedPrecision 
					                                                    OpDecorate %106 RelaxedPrecision 
					                                                    OpDecorate %119 RelaxedPrecision 
					                                                    OpDecorate %120 RelaxedPrecision 
					                                                    OpDecorate %123 RelaxedPrecision 
					                                                    OpDecorate %123 Location 123 
					                                                    OpDecorate %127 RelaxedPrecision 
					                                                    OpDecorate %128 RelaxedPrecision 
					                                                    OpDecorate %129 RelaxedPrecision 
					                                                    OpDecorate %131 RelaxedPrecision 
					                                                    OpDecorate %132 RelaxedPrecision 
					                                                    OpDecorate %133 RelaxedPrecision 
					                                                    OpDecorate %134 RelaxedPrecision 
					                                                    OpDecorate %135 RelaxedPrecision 
					                                                    OpDecorate %136 RelaxedPrecision 
					                                                    OpDecorate %137 RelaxedPrecision 
					                                                    OpDecorate %138 RelaxedPrecision 
					                                                    OpDecorate %144 RelaxedPrecision 
					                                                    OpDecorate %147 RelaxedPrecision 
					                                                    OpDecorate %150 RelaxedPrecision 
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
					                                            %30 = OpTypeStruct %10 %10 %6 %6 
					                                            %31 = OpTypePointer Uniform %30 
					  Uniform struct {f32_4; f32_4; f32; f32;}* %32 = OpVariable Uniform 
					                                            %33 = OpTypeInt 32 1 
					                                        i32 %34 = OpConstant 0 
					                                        u32 %35 = OpConstant 2 
					                                            %36 = OpTypePointer Uniform %6 
					                                        u32 %42 = OpConstant 3 
					                                        f32 %47 = OpConstant 3.674022E-40 
					                                            %54 = OpTypePointer Input %6 
					                                        i32 %62 = OpConstant 3 
					                                        f32 %69 = OpConstant 3.674022E-40 
					                               Input f32_4* %74 = OpVariable Input 
					                             Private f32_2* %79 = OpVariable Private 
					UniformConstant read_only Texture2DSampled* %80 = OpVariable UniformConstant 
					                                            %82 = OpTypePointer Input %7 
					                               Input f32_2* %83 = OpVariable Input 
					                                            %87 = OpTypeBool 
					                                            %88 = OpTypePointer Private %87 
					                              Private bool* %89 = OpVariable Private 
					                                        i32 %90 = OpConstant 2 
					                                            %99 = OpTypePointer Private %10 
					                            Private f32_4* %100 = OpVariable Private 
					                                           %101 = OpTypeVector %6 3 
					                                       i32 %116 = OpConstant 1 
					                                           %117 = OpTypePointer Uniform %10 
					                                           %122 = OpTypePointer Output %10 
					                             Output f32_4* %123 = OpVariable Output 
					                            Private f32_4* %127 = OpVariable Private 
					                            Private f32_4* %133 = OpVariable Private 
					                                       f32 %148 = OpConstant 3.674022E-40 
					                                     f32_4 %149 = OpConstantComposite %148 %148 %148 %148 
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
					                               Uniform f32* %91 = OpAccessChain %32 %90 
					                                        f32 %92 = OpLoad %91 
					                               Private f32* %93 = OpAccessChain %79 %26 
					                                        f32 %94 = OpLoad %93 
					                                       bool %95 = OpFOrdLessThan %92 %94 
					                                                    OpStore %89 %95 
					                                       bool %96 = OpLoad %89 
					                                                    OpSelectionMerge %98 None 
					                                                    OpBranchConditional %96 %97 %126 
					                                            %97 = OpLabel 
					                                     f32_4 %102 = OpLoad %74 
					                                     f32_3 %103 = OpVectorShuffle %102 %102 0 1 2 
					                                     f32_4 %104 = OpLoad %74 
					                                     f32_3 %105 = OpVectorShuffle %104 %104 0 1 2 
					                                     f32_3 %106 = OpFAdd %103 %105 
					                                     f32_4 %107 = OpLoad %100 
					                                     f32_4 %108 = OpVectorShuffle %107 %106 4 5 6 3 
					                                                    OpStore %100 %108 
					                              Private f32* %109 = OpAccessChain %9 %26 
					                                       f32 %110 = OpLoad %109 
					                              Private f32* %111 = OpAccessChain %9 %26 
					                                       f32 %112 = OpLoad %111 
					                                       f32 %113 = OpFAdd %110 %112 
					                              Private f32* %114 = OpAccessChain %100 %42 
					                                                    OpStore %114 %113 
					                                     f32_4 %115 = OpLoad %100 
					                            Uniform f32_4* %118 = OpAccessChain %32 %116 
					                                     f32_4 %119 = OpLoad %118 
					                                     f32_4 %120 = OpVectorShuffle %119 %119 3 3 3 3 
					                                     f32_4 %121 = OpFMul %115 %120 
					                                                    OpStore %100 %121 
					                                     f32_4 %124 = OpLoad %100 
					                                                    OpStore %123 %124 
					                                                    OpReturn
					                                           %126 = OpLabel 
					                                     f32_2 %128 = OpLoad %79 
					                                     f32_4 %129 = OpVectorShuffle %128 %128 1 1 1 1 
					                            Uniform f32_4* %130 = OpAccessChain %32 %116 
					                                     f32_4 %131 = OpLoad %130 
					                                     f32_4 %132 = OpFMul %129 %131 
					                                                    OpStore %127 %132 
					                                     f32_4 %134 = OpLoad %127 
					                                     f32_3 %135 = OpVectorShuffle %134 %134 0 1 2 
					                                     f32_4 %136 = OpLoad %74 
					                                     f32_3 %137 = OpVectorShuffle %136 %136 0 1 2 
					                                     f32_3 %138 = OpFMul %135 %137 
					                                     f32_4 %139 = OpLoad %133 
					                                     f32_4 %140 = OpVectorShuffle %139 %138 4 5 6 3 
					                                                    OpStore %133 %140 
					                              Private f32* %141 = OpAccessChain %9 %26 
					                                       f32 %142 = OpLoad %141 
					                              Private f32* %143 = OpAccessChain %127 %42 
					                                       f32 %144 = OpLoad %143 
					                                       f32 %145 = OpFMul %142 %144 
					                              Private f32* %146 = OpAccessChain %133 %42 
					                                                    OpStore %146 %145 
					                                     f32_4 %147 = OpLoad %133 
					                                     f32_4 %150 = OpFMul %147 %149 
					                                                    OpStore %123 %150 
					                                                    OpReturn
					                                            %98 = OpLabel 
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
					; Bound: 153
					; Schema: 0
					                                                    OpCapability Shader 
					                                             %1 = OpExtInstImport "GLSL.std.450" 
					                                                    OpMemoryModel Logical GLSL450 
					                                                    OpEntryPoint Fragment %4 "main" %12 %74 %83 %123 
					                                                    OpExecutionMode %4 OriginUpperLeft 
					                                                    OpDecorate %12 Location 12 
					                                                    OpDecorate %21 DescriptorSet 21 
					                                                    OpDecorate %21 Binding 21 
					                                                    OpMemberDecorate %30 0 Offset 30 
					                                                    OpMemberDecorate %30 1 RelaxedPrecision 
					                                                    OpMemberDecorate %30 1 Offset 30 
					                                                    OpMemberDecorate %30 2 Offset 30 
					                                                    OpMemberDecorate %30 3 Offset 30 
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
					                                                    OpDecorate %94 RelaxedPrecision 
					                                                    OpDecorate %102 RelaxedPrecision 
					                                                    OpDecorate %103 RelaxedPrecision 
					                                                    OpDecorate %104 RelaxedPrecision 
					                                                    OpDecorate %105 RelaxedPrecision 
					                                                    OpDecorate %106 RelaxedPrecision 
					                                                    OpDecorate %119 RelaxedPrecision 
					                                                    OpDecorate %120 RelaxedPrecision 
					                                                    OpDecorate %123 RelaxedPrecision 
					                                                    OpDecorate %123 Location 123 
					                                                    OpDecorate %127 RelaxedPrecision 
					                                                    OpDecorate %128 RelaxedPrecision 
					                                                    OpDecorate %129 RelaxedPrecision 
					                                                    OpDecorate %131 RelaxedPrecision 
					                                                    OpDecorate %132 RelaxedPrecision 
					                                                    OpDecorate %133 RelaxedPrecision 
					                                                    OpDecorate %134 RelaxedPrecision 
					                                                    OpDecorate %135 RelaxedPrecision 
					                                                    OpDecorate %136 RelaxedPrecision 
					                                                    OpDecorate %137 RelaxedPrecision 
					                                                    OpDecorate %138 RelaxedPrecision 
					                                                    OpDecorate %144 RelaxedPrecision 
					                                                    OpDecorate %147 RelaxedPrecision 
					                                                    OpDecorate %150 RelaxedPrecision 
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
					                                            %30 = OpTypeStruct %10 %10 %6 %6 
					                                            %31 = OpTypePointer Uniform %30 
					  Uniform struct {f32_4; f32_4; f32; f32;}* %32 = OpVariable Uniform 
					                                            %33 = OpTypeInt 32 1 
					                                        i32 %34 = OpConstant 0 
					                                        u32 %35 = OpConstant 2 
					                                            %36 = OpTypePointer Uniform %6 
					                                        u32 %42 = OpConstant 3 
					                                        f32 %47 = OpConstant 3.674022E-40 
					                                            %54 = OpTypePointer Input %6 
					                                        i32 %62 = OpConstant 3 
					                                        f32 %69 = OpConstant 3.674022E-40 
					                               Input f32_4* %74 = OpVariable Input 
					                             Private f32_2* %79 = OpVariable Private 
					UniformConstant read_only Texture2DSampled* %80 = OpVariable UniformConstant 
					                                            %82 = OpTypePointer Input %7 
					                               Input f32_2* %83 = OpVariable Input 
					                                            %87 = OpTypeBool 
					                                            %88 = OpTypePointer Private %87 
					                              Private bool* %89 = OpVariable Private 
					                                        i32 %90 = OpConstant 2 
					                                            %99 = OpTypePointer Private %10 
					                            Private f32_4* %100 = OpVariable Private 
					                                           %101 = OpTypeVector %6 3 
					                                       i32 %116 = OpConstant 1 
					                                           %117 = OpTypePointer Uniform %10 
					                                           %122 = OpTypePointer Output %10 
					                             Output f32_4* %123 = OpVariable Output 
					                            Private f32_4* %127 = OpVariable Private 
					                            Private f32_4* %133 = OpVariable Private 
					                                       f32 %148 = OpConstant 3.674022E-40 
					                                     f32_4 %149 = OpConstantComposite %148 %148 %148 %148 
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
					                               Uniform f32* %91 = OpAccessChain %32 %90 
					                                        f32 %92 = OpLoad %91 
					                               Private f32* %93 = OpAccessChain %79 %26 
					                                        f32 %94 = OpLoad %93 
					                                       bool %95 = OpFOrdLessThan %92 %94 
					                                                    OpStore %89 %95 
					                                       bool %96 = OpLoad %89 
					                                                    OpSelectionMerge %98 None 
					                                                    OpBranchConditional %96 %97 %126 
					                                            %97 = OpLabel 
					                                     f32_4 %102 = OpLoad %74 
					                                     f32_3 %103 = OpVectorShuffle %102 %102 0 1 2 
					                                     f32_4 %104 = OpLoad %74 
					                                     f32_3 %105 = OpVectorShuffle %104 %104 0 1 2 
					                                     f32_3 %106 = OpFAdd %103 %105 
					                                     f32_4 %107 = OpLoad %100 
					                                     f32_4 %108 = OpVectorShuffle %107 %106 4 5 6 3 
					                                                    OpStore %100 %108 
					                              Private f32* %109 = OpAccessChain %9 %26 
					                                       f32 %110 = OpLoad %109 
					                              Private f32* %111 = OpAccessChain %9 %26 
					                                       f32 %112 = OpLoad %111 
					                                       f32 %113 = OpFAdd %110 %112 
					                              Private f32* %114 = OpAccessChain %100 %42 
					                                                    OpStore %114 %113 
					                                     f32_4 %115 = OpLoad %100 
					                            Uniform f32_4* %118 = OpAccessChain %32 %116 
					                                     f32_4 %119 = OpLoad %118 
					                                     f32_4 %120 = OpVectorShuffle %119 %119 3 3 3 3 
					                                     f32_4 %121 = OpFMul %115 %120 
					                                                    OpStore %100 %121 
					                                     f32_4 %124 = OpLoad %100 
					                                                    OpStore %123 %124 
					                                                    OpReturn
					                                           %126 = OpLabel 
					                                     f32_2 %128 = OpLoad %79 
					                                     f32_4 %129 = OpVectorShuffle %128 %128 1 1 1 1 
					                            Uniform f32_4* %130 = OpAccessChain %32 %116 
					                                     f32_4 %131 = OpLoad %130 
					                                     f32_4 %132 = OpFMul %129 %131 
					                                                    OpStore %127 %132 
					                                     f32_4 %134 = OpLoad %127 
					                                     f32_3 %135 = OpVectorShuffle %134 %134 0 1 2 
					                                     f32_4 %136 = OpLoad %74 
					                                     f32_3 %137 = OpVectorShuffle %136 %136 0 1 2 
					                                     f32_3 %138 = OpFMul %135 %137 
					                                     f32_4 %139 = OpLoad %133 
					                                     f32_4 %140 = OpVectorShuffle %139 %138 4 5 6 3 
					                                                    OpStore %133 %140 
					                              Private f32* %141 = OpAccessChain %9 %26 
					                                       f32 %142 = OpLoad %141 
					                              Private f32* %143 = OpAccessChain %127 %42 
					                                       f32 %144 = OpLoad %143 
					                                       f32 %145 = OpFMul %142 %144 
					                              Private f32* %146 = OpAccessChain %133 %42 
					                                                    OpStore %146 %145 
					                                     f32_4 %147 = OpLoad %133 
					                                     f32_4 %150 = OpFMul %147 %149 
					                                                    OpStore %123 %150 
					                                                    OpReturn
					                                            %98 = OpLabel 
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
﻿// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'
// shader的名字，用斜杆分开便于查找
Shader "Unity Shaders Book/Chapter 5/Simple Shader" {
	// Properties 可要可不要
	Properties {
		_Color ("Color Tint", Color) = (1, 1, 1, 1)
	}
	//
	SubShader {
        Pass {
            // CGPROGRAM ENDC之间是代码
            CGPROGRAM
            
            // 指定顶点着色器函数的名字
            #pragma vertex vert
            // 指定片着色器函数的名字
            #pragma fragment frag
            
            uniform fixed4 _Color;

			struct a2v {
                float4 vertex : POSITION;
				float3 normal : NORMAL;
				float4 texcoord : TEXCOORD0;
            };
            
            struct v2f {
                float4 pos : SV_POSITION;
                fixed3 color : COLOR0;
            };
            
            v2f vert(a2v v) {
            	v2f o;
            	o.pos = UnityObjectToClipPos(v.vertex);
            	o.color = v.normal * 0.5 + fixed3(0.5, 0.5, 0.5);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target {
            	fixed3 c = i.color;
            	c *= _Color.rgb;
                return fixed4(c, 1.0);
            }

            ENDCG
        }
    }
}

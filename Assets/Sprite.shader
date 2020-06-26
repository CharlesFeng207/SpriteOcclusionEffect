Shader "Test/Sprite"
{
	Properties
	{
		_MainTex("Sprite Texture", 2D) = "black" {}
		_OcclusionColor("OcclusionColor", Color) = ( 1, 1, 1, 1 )
	}

	SubShader
	{
		Tags
		{
			"Queue" = "Transparent"
			"IgnoreProjector" = "True"
			"RenderType" = "Transparent"
			"CanUseSpriteAtlas" = "True"
		}

		Cull Off
		Lighting Off
		ZWrite Off
		ZTest On

		Blend SrcAlpha OneMinusSrcAlpha

		Pass
		{
		   Stencil
          {
              Ref 4
              Comp NotEqual
          }

			CGPROGRAM
			#pragma vertex SpriteVertEx
			#pragma fragment SpriteFragEx
			#pragma target 2.0
			#pragma multi_compile_local __ SATURATION_ON
			#pragma multi_compile_local __ SCREEN_COLOR_ON
			#include "UnityCG.cginc"

			sampler2D _MainTex;
			float4 _MainTex_ST;

			struct appdata
			{
				float4 vertex   : POSITION;
				float4 color    : COLOR;
				float2 texcoord : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex   : SV_POSITION;
				float4 color    : COLOR;
				float2 texcoord : TEXCOORD0;
			};

			v2f SpriteVertEx(appdata IN)
			{
				v2f OUT;

				OUT.vertex = UnityObjectToClipPos(IN.vertex);
				OUT.texcoord = TRANSFORM_TEX(IN.texcoord, _MainTex);
				OUT.color = IN.color;
				OUT.texcoord = OUT.texcoord;
				return OUT;
			}

			fixed4 SpriteFragEx(v2f IN) : SV_Target
			{
				fixed4 col = tex2D(_MainTex, IN.texcoord);
                col *= IN.color;
				return col;
			}
			ENDCG
		}

		Pass
		{
		    Stencil
            {
                Ref 4
                Comp Equal
            }

			CGPROGRAM
			#pragma vertex SpriteVertEx
			#pragma fragment SpriteFragEx
			#pragma target 2.0
			#pragma multi_compile_local __ SATURATION_ON
			#pragma multi_compile_local __ SCREEN_COLOR_ON
			#include "UnityCG.cginc"

			sampler2D _MainTex;
			float4 _MainTex_ST;

			fixed4 _OcclusionColor;

			struct appdata
			{
				float4 vertex   : POSITION;
				float4 color    : COLOR;
				float2 texcoord : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex   : SV_POSITION;
				float4 color    : COLOR;
				float2 texcoord : TEXCOORD0;
			};

			v2f SpriteVertEx(appdata IN)
			{
				v2f OUT;

				OUT.vertex = UnityObjectToClipPos(IN.vertex);
				OUT.texcoord = TRANSFORM_TEX(IN.texcoord, _MainTex);
				OUT.color = IN.color;
				OUT.texcoord = OUT.texcoord;
				return OUT;
			}

			fixed4 SpriteFragEx(v2f IN) : SV_Target
			{
				fixed4 col = tex2D(_MainTex, IN.texcoord);
				col *= IN.color * _OcclusionColor;
				return col;
			}
			ENDCG
		}
	}
}

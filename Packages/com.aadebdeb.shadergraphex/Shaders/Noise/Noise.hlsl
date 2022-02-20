#ifndef EX_NOISE_INCLUDED
#define EX_NOISE_INCLUDED

// ref: https://www.shadertoy.com/view/WttXWX
uint hashui(uint x) {
    x ^= x >> 16;
    x *= 0x7feb352dU;
    x ^= x >> 15;
    x *= 0x846ca68bU;
    x ^= x >> 16;
    return x;
}

uint hashui(uint2 x) {
    return hashui(x.x + hashui(x.y));
}

uint hashui(uint3 x) {
    return hashui(x.x + hashui(x.y + hashui(x.z)));
}

uint hashui(uint4 x) {
    return hashui(x.x + hashui(x.y + hashui(x.z + hashui(x.w))));
}

float hash(uint x) {
    return hashui(x) / float(0xffffffffU);
}

float hash(uint2 x) {
    return hashui(x) / float(0xffffffffU);
}

float hash(uint3 x) {
    return hashui(x) / float(0xffffffffU);
}

float hash(uint4 x) {
    return hashui(x) / float(0xffffffffU);
}

float hash(int x) {
    return hash(asuint(x));
}

float hash(int2 x) {
    return hash(uint2(asuint(x.x), asuint(x.y)));
}

float hash(int3 x) {
    return hash(uint3(asuint(x.x), asuint(x.y), asuint(x.z)));
}

float hash(int4 x) {
    return hash(uint4(asuint(x.x), asuint(x.y), asuint(x.z), asuint(x.w)));
}

float hash(float x) {
    return hash(asuint(x));
}

float hash(float2 x) {
    return hash(uint2(asuint(x.x), asuint(x.y)));
}

float hash(float3 x) {
    return hash(uint3(asuint(x.x), asuint(x.y), asuint(x.z)));
}

float hash(float4 x) {
    return hash(uint4(asuint(x.x), asuint(x.y), asuint(x.z), asuint(x.w)));
}

float2 hash2(float2 x) {
    return float2(hash(x), hash(x + 1.0));
}

float3 hash3(float3 x) {
    return float3(hash(x), hash(x + 1.0), hash(x + 2.0));
}

float4 hash4(float4 x) {
    return float4(hash(x), hash(x + 1.0), hash(x + 2.0), hash(x + 3.0));
}

float vnoise(float p) {
    int i = floor(p);
    float f = frac(p);

    float v0 = hash(i);
    float v1 = hash(i + 1);

    float t = f * f * (3 - (2 * f));

    return lerp(v0, v1, t);
}

float vnoise(float2 p) {
    int2 i = floor(p);
    float2 f = frac(p);

    float v00 = hash(i);
    float v10 = hash(i + int2(1, 0));
    float v01 = hash(i + int2(0, 1));
    float v11 = hash(i + int2(1, 1));

    float2 t = f * f * (3 - (2 * f));

    return lerp(
        lerp(v00, v10, t.x),
        lerp(v01, v11, t.x),
        t.y
    );
}

float vnoise(float3 p) {
    int3 i = floor(p);
    float3 f = frac(p);

    float v000 = hash(i);
    float v100 = hash(i + int3(1, 0, 0));
    float v010 = hash(i + int3(0, 1, 0));
    float v110 = hash(i + int3(1, 1, 0));
    float v001 = hash(i + int3(0, 0, 1));
    float v101 = hash(i + int3(1, 0, 1));
    float v011 = hash(i + int3(0, 1, 1));
    float v111 = hash(i + int3(1, 1, 1));

    float3 t = f * f * (3 - (2 * f));

    return lerp(
        lerp(
            lerp(v000, v100, t.x),
            lerp(v010, v110, t.x),
            t.y
        ),
        lerp(
            lerp(v001, v101, t.x),
            lerp(v011, v111, t.x),
            t.y
        ),
        t.z
    );
}

float vnoise(float4 p) {
    int4 i = floor(p);
    float4 f = frac(p);

    float v0000 = hash(i);
    float v1000 = hash(i + int4(1, 0, 0, 0));
    float v0100 = hash(i + int4(0, 1, 0, 0));
    float v1100 = hash(i + int4(1, 1, 0, 0));
    float v0010 = hash(i + int4(0, 0, 1, 0));
    float v1010 = hash(i + int4(1, 0, 1, 0));
    float v0110 = hash(i + int4(0, 1, 1, 0));
    float v1110 = hash(i + int4(1, 1, 1, 0));
    float v0001 = hash(i + int4(0, 0, 0, 1));
    float v1001 = hash(i + int4(1, 0, 0, 1));
    float v0101 = hash(i + int4(0, 1, 0, 1));
    float v1101 = hash(i + int4(1, 1, 0, 1));
    float v0011 = hash(i + int4(0, 0, 1, 1));
    float v1011 = hash(i + int4(1, 0, 1, 1));
    float v0111 = hash(i + int4(0, 1, 1, 1));
    float v1111 = hash(i + int4(1, 1, 1, 1));

    float4 t = f * f * (3 - (2 * f));

    return lerp(
        lerp(
            lerp(
                lerp(v0000, v1000, t.x),
                lerp(v0100, v1100, t.x),
                t.y
            ),
            lerp(
                lerp(v0010, v1010, t.x),
                lerp(v0110, v1110, t.x),
                t.y
            ),
            t.z
        ),
        lerp(
            lerp(
                lerp(v0001, v1001, t.x),
                lerp(v0101, v1101, t.x),
                t.y
            ),
            lerp(
                lerp(v0011, v1011, t.x),
                lerp(v0111, v1111, t.x),
                t.y
            ),
            t.z
        ),
        t.w
    );
}

float pnoise(float2 p) {
    int2 i = floor(p);
    float2 f = frac(p);

    int2 i00 = i;
    int2 i10 = i + int2(1, 0);
    int2 i01 = i + int2(0, 1);
    int2 i11 = i + int2(1, 1);

    float2 f00 = f;
    float2 f10 = f - float2(1, 0);
    float2 f01 = f - float2(0, 1);
    float2 f11 = f - float2(1, 1);

    float2 g00 = normalize(hash2(i00) * 2 - 1);
    float2 g10 = normalize(hash2(i10) * 2 - 1);
    float2 g01 = normalize(hash2(i01) * 2 - 1);
    float2 g11 = normalize(hash2(i11) * 2 - 1);

    float d00 = dot(f00, g00);
    float d10 = dot(f10, g10);
    float d01 = dot(f01, g01);
    float d11 = dot(f11, g11);

   float2 t = f * f * (3 - (2 * f));

    return lerp(
        lerp(d00, d10, t.x),
        lerp(d01, d11, t.x),
        t.y
    );
}

float pnoise(float3 p) {
    int3 i = floor(p);
    float3 f = frac(p);

    int3 i000 = i;
    int3 i100 = i + int3(1, 0, 0);
    int3 i010 = i + int3(0, 1, 0);
    int3 i110 = i + int3(1, 1, 0);
    int3 i001 = i + int3(0, 0, 1);
    int3 i101 = i + int3(1, 0, 1);
    int3 i011 = i + int3(0, 1, 1);
    int3 i111 = i + int3(1, 1, 1);

    float3 f000 = f;
    float3 f100 = f - float3(1, 0, 0);
    float3 f010 = f - float3(0, 1, 0);
    float3 f110 = f - float3(1, 1, 0);
    float3 f001 = f - float3(0, 0, 1);
    float3 f101 = f - float3(1, 0, 1);
    float3 f011 = f - float3(0, 1, 1);
    float3 f111 = f - float3(1, 1, 1);

    float3 g000 = normalize(hash3(i000) * 2 - 1);
    float3 g100 = normalize(hash3(i100) * 2 - 1);
    float3 g010 = normalize(hash3(i010) * 2 - 1);
    float3 g110 = normalize(hash3(i110) * 2 - 1);
    float3 g001 = normalize(hash3(i001) * 2 - 1);
    float3 g101 = normalize(hash3(i101) * 2 - 1);
    float3 g011 = normalize(hash3(i011) * 2 - 1);
    float3 g111 = normalize(hash3(i111) * 2 - 1);

    float d000 = dot(f000, g000);
    float d100 = dot(f100, g100);
    float d010 = dot(f010, g010);
    float d110 = dot(f110, g110);
    float d001 = dot(f001, g001);
    float d101 = dot(f101, g101);
    float d011 = dot(f011, g011);
    float d111 = dot(f111, g111);

    float3 t = f * f * (3 - (2 * f));

    return lerp(
        lerp(
            lerp(d000, d100, t.x),
            lerp(d010, d110, t.x),
            t.y
        ),
        lerp(
            lerp(d001, d101, t.x),
            lerp(d011, d111, t.x),
            t.y
        ),
        t.z
    );
}

float pnoise(float4 p) {
    int4 i = floor(p);
    float4 f = frac(p);

    int4 i0000 = i;
    int4 i1000 = i + int4(1, 0, 0, 0);
    int4 i0100 = i + int4(0, 1, 0, 0);
    int4 i1100 = i + int4(1, 1, 0, 0);
    int4 i0010 = i + int4(0, 0, 1, 0);
    int4 i1010 = i + int4(1, 0, 1, 0);
    int4 i0110 = i + int4(0, 1, 1, 0);
    int4 i1110 = i + int4(1, 1, 1, 0);
    int4 i0001 = i + int4(0, 0, 0, 1);
    int4 i1001 = i + int4(1, 0, 0, 1);
    int4 i0101 = i + int4(0, 1, 0, 1);
    int4 i1101 = i + int4(1, 1, 0, 1);
    int4 i0011 = i + int4(0, 0, 1, 1);
    int4 i1011 = i + int4(1, 0, 1, 1);
    int4 i0111 = i + int4(0, 1, 1, 1);
    int4 i1111 = i + int4(1, 1, 1, 1);

    float4 f0000 = f;
    float4 f1000 = f - float4(1, 0, 0, 0);
    float4 f0100 = f - float4(0, 1, 0, 0);
    float4 f1100 = f - float4(1, 1, 0, 0);
    float4 f0010 = f - float4(0, 0, 1, 0);
    float4 f1010 = f - float4(1, 0, 1, 0);
    float4 f0110 = f - float4(0, 1, 1, 0);
    float4 f1110 = f - float4(1, 1, 1, 0);
    float4 f0001 = f - float4(0, 0, 0, 1);
    float4 f1001 = f - float4(1, 0, 0, 1);
    float4 f0101 = f - float4(0, 1, 0, 1);
    float4 f1101 = f - float4(1, 1, 0, 1);
    float4 f0011 = f - float4(0, 0, 1, 1);
    float4 f1011 = f - float4(1, 0, 1, 1);
    float4 f0111 = f - float4(0, 1, 1, 1);
    float4 f1111 = f - float4(1, 1, 1, 1);

    float4 g0000 = normalize(hash4(i0000) * 2 - 1);
    float4 g1000 = normalize(hash4(i1000) * 2 - 1);
    float4 g0100 = normalize(hash4(i0100) * 2 - 1);
    float4 g1100 = normalize(hash4(i1100) * 2 - 1);
    float4 g0010 = normalize(hash4(i0010) * 2 - 1);
    float4 g1010 = normalize(hash4(i1010) * 2 - 1);
    float4 g0110 = normalize(hash4(i0110) * 2 - 1);
    float4 g1110 = normalize(hash4(i1110) * 2 - 1);
    float4 g0001 = normalize(hash4(i0001) * 2 - 1);
    float4 g1001 = normalize(hash4(i1001) * 2 - 1);
    float4 g0101 = normalize(hash4(i0101) * 2 - 1);
    float4 g1101 = normalize(hash4(i1101) * 2 - 1);
    float4 g0011 = normalize(hash4(i0011) * 2 - 1);
    float4 g1011 = normalize(hash4(i1011) * 2 - 1);
    float4 g0111 = normalize(hash4(i0111) * 2 - 1);
    float4 g1111 = normalize(hash4(i1111) * 2 - 1);

    float d0000 = dot(f0000, g0000);
    float d1000 = dot(f1000, g1000);
    float d0100 = dot(f0100, g0100);
    float d1100 = dot(f1100, g1100);
    float d0010 = dot(f0010, g0010);
    float d1010 = dot(f1010, g1010);
    float d0110 = dot(f0110, g0110);
    float d1110 = dot(f1110, g1110);

    float d0001 = dot(f0001, g0001);
    float d1001 = dot(f1001, g1001);
    float d0101 = dot(f0101, g0101);
    float d1101 = dot(f1101, g1101);
    float d0011 = dot(f0011, g0011);
    float d1011 = dot(f1011, g1011);
    float d0111 = dot(f0111, g0111);
    float d1111 = dot(f1111, g1111);

    float4 t = f * f * (3 - (2 * f));

    return lerp(
        lerp(
            lerp(
                lerp(d0000, d1000, t.x),
                lerp(d0100, d1100, t.x),
                t.y
            ),
            lerp(
                lerp(d0010, d1010, t.x),
                lerp(d0110, d1110, t.x),
                t.y
            ),
            t.z
        ),
        lerp(
            lerp(
                lerp(d0001, d1001, t.x),
                lerp(d0101, d1101, t.x),
                t.y
            ),
            lerp(
                lerp(d0011, d1011, t.x),
                lerp(d0111, d1111, t.x),
                t.y
            ),
            t.z
        ),
        t.w
    );
}

// Description : Array and textureless GLSL 2D/3D/4D simplex 
//               noise functions.
//      Author : Ian McEwan, Ashima Arts.
//  Maintainer : stegu
//     Lastmod : 20201014 (stegu)
//     License : Copyright (C) 2011 Ashima Arts. All rights reserved.
//               Distributed under the MIT License. See LICENSE file.
//               https://github.com/ashima/webgl-noise
//               https://github.com/stegu/webgl-noise
// https://github.com/ashima/webgl-noise/tree/master/src

float mod289(float x) {
    return x - floor(x * 0.00346020761) * 289.0; // 0.00346020761 = 1.0 / 289.0
}

float2 mod289(float2 x) {
    return x - floor(x * 0.00346020761) * 289.0; // 0.00346020761 = 1.0 / 289.0
}

float3 mod289(float3 x) {
    return x - floor(x * 0.00346020761) * 289.0; // 0.00346020761 = 1.0 / 289.0
}

float4 mod289(float4 x) {
    return x - floor(x * 0.00346020761) * 289.0; // 0.00346020761 = 1.0 / 289.0
}

float permute(float x) {
    return mod289(((x * 34.0) + 10.0) * x);
}

float3 permute(float3 x) {
    return mod289(((x * 34.0) + 10.0) * x);
}

float4 permute(float4 x) {
    return mod289(((x * 34.0) + 10.0) * x);
}

float4 taylorInvSqrt(float4 r) {
  return 1.79284291400159 - 0.85373472095314 * r;
}

float lt(float a, float b) {
    return a < b ? 1.0 : 0.0;
}
float4 lessThan(float4 a, float4 b) {
    return float4(lt(a.x, b.x), lt(a.y,b.y),lt(a.z, b.z),lt(a.w, b.w));
}


float4 grad4(float j, float4 ip) {
    const float4 ones = float4(1, 1, 1, 1);
    float4 p, s;
    p.xyz = floor(frac(float3(j, j, j) * ip.xyz) * 7.0) * ip.z - 1.0;
    p.w = 1.5 - dot(abs(p.xyz), ones.xyz);
    s = float4(lessThan(p, float4(0.0, 0.0, 0.0, 0.0)));
    p.xyz = p.xyz + (s.xyz * 2.0 - 1.0) * s.www;
    return p;
}

float snoise(float2 v) {
    const float4 c = float4(0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439);

    float2 i = floor(v + dot(v, c.yy));
    float2 x0 = v - i + dot(i, c.xx);

    float2 i1 = (x0.x > x0.y) ? float2(1.0, 0.0) : float2(0.0, 1.0);
    float4 x12 = x0.xyxy + c.xxzz;
    x12.xy -=i1;

    i = mod289(i);
    float3 p = permute(permute(i.y + float3(0, i1.y, 1)) + i.x + float3(0, i1.x, 1));
    float3 m = max(0.5 - float3(dot(x0, x0), dot(x12.xy, x12.xy), dot(x12.zw, x12.zw)), 0);
    m = m * m;
    m = m * m;

    float3 x = 2 * frac(p * c.www) - 1;
    float3 h = abs(x) - 0.5;
    float3 ox = floor(x + 0.5);
    float3 a0 = x - ox;

    m *= 1.79284291400159 - 0.85373472095314 * (a0 * a0 + h * h);

    float3 g;
    g.x = a0.x * x0.x + h.x * x0.y;
    g.yz = a0.yz * x12.xz + h.yz * x12.yw;
    return 130.0 * dot(m, g);
}

float snoise(float3 v) {
    const float2 c = float2(1.0 / 6.0, 1.0 / 3.0);
    const float4 d = float4(0.0, 0.5, 1.0, 2.0);

    float3 i = floor(v + dot(v, c.yyy));
    float3 x0 = v - i + dot(i, c.xxx);

    float3 g = step(x0.yzx, x0.xyz);
    float3 l = 1.0 - g;
    float3 i1 = min(g.xyz, l.zxy);
    float3 i2 = max(g.xyz, l.zxy);

    float3 x1 = x0 - i1 + c.xxx;
    float3 x2 = x0 - i2 + c.yyy;
    float3 x3 = x0 - d.yyy;

    i = mod289(i);
    float4 p = permute(permute(permute(
        i.z + float4(0.0, i1.z, i2.z, 1.0)) +
        i.y + float4(0.0, i1.y, i2.y, 1.0)) +
        i.x + float4(0.0, i1.x, i2.x, 1.0));

    float n_ = 0.142857142857;
    float3 ns = n_ * d.wyz - d.xzx;

    float4 j = p - 49.0 * floor(p * ns.z * ns.z);

    float4 x_ = floor(j * ns.z);
    float4 y_ = floor(j - 7.0 * x_);

    float4 x = x_ * ns.x + ns.yyyy;
    float4 y = y_ * ns.x + ns.yyyy;
    float4 h = 1.0 - abs(x) - abs(y);

    float4 b0 = float4(x.xy, y.xy);
    float4 b1 = float4(x.zw, y.zw);

    float4 s0 = floor(b0) * 2.0 + 1.0;
    float4 s1 = floor(b1) * 2.0 + 1.0;
    float4 sh = -step(h, float4(0.0, 0.0, 0.0, 0.0));

    float4 a0 = b0.xzyw + s0.xzyw * sh.xxyy;
    float4 a1 = b1.xzyw + s1.xzyw * sh.zzww;

    float3 p0 = float3(a0.xy, h.x);
    float3 p1 = float3(a0.zw, h.y);
    float3 p2 = float3(a1.xy, h.z);
    float3 p3 = float3(a1.zw, h.w);

    float4 norm = taylorInvSqrt(float4(dot(p0, p0), dot(p1, p1), dot(p2, p2), dot(p3, p3)));
    p0 *= norm.x;
    p1 *= norm.y;
    p2 *= norm.z;
    p3 *= norm.w;

    float4 m = max(0.5 - float4(dot(x0, x0), dot(x1, x1), dot(x2, x2), dot(x3, x3)), 0.0);
    m = m * m;
    return 105.0 * dot(m * m, float4(dot(p0, x0), dot(p1, x1), dot(p2, x2), dot(p3, x3)));
}

float snoise(float4 v) {
    const float4 c = float4(0.138196601125011, 0.276393202250021, 0.414589803375032, -0.447213595499958);
    const float f4 = 0.309016994374947451;

    float4 i = floor(v + dot(v, float4(f4, f4, f4, f4)));
    float4 x0 = v - i + dot(i, c.xxxx);

    float4 i0;
    float3 isX = step(x0.yzw, x0.xxx);
    float3 isYZ = step(x0.zww, x0.yyz);
    i0.x = isX.x + isX.y + isX.z;
    i0.yzw = 1.0 - isX;
    i0.y += isYZ.x + isYZ.y;
    i0.zw += 1.0 - isYZ.xy;
    i0.z += isYZ.z;
    i0.w += 1.0 - isYZ.z;

    float4 i3 = clamp(i0, 0.0, 1.0);
    float4 i2 = clamp(i0 - 1.0, 0.0, 1.0);
    float4 i1 = clamp(i0 - 2.0, 0.0, 1.0);

    float4 x1 = x0 - i1 + c.xxxx;
    float4 x2 = x0 - i2 + c.yyyy;
    float4 x3 = x0 - i3 + c.zzzz;
    float4 x4 = x0 + c.wwww;

    i = mod289(i);
    float j0 = permute(permute(permute(permute(i.w) + i.z) + i.y) + i.x);
    float4 j1 = permute(permute(permute(permute(
        i.w + float4(i1.w, i2.w, i3.w, 1.0)) +
        i.z + float4(i1.z, i2.z, i3.z, 1.0)) +
        i.y + float4(i1.y, i2.y, i3.y, 1.0)) +
        i.x + float4(i1.x, i2.x, i3.x, 1.0));

    float4 ip = float4(1.0/294.0, 1.0/49.0, 1.0/7.0, 0.0);

    float4 p0 = grad4(j0, ip);
    float4 p1 = grad4(j1.x, ip);
    float4 p2 = grad4(j1.y, ip);
    float4 p3 = grad4(j1.z, ip);
    float4 p4 = grad4(j1.w, ip);

    float4 norm = taylorInvSqrt(float4(dot(p0, p0), dot(p1, p1), dot(p2, p2), dot(p3, p3)));
    p0 *= norm.x;
    p1 *= norm.y;
    p2 *= norm.z;
    p3 *= norm.w;
    p4 *= taylorInvSqrt(dot(p4, p4));

    float3 m0 = max(0.6 - float3(dot(x0, x0), dot(x1, x1), dot(x2, x2)), 0.0);
    float2 m1 = max(0.6 - float2(dot(x3, x3), dot(x4, x4)), 0.0);
    m0 = m0 * m0;
    m1 = m1 * m1;
    return 49.0 * (dot(m0 * m0, float3(dot(p0, x0), dot(p1, x1), dot(p2, x2)))
        + dot(m1 * m1, float2(dot(p3, x3), dot(p4, x4))));
}

float vfbm(float2 p, int octave, float lacunarity, float gain) {
    float v = 0;
    float amp = 0.5;
    for (int i = 0; i < octave; ++i) {
        v += amp * (2 * vnoise(p) - 1);
        p *= lacunarity;
        amp *= gain;
    }
    return v;
}

float vfbm(float3 p, int octave, float lacunarity, float gain) {
    float v = 0;
    float amp = 0.5;
    for (int i = 0; i < octave; ++i) {
        v += amp * (2 * vnoise(p) - 1);
        p *= lacunarity;
        amp *= gain;
    }
    return v;
}

float vfbm(float4 p, int octave, float lacunarity, float gain) {
    float v = 0;
    float amp = 0.5;
    for (int i = 0; i < octave; ++i) {
        v += amp * (2 * vnoise(p) - 1);
        p *= lacunarity;
        amp *= gain;
    }
    return v;
}

float pfbm(float2 p, int octave, float lacunarity, float gain) {
    float v = 0;
    float amp = 0.5;
    for (int i = 0; i < octave; ++i) {
        v += amp * pnoise(p);
        p *= lacunarity;
        amp *= gain;
    }
    return v;
}

float pfbm(float3 p, int octave, float lacunarity, float gain) {
    float v = 0;
    float amp = 0.5;
    for (int i = 0; i < octave; ++i) {
        v += amp * pnoise(p);
        p *= lacunarity;
        amp *= gain;
    }
    return v;
}

float pfbm(float4 p, int octave, float lacunarity, float gain) {
    float v = 0;
    float amp = 0.5;
    for (int i = 0; i < octave; ++i) {
        v += amp * pnoise(p);
        p *= lacunarity;
        amp *= gain;
    }
    return v;
}

float sfbm(float2 p, int octave, float lacunarity, float gain) {
    float v = 0;
    float amp = 0.5;
    for (int i = 0; i < octave; ++i) {
        v += amp * snoise(p);
        p *= lacunarity;
        amp *= gain;
    }
    return v;
}

float sfbm(float3 p, int octave, float lacunarity, float gain) {
    float v = 0;
    float amp = 0.5;
    for (int i = 0; i < octave; ++i) {
        v += amp * snoise(p);
        p *= lacunarity;
        amp *= gain;
    }
    return v;
}

float sfbm(float4 p, int octave, float lacunarity, float gain) {
    float v = 0;
    float amp = 0.5;
    for (int i = 0; i < octave; ++i) {
        v += amp * snoise(p);
        p *= lacunarity;
        amp *= gain;
    }
    return v;
}

float vturb(float2 p, int octave, float lacunarity, float gain) {
    float v = 0;
    float amp = 0.5;
    for (int i = 0; i < octave; ++i) {
        v += amp * abs(2 * vnoise(p) - 1);
        p *= lacunarity;
        amp *= gain;
    }
    return v;
}

float vturb(float3 p, int octave, float lacunarity, float gain) {
    float v = 0;
    float amp = 0.5;
    for (int i = 0; i < octave; ++i) {
        v += amp * abs(2 * vnoise(p) - 1);
        p *= lacunarity;
        amp *= gain;
    }
    return v;
}

float vturb(float4 p, int octave, float lacunarity, float gain) {
    float v = 0;
    float amp = 0.5;
    for (int i = 0; i < octave; ++i) {
        v += amp * abs(2 * vnoise(p) - 1);
        p *= lacunarity;
        amp *= gain;
    }
    return v;
}

float pturb(float2 p, int octave, float lacunarity, float gain) {
    float v = 0;
    float amp = 0.5;
    for (int i = 0; i < octave; ++i) {
        v += amp * abs(pnoise(p));
        p *= lacunarity;
        amp *= gain;
    }
    return v;
}

float pturb(float3 p, int octave, float lacunarity, float gain) {
    float v = 0;
    float amp = 0.5;
    for (int i = 0; i < octave; ++i) {
        v += amp * abs(pnoise(p));
        p *= lacunarity;
        amp *= gain;
    }
    return v;
}

float pturb(float4 p, int octave, float lacunarity, float gain) {
    float v = 0;
    float amp = 0.5;
    for (int i = 0; i < octave; ++i) {
        v += amp * abs(pnoise(p));
        p *= lacunarity;
        amp *= gain;
    }
    return v;
}

float sturb(float2 p, int octave, float lacunarity, float gain) {
    float v = 0;
    float amp = 0.5;
    for (int i = 0; i < octave; ++i) {
        v += amp * abs(snoise(p));
        p *= lacunarity;
        amp *= gain;
    }
    return v;
}

float sturb(float3 p, int octave, float lacunarity, float gain) {
    float v = 0;
    float amp = 0.5;
    for (int i = 0; i < octave; ++i) {
        v += amp * abs(snoise(p));
        p *= lacunarity;
        amp *= gain;
    }
    return v;
}

float sturb(float4 p, int octave, float lacunarity, float gain) {
    float v = 0;
    float amp = 0.5;
    for (int i = 0; i < octave; ++i) {
        v += amp * abs(snoise(p));
        p *= lacunarity;
        amp *= gain;
    }
    return v;
}

void voronoi(float p, out float f1, out float f2, out int f1Index, out int f2Index) {
    int i = floor(p);
    f1 = f2 = 1e3;
    for (int x = -1; x <= 1; ++x) {
        int q = i + x;
        float d = abs(p - (q + hash(q)));
        if (d <= f1) {
            f2 = f1;
            f1 = d;
            f2Index = f1Index;
            f1Index = q;
        } else if (d <= f2) {
            f2 = d;
            f2Index = q;
        }
    }
}

void voronoi(float2 p, out float f1, out float f2, out int2 f1Index, out int2 f2Index) {
    int2 i = floor(p);
    f1 = f2 = 1e3;
    for (int x = -1; x <= 1; ++x) {
        for (int y = -1; y <= 1; ++y) {
            int2 q = i + int2(x, y);
            float d = distance(p, q + hash(q));
            if (d <= f1) {
                f2 = f1;
                f1 = d;
                f2Index = f1Index;
                f1Index = q;
            } else if (d <= f2) {
                f2 = d;
                f2Index = q;
            }
        }
    }
}

void voronoi(float3 p, out float f1, out float f2, out int3 f1Index, out int3 f2Index) {
    int3 i = floor(p);
    f1 = f2 = 1e3;
    for (int x = -1; x <= 1; ++x) {
        for (int y = -1; y <= 1; ++y) {
            for (int z = -1; z <= 1; ++z) {
                int3 q = i + int3(x, y, z);
                float d = distance(p, q + hash(q));
                if (d <= f1) {
                    f2 = f1;
                    f1 = d;
                    f2Index = f1Index;
                    f1Index = q;
                } else if (d <= f2) {
                    f2 = d;
                    f2Index = q;
                }
            }
        }
    }
}

void voronoi(float4 p, out float f1, out float f2, out int4 f1Index, out int4 f2Index) {
    int4 i = floor(p);
    f1 = f2 = 1e3;
    for (int x = -1; x <= 1; ++x) {
        for (int y = -1; y <= 1; ++y) {
            for (int z = -1; z <= 1; ++z) {
                for (int w = -1; w <= 1; ++w) {
                    int4 q = i + int4(x, y, z, w);
                    float d = distance(p, q + hash(q));
                    if (d <= f1) {
                        f2 = f1;
                        f1 = d;
                        f2Index = f1Index;
                        f1Index = q;
                    } else if (d <= f2) {
                        f2 = d;
                        f2Index = q;
                    }
                }
            }
        }
    }
}

void Hash1D_float(float Position, out float Value) {
    Value = hash(Position);
}

void Hash2D_float(float2 Position, out float Value) {
    Value = hash(Position);
}

void Hash3D_float(float3 Position, out float Value) {
    Value = hash(Position);
}

void Hash4D_float(float4 Position, out float Value) {
    Value = hash(Position);
}

void ValueNoise1D_float(float Position, out float Value) {
    Value = vnoise(Position);
}

void ValueNoise2D_float(float2 Position, out float Value) {
    Value = vnoise(Position);
}

void ValueNoise3D_float(float3 Position, out float Value) {
    Value = vnoise(Position);
}

void ValueNoise4D_float(float4 Position, out float Value) {
    Value = vnoise(Position);
}

void PerlinNoise2D_float(float2 Position, out float Value) {
    Value = pnoise(Position);
}

void PerlinNoise3D_float(float3 Position, out float Value) {
    Value = pnoise(Position);
}

void PerlinNoise4D_float(float4 Position, out float Value) {
    Value = pnoise(Position);
}

void SimplexNoise2D_float(float2 Position, out float Value) {
    Value = snoise(Position);
}

void SimplexNoise3D_float(float3 Position, out float Value) {
    Value = snoise(Position);
}

void SimplexNoise4D_float(float4 Position, out float Value) {
    Value = snoise(Position);
}

void FbmValue2D_float(
    float2 Position, int Octave, float Lacunarity, float Gain,
    out float Value
) {
    Value = vfbm(Position, Octave, Lacunarity, Gain);
}

void FbmValue3D_float(
    float3 Position, int Octave, float Lacunarity, float Gain,
    out float Value
) {
    Value = vfbm(Position, Octave, Lacunarity, Gain);
}

void FbmValue4D_float(
    float4 Position, int Octave, float Lacunarity, float Gain,
    out float Value
) {
    Value = vfbm(Position, Octave, Lacunarity, Gain);
}

void FbmPerlin2D_float(
    float2 Position, int Octave, float Lacunarity, float Gain,
    out float Value
) {
    Value = pfbm(Position, Octave, Lacunarity, Gain);
}

void FbmPerlin3D_float(
    float3 Position, int Octave, float Lacunarity, float Gain,
    out float Value
) {
    Value = pfbm(Position, Octave, Lacunarity, Gain);
}

void FbmPerlin4D_float(
    float4 Position, int Octave, float Lacunarity, float Gain,
    out float Value
) {
    Value = pfbm(Position, Octave, Lacunarity, Gain);
}

void FbmSimplex2D_float(
    float2 Position, int Octave, float Lacunarity, float Gain,
    out float Value
) {
    Value = sfbm(Position, Octave, Lacunarity, Gain);
}

void FbmSimplex3D_float(
    float3 Position, int Octave, float Lacunarity, float Gain,
    out float Value
) {
    Value = sfbm(Position, Octave, Lacunarity, Gain);
}

void FbmSimplex4D_float(
    float4 Position, int Octave, float Lacunarity, float Gain,
    out float Value
) {
    Value = sfbm(Position, Octave, Lacunarity, Gain);
}

void TurbulenceValue2D_float(
    float2 Position, int Octave, float Lacunarity, float Gain,
    out float Value
) {
    Value = vturb(Position, Octave, Lacunarity, Gain);
}

void TurbulenceValue3D_float(
    float3 Position, int Octave, float Lacunarity, float Gain,
    out float Value
) {
    Value = vturb(Position, Octave, Lacunarity, Gain);
}

void TurbulenceValue4D_float(
    float4 Position, int Octave, float Lacunarity, float Gain,
    out float Value
) {
    Value = vturb(Position, Octave, Lacunarity, Gain);
}

void TurbulencePerlin2D_float(
    float2 Position, int Octave, float Lacunarity, float Gain,
    out float Value
) {
    Value = pturb(Position, Octave, Lacunarity, Gain);
}

void TurbulencePerlin3D_float(
    float3 Position, int Octave, float Lacunarity, float Gain,
    out float Value
) {
    Value = pturb(Position, Octave, Lacunarity, Gain);
}

void TurbulencePerlin4D_float(
    float4 Position, int Octave, float Lacunarity, float Gain,
    out float Value
) {
    Value = pturb(Position, Octave, Lacunarity, Gain);
}

void TurbulenceSimplex2D_float(
    float2 Position, int Octave, float Lacunarity, float Gain,
    out float Value
) {
    Value = sturb(Position, Octave, Lacunarity, Gain);
}

void TurbulenceSimplex3D_float(
    float3 Position, int Octave, float Lacunarity, float Gain,
    out float Value
) {
    Value = sturb(Position, Octave, Lacunarity, Gain);
}

void TurbulenceSimplex4D_float(
    float4 Position, int Octave, float Lacunarity, float Gain,
    out float Value
) {
    Value = sturb(Position, Octave, Lacunarity, Gain);
}

void Voronoi1D_float(
    float Position,
    out float F1, out float F2, out float F1_Index, out float F2_Index
) {
    voronoi(Position, F1, F2, F1_Index, F2_Index);
}

void Voronoi2D_float(
    float2 Position,
    out float F1, out float F2, out float2 F1_Index, out float2 F2_Index
) {
    voronoi(Position, F1, F2, F1_Index, F2_Index);
}

void Voronoi3D_float(
    float3 Position,
    out float F1, out float F2, out float3 F1_Index, out float3 F2_Index
) {
    voronoi(Position, F1, F2, F1_Index, F2_Index);
}

void Voronoi4D_float(
    float4 Position,
    out float F1, out float F2, out float4 F1_Index, out float4 F2_Index
) {
    voronoi(Position, F1, F2, F1_Index, F2_Index);
}

#endif
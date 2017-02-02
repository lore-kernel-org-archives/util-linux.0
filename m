Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:57271 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751761AbdBBPEh (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 2 Feb 2017 10:04:37 -0500
Subject: [ping] Karel: Re: pull: hwclock 27 changes
To: Sami Kerola <kerolasa@iki.fi>
References: <20161231214107.8658-1-kerolasa@iki.fi>
 <05e4405f-8096-9261-f9f2-d2c6b84675bc@gmx.com>
 <070fc458-ed69-a09c-11cc-42bb50fec888@gmx.com>
 <alpine.LNX.2.20.1701072212010.9096@imuri>
 <a9d7f37b-3607-70d4-843a-7d934bd305d5@gmx.com>
 <alpine.LNX.2.20.1701112055190.2589@imuri>
 <ede34a46-7290-c68b-1dd8-e4fc356e5caf@gmx.com>
 <alpine.LNX.2.20.1701140930380.2049@imuri>
 <f723104e-d23b-f8fd-e9ee-b9fc82c86fd3@gmx.com>
 <c88dc7ee-3e18-19ec-612e-3788551517bb@gmx.com>
 <alpine.LNX.2.20.1701252136160.492@imuri>
 <5feac9a5-e3e3-5148-60a0-fb3197a1caa8@gmx.com>
Cc: util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <9798a869-fb09-77e7-a13a-bca002617672@gmx.com>
Date: Thu, 2 Feb 2017 10:04:13 -0500
MIME-Version: 1.0
In-Reply-To: <5feac9a5-e3e3-5148-60a0-fb3197a1caa8@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel,
I have some work to submit that applies on top of Sami's branch:

git://github.com/kerolasa/lelux-utiliteetit.git hwclock-jwp-reviewed

Outside of our ongoing discussion below regarding a 'technically
unnecessary' cast, I think Sami's work is ready for you to consider it
for committing. I would be interested in your thoughts on the cast.

On 01/26/2017 09:07 PM, J William Piggott wrote:
> 
> 
> On 01/25/2017 04:54 PM, Sami Kerola wrote:
>> On Sun, 22 Jan 2017, J William Piggott wrote:
>>> On 01/14/2017 05:51 PM, J William Piggott wrote:
>>>> On 01/14/2017 04:34 AM, Sami Kerola wrote:
>>>>> Preferably there should not be casts at all. But sometimes they are hard 
>>>>> to avoid, and then one should do as few casts as possible to avoid cutting 
>>>>> bits out.
>>>>>
>>>>> Think casting in terms of shape sorting toy. The more data is casted 
>>>>> through none-matching types the more the original shape is modified to fit 
>>>>> to storage where it is pushed.
>>>>>
>>>>> That is also the reason why casting to time_t in this case makes sense. 
>>>>> While it might be that right now, on systems we happen to use, int and 
>>>>> time_t are the same type there are no guarantees about other systems and 
>>>>> future. In practical terms; casting exactly to matching storage type is 
>>>>> the right way to avoid damaging data.
>>>>
>>>> What I'm trying to say is, assignment operators automatically convert
>>>> the right operand to the type of the left operand; making your cast
>>>> unnecessary. Try it, build hwclock with the cast. Now, remove the cast
>>>> and build it. The resulting binaries are bit for bit identical.
>>>>
>>>> ISO C11:
>>>> The type of an assignment expression is the type the left operand would have
>>>> after lvalue conversion.
>>>>
>>>> In simple assignment (=), the value of the right operand is converted to
>>>> the type of the assignment expression and replaces the value stored in
>>>> the object designated by the left operand.
>>>
>>> It wasn't the intent of my previous message to be offensive in any way,
>>> Sami. I was only trying to state my position using different language,
>>> so as not to simply repeat myself.
>>>
>>> Also, I'm not continuing this topic to be argumentative. The reason is
>>> for my own education. If my opinion is wrong, that is fine; I would like
>>> to understand why, so as to improve my own coding.
>>>
>>> As I further read the ISO C standard, I'm more convinced of my belief.
>>> It seems to me the compiler is required to use the type conversion
>>> routine associated with assignment operators, because it must yield two
>>> different results. A /qualified/ left operand type is stored, but the
>>> evaluation of the assignment expression returns an /unqualified/ left
>>> operand type. Since using the assignment operator's type conversion
>>> routine is required (if I'm correct), the compiler would ignore any cast
>>> on the results of the right hand operand for code optimization, yes?
>>>
>>> That seems to be true for my compiler, as the cast makes no difference
>>> in the resulting binary.
>>>
>>> If anyone knows the correct answer to this, I am very interested in
>>> learning it. Thank you in advance.
>>
>> Hi William,
>>
>> Sorry for late reply, I took a bit time off from reading / replying 
>> emails.
> 
> No worries Sami. I thought you might have been angry at something I
> wrote; it seem to unintentionally happen sometimes when talking across
> cultural borders.
> 
>>
>> Correct the cast that is in place now is technically unnecessary. Value of 
>> that cast is to remind return value type and storage type differ. Such 
>> assignments can, at least in theory, cause bugs so being explicit about 
>> them is a good thing. As a matter of fact anything that makes code easier 
>> to understand is welcome.
>>
>> That said now I doubt whether 'technically unnecessary' cast is really a 
>> thing that clarifies, but confuses code reader. Comments would be nice, 
>> meanwhile I will think about this.
>>
> 
> I understood the previous symbolism of the cast; to draw attention to
> dropping the fractional part of a variable. I don't perceive any value
> in using it on the floor(3) function.
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

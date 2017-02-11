Return-Path: elseifthen@gmx.com
From: J William Piggott <elseifthen@gmx.com>
Subject: Re: [ping] Karel: Re: pull: hwclock 27 changes
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
 <9798a869-fb09-77e7-a13a-bca002617672@gmx.com>
 <alpine.LNX.2.20.1702032223500.529@imuri>
Cc: util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>
Message-ID: <fbdbf7d9-ed28-79f7-b84c-2e20dbcc0fc3@gmx.com>
Date: Sat, 11 Feb 2017 12:10:17 -0500
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.20.1702032223500.529@imuri>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>



On 02/03/2017 05:41 PM, Sami Kerola wrote:
> On Thu, 2 Feb 2017, J William Piggott wrote:
> 
>> Karel,
>> I have some work to submit that applies on top of Sami's branch:
>>
>> git://github.com/kerolasa/lelux-utiliteetit.git hwclock-jwp-reviewed
> 
> Nice to hear.
> 
>> Outside of our ongoing discussion below regarding a 'technically
>> unnecessary' cast, I think Sami's work is ready for you to consider it
>> for committing. I would be interested in your thoughts on the cast.
> 
> I had a Friday conversation with my work colleagues and majority thought 
> that 'unnecessary cast' is good thing, as explicit a cast is visual 
> reminder of type change.
> 
> We did consider maintenance burden of these casts, but counter argument 
> was found to be difficult to object. It is true that unnecessary casts 
> cause unnecessary change when either function return value or storage unit 
> changes - but such changes do not happen often. Therefore weight of visual 
> reminder is heavier than an attempt to keep potential future diffs 
> minimal.
> 
> With one thing everyone agreed, these sorts of little things should not 
> get in way too much. In short cast or don't but do not get stuck with a 
> detail like this. To be honest this is probably the best advice. While I 
> would see these sorts of type change reminders I'm happy to rip them out 
> if that is needed to move forward.

If I understand correctly, your position is that this too trivial to be
wasting time talking about. I agree, and disagree.

Using this technique in this way does trivialize it; I believe that is
in itself harmful. I will elaborate in my reply to Karel.

> 
> p.s. Branch hwclock-jwp-reviewed in my git is rebased on top of most 
> recent origin/master.
> 

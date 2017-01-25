Return-Path: kerolasa@gmail.com
Sender: Sami Kerola <kerolasa@gmail.com>
Date: Wed, 25 Jan 2017 21:54:13 +0000 (GMT)
From: Sami Kerola <kerolasa@iki.fi>
To: J William Piggott <elseifthen@gmx.com>
cc: util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>
Subject: Re: pull: hwclock 27 changes
In-Reply-To: <c88dc7ee-3e18-19ec-612e-3788551517bb@gmx.com>
Message-ID: <alpine.LNX.2.20.1701252136160.492@imuri>
References: <20161231214107.8658-1-kerolasa@iki.fi> <05e4405f-8096-9261-f9f2-d2c6b84675bc@gmx.com> <070fc458-ed69-a09c-11cc-42bb50fec888@gmx.com> <alpine.LNX.2.20.1701072212010.9096@imuri> <a9d7f37b-3607-70d4-843a-7d934bd305d5@gmx.com>
 <alpine.LNX.2.20.1701112055190.2589@imuri> <ede34a46-7290-c68b-1dd8-e4fc356e5caf@gmx.com> <alpine.LNX.2.20.1701140930380.2049@imuri> <f723104e-d23b-f8fd-e9ee-b9fc82c86fd3@gmx.com> <c88dc7ee-3e18-19ec-612e-3788551517bb@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <util-linux.vger.kernel.org>

On Sun, 22 Jan 2017, J William Piggott wrote:
> On 01/14/2017 05:51 PM, J William Piggott wrote:
> > On 01/14/2017 04:34 AM, Sami Kerola wrote:
> >> Preferably there should not be casts at all. But sometimes they are hard 
> >> to avoid, and then one should do as few casts as possible to avoid cutting 
> >> bits out.
> >>
> >> Think casting in terms of shape sorting toy. The more data is casted 
> >> through none-matching types the more the original shape is modified to fit 
> >> to storage where it is pushed.
> >>
> >> That is also the reason why casting to time_t in this case makes sense. 
> >> While it might be that right now, on systems we happen to use, int and 
> >> time_t are the same type there are no guarantees about other systems and 
> >> future. In practical terms; casting exactly to matching storage type is 
> >> the right way to avoid damaging data.
> > 
> > What I'm trying to say is, assignment operators automatically convert
> > the right operand to the type of the left operand; making your cast
> > unnecessary. Try it, build hwclock with the cast. Now, remove the cast
> > and build it. The resulting binaries are bit for bit identical.
> > 
> > ISO C11:
> > The type of an assignment expression is the type the left operand would have
> > after lvalue conversion.
> > 
> > In simple assignment (=), the value of the right operand is converted to
> > the type of the assignment expression and replaces the value stored in
> > the object designated by the left operand.
> 
> It wasn't the intent of my previous message to be offensive in any way,
> Sami. I was only trying to state my position using different language,
> so as not to simply repeat myself.
> 
> Also, I'm not continuing this topic to be argumentative. The reason is
> for my own education. If my opinion is wrong, that is fine; I would like
> to understand why, so as to improve my own coding.
> 
> As I further read the ISO C standard, I'm more convinced of my belief.
> It seems to me the compiler is required to use the type conversion
> routine associated with assignment operators, because it must yield two
> different results. A /qualified/ left operand type is stored, but the
> evaluation of the assignment expression returns an /unqualified/ left
> operand type. Since using the assignment operator's type conversion
> routine is required (if I'm correct), the compiler would ignore any cast
> on the results of the right hand operand for code optimization, yes?
> 
> That seems to be true for my compiler, as the cast makes no difference
> in the resulting binary.
> 
> If anyone knows the correct answer to this, I am very interested in
> learning it. Thank you in advance.

Hi William,

Sorry for late reply, I took a bit time off from reading / replying 
emails.

Correct the cast that is in place now is technically unnecessary. Value of 
that cast is to remind return value type and storage type differ. Such 
assignments can, at least in theory, cause bugs so being explicit about 
them is a good thing. As a matter of fact anything that makes code easier 
to understand is welcome.

That said now I doubt whether 'technically unnecessary' cast is really a 
thing that clarifies, but confuses code reader. Comments would be nice, 
meanwhile I will think about this.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/

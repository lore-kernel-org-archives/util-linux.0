Return-Path: elseifthen@gmx.com
Subject: Re: [PATCH 2/2] hwclock: add --ul-debug implementing debug.h
To: Karel Zak <kzak@redhat.com>
References: <27af199a-8ec2-634f-6e99-dd4047f9d5f4@gmx.com>
 <c0ee83b1-2736-313d-802b-4937c6f71d85@gmx.com>
 <20171229113824.72y6cgyqta42mt2y@ws.net.home>
 <3b97fbb3-d191-1aa1-2d6e-ee8e17174cea@gmx.com>
 <20180108105527.kj62amdwlgoj3f7l@ws.net.home>
From: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Message-ID: <40a664bf-1db7-5f26-ab6f-2c061ee40dbe@gmx.com>
Date: Sun, 21 Jan 2018 14:38:25 -0500
MIME-Version: 1.0
In-Reply-To: <20180108105527.kj62amdwlgoj3f7l@ws.net.home>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


On 01/08/2018 05:55 AM, Karel Zak wrote:
> On Sat, Jan 06, 2018 at 11:11:31AM -0500, J William Piggott wrote:
 
>> What I dislike the most is that debugging is very seldom used, yet debugging is
>> initialized unconditionally whether it is wanted or not. This is completely
>> unnecessary; an option does the job just as well without the added overhead.
> 
> It's one getenv() call, nothing else. See libc for how many env.vars
> it's sensitive.

For glibc it's mostly only to honor the POSIX environment as it is required to
do. It also uses secure_getenv(); I see that you've since added something
simular to debug.h. That is one type of security problem that I was talking
about; I think there could be more. The glibc manual says:

   The argv mechanism is typically used to pass command-line arguments specific
   to the particular program being invoked.  The environment, on the other
   hand, keeps track of information that is shared by many programs, changes
   infrequently, and that is less frequently used.

I wonder how a debug.h patch would be received on the libc-alpha list?

Anyway, I don't want to cause problems about this. You've made a compromise for
hwclock and I appreciate that. My comments are only food-for-thought, or as you
say brainstorming. I just think the general concept is not so good.

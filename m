Return-Path: elseifthen@gmx.com
Message-ID: <544052E0.3080105@gmx.com>
Date: Thu, 16 Oct 2014 19:21:04 -0400
From: JWP <elseifthen@gmx.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: Sami Kerola <kerolasa@iki.fi>, util-linux@vger.kernel.org
Subject: Re: [PATCH 1/7] hwclock: hctosys drift compensation II
References: <5426D4C2.4060403@gmx.com> <5426D7C0.50108@gmx.com> <alpine.LNX.2.03.1409281829450.8884@iki.fi> <54298D46.6010101@gmx.com> <20141014090311.GM8057@x2.net.home>
In-Reply-To: <20141014090311.GM8057@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On 10/14/2014 05:03 AM, Karel Zak wrote:
> On Mon, Sep 29, 2014 at 12:48:06PM -0400, JWP wrote:
>> On 09/28/2014 01:55 PM, Sami Kerola wrote:
>>> On Sat, 27 Sep 2014, JWP wrote:

>> separate patch changing all occurrences would be preferred? I would 
>> be happy to add that to my todo list if the project wants it?
> 
> Maybe it would be better to think about whole code refactoring as it's
> horrible code. It's probably last so horrible code in util-linux.
> 
> (refactoring means: add control struct, small smart functions to
>  modify the struct and high-level functions to implement hwclock
>  logic, but it has to be done in easy to review incremental way. It
>  means small patches. 

I have added it to my todo list.
I would like to make other needed changes first before starting to
refactor, if that is okay with you?

>> Mr. Zak, could you please tell me how to proceed on these changes?
>> Should they all be implemented as Mr. Kerola wrote them?
>> Do you want to tweak the code, or do you want me to resubmit a 
>> single patch, or the entire series?
> 
>  You don't have to resend all, just fixed (updated) patches only. Or
>  ideally create your own git repository somewhere (e.g. at github) and
>  send pull request (url to the repository) only.

Changes made as requested.

Repository created at GitHub:
https://github.com/jwpi/util-linux
git@github.com:jwpi/util-linux.git
https://github.com/jwpi/util-linux.git

I also sent a pull request to you via GitHub.



> 
>  Please, try to compose smaller patches next time, for example --get
>  is relatively independent change.

Okay, sorry.

> 
>     Karel
> 

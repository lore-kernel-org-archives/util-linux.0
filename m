Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43845 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932092AbaJNJDb (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 14 Oct 2014 05:03:31 -0400
Date: Tue, 14 Oct 2014 11:03:11 +0200
From: Karel Zak <kzak@redhat.com>
To: JWP <elseifthen@gmx.com>
Cc: Sami Kerola <kerolasa@iki.fi>, util-linux@vger.kernel.org
Subject: Re: [PATCH 1/7] hwclock: hctosys drift compensation II
Message-ID: <20141014090311.GM8057@x2.net.home>
References: <5426D4C2.4060403@gmx.com>
 <5426D7C0.50108@gmx.com>
 <alpine.LNX.2.03.1409281829450.8884@iki.fi>
 <54298D46.6010101@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54298D46.6010101@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Sep 29, 2014 at 12:48:06PM -0400, JWP wrote:
> On 09/28/2014 01:55 PM, Sami Kerola wrote:
> >On Sat, 27 Sep 2014, JWP wrote:
> >> +static struct timeval t2tv(time_t timet)
> >
> >More verbose with function name would be easier to understand.
> >
> >time_t_to_timeval(time_t timet)
> >
> 
> I would normally agree, but I think this case is an exception for
> the same reason that all typecasting labels should be short. Imagine
> how ugly the code would look if (int) were (typecast_to_integer). 
> 
> Because time_t and timeval are used extensively throughout this code 
> I think it should be clear to the reader what t2tv() means.
> 
> Having said that, if the project and Mr. Zak believe a longer name is 
> preferred then I will happily go with whatever name is decided upon. 

I have no strong opinion about it, although I usually use _to_ rather
than x2y. 

> >> +{
> >> +  struct timeval rettimeval;
> >> +
> >> +  rettimeval.tv_sec = timet;
> >> +  rettimeval.tv_usec = 0;
> >> +  return(rettimeval);

return is not a function, don't use ().

> >> +}
> >
> >The util-linux is using linux coding style (at least in most of the 
> >tools), so:
> >
> >Tabs are 8 characters, and thus indentations are also 8 characters.
> >
> 
> Well, that's embarrassing.  I thought I had git configured to highlight
> those mistakes for me. My apologizes for such a stupid error. 

OK

> >> +		printf(_("%s  .%06d seconds\n"), ctime_now, (int)hwctime.tv_usec);
> >
> >Why not to avoid cast, and print by using the type the tv_usec is?
> >
> >printf(_("%s  .%06ld seconds\n"), ctime_now, hwctime.tv_usec);
> 
> 
> I was following the existing practice.  All of the print statements
> in this code use typecasting.  I would suggest, rather than breaking
> code continuity by modifying the few instances in this patch, that a

It's fine to follow the existing practice.

> separate patch changing all occurrences would be preferred? I would 
> be happy to add that to my todo list if the project wants it?

Maybe it would be better to think about whole code refactoring as it's
horrible code. It's probably last so horrible code in util-linux.

(refactoring means: add control struct, small smart functions to
 modify the struct and high-level functions to implement hwclock
 logic, but it has to be done in easy to review incremental way. It
 means small patches. 
 
 It's nothing you want to do in this patch-set now. It's another
 (next) task.:-)

> >> +	        struct timeval lastCalib;
> >
> >s/lastCalib/last_calib/
> >
> >CamelCases are unexpected. When fixing that change also 8 spaces in front 
> >of the variable to one tab.
> >
> 
> Very true, more dumb mistakes on my part.

 yes

> Mr. Zak, could you please tell me how to proceed on these changes?
> Should they all be implemented as Mr. Kerola wrote them?
> Do you want to tweak the code, or do you want me to resubmit a 
> single patch, or the entire series?

 You don't have to resend all, just fixed (updated) patches only. Or
 ideally create your own git repository somewhere (e.g. at github) and
 send pull request (url to the repository) only.

 Please, try to compose smaller patches next time, for example --get
 is relatively independent change.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

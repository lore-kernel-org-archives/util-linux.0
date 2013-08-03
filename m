Return-Path: dg@treblig.org
Date: Sat, 3 Aug 2013 13:38:30 +0100
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, rleigh@debian.org
Subject: Re: [PATCH] get_line fixes for wide characters and overflows
Message-ID: <20130803123830.GB5098@gallifrey>
References: <20130716232033.GD9944@gallifrey>
 <20130719223501.GA13613@gallifrey>
 <20130801110159.GA2484@x2.net.home>
 <20130801125703.GA7815@gallifrey>
 <20130801140407.GC2484@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130801140407.GC2484@x2.net.home>
List-ID: <util-linux.vger.kernel.org>

* Karel Zak (kzak@redhat.com) wrote:
> On Thu, Aug 01, 2013 at 01:57:03PM +0100, Dr. David Alan Gilbert wrote:
> > e to
> > >  reproduce the problem with the file from Suse bugzilla).
> > 
> > Hi Karel,
> >   Thanks for the reply.  I'll give it a go over the weekend,
> > but I don't think it can handle the wchar problems I described and fixed
> > in my follow up patch. If a 4byte wchar hapens to land at the end of the buffer
> > how do you guarantee the space?
> 
>  Ah, I probably see what you mean. So I have added p < &Line[LineLen - 1]
>  check to the for() where the code copies the multibyte buffer to line buffer.
>  See git tree for more details.

OK; so I think with your ...ea608842 change then it should work (not tried
to push it); but with that change hopefully the extra check in ..623bc74f
should never trigger; which is good because if it does then I think you'll
end up outputing part of a wide character which would get messy.

One thing I tried to do in my change was remove the magic '4's that
pop up in a few places because of the wide characters.

(Any particular reason you prefered this over my fix?)

Dave

> 
>     Karel
> 
> 
> 
> -- 
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\ gro.gilbert @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

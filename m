Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:27382 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751713AbaD3GrA (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 30 Apr 2014 02:47:00 -0400
Date: Wed, 30 Apr 2014 08:46:54 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>,
        =?iso-8859-1?Q?P=E1draig?= Brady <P@draigbrady.com>
Subject: Re: terminal-colors.d and termname
Message-ID: <20140430064654.GB24535@x2.net.home>
References: <20140429104640.GC24681@x2.net.home>
 <CAG27Bk3vrfPb2qktGDpmpNYqi7nRcTfNDOZJgzBbn2+j_6rZWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk3vrfPb2qktGDpmpNYqi7nRcTfNDOZJgzBbn2+j_6rZWw@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Apr 29, 2014 at 05:52:28PM +0100, Sami Kerola wrote:
> Does this image summarize the logic that you are describing?
> 
> http://ut3.org/~kerolasa/ul-bikeshed.png

 Probably.

> What comes to proposed options (IMHO) 1 seems to better than 2 or 3 to
> find yes/no answers. For matching meanings with colors some sort of
> syntax is probably needed, such as "error red standard" where a color
> red seems to mean an error; which leaves it to be commands problem to
> determine what is an error.  I do not know what you meant with word
> standard.

 <class> <foreground> <background>

the same uses ls(1) DIR_COLORS.

> Over-complicating a bit, or forgetting KISS for now. There seems to be
> nearly infinite colors, and possibly infinite meanings. Designing an
> interface that will support such may result to be too difficult to
> understand. Maybe limiting meanings to a finite set, such as what

 The <class> is a string defined by util and only the util has to care
 what the string means. We don't have to be generic.

> syslog has done with levels and facilities, gives enough flexibility
> without being impossible to use. Sticking to syslog definitions has
> one thing favoring such decision; unixian people are already familiar
> with the concept. Downside is that some syslog keywords (LOG_UUCP)
> feel a bit legacy. That in mind the syntax could look something like
> 
> facility:level:#FFFFFF
> facility:level:red

Now we have

  #define DMESG_COLOR_SUBSYS	UL_COLOR_BROWN
  #define DMESG_COLOR_TIME	    UL_COLOR_GREEN

all I want to use is

  #define DMESG_COLOR_SUBSYS "subsys"
  #define DMESG_COLOR_TIME   "time"

  cl = colors_get_color(DMESG_COLOR_TIME);
  fputs(cl, stdout);

where in the dmesg.scheme will be 

  subsys brown 0
  time green 0

and in dmesg.1 man page will be explained what does it mean "time"
and "subsys". (For now let's ignore that we will need some hardcoded 
defaults.) 

The format of the <class> string depends on the util, I don't see
problem to support for example:

  kern.err red 0

for dmesg.

> Was that too beoynd KISS?

 Yes :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

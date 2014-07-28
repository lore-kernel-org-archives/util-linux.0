Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:1444 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751365AbaG1L7b (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 28 Jul 2014 07:59:31 -0400
Date: Mon, 28 Jul 2014 13:59:23 +0200
From: Karel Zak <kzak@redhat.com>
To: =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>
Cc: Andreas Henriksson <andreas@fatal.se>, util-linux@vger.kernel.org
Subject: Re: [PATCH] tests: allow non-inotify tailf to keep up
Message-ID: <20140728115923.GK8533@x2.net.home>
References: <1406407441-4872-1-git-send-email-andreas@fatal.se>
 <53D4F231.9020906@draigBrady.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <53D4F231.9020906@draigBrady.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jul 27, 2014 at 01:36:01PM +0100, Pádraig Brady wrote:
> On 07/26/2014 09:44 PM, Andreas Henriksson wrote:
> > When tailf is not using inotify, it seems to sleep for 0.25s between
> > checks. Just giving a 0.1s time window between update and removal of the
> > input file thus gives little chance for tailf to succeed.
> > Similar between startup and append to file, make sure initial
> > content is read before appending additional data by bumping the time.
> > 
> > This should possibly be bumped much larger to make sure that
> > the tailf process actually gets a chance to run at all in the
> > given time window. Otherwise it might fail on really slow/overloaded
> > machines.
> > The drawback would then ofcourse be to increase the time it takes
> > to run the testsuite.
> > 
> > Signed-off-by: Andreas Henriksson <andreas@fatal.se>
> > ---
> >  tests/ts/tailf/simple | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tests/ts/tailf/simple b/tests/ts/tailf/simple
> > index 955844d..d0a1c5c 100755
> > --- a/tests/ts/tailf/simple
> > +++ b/tests/ts/tailf/simple
> > @@ -27,9 +27,9 @@ echo {a..z} > $INPUT
> >  
> >  $TS_CMD_TAILF $INPUT > $TS_OUTPUT 2>&1 &
> >  
> > -sleep 0.1
> > +sleep 0.5
> >  echo {0..9} >> $INPUT
> > -sleep 0.1
> > +sleep 0.5
> >  
> >  rm -f $INPUT
> 
> For such tests coreutils uses a helper function
> to apply a truncated exponential backoff,
> to run quickly in the common case, but also
> delay longer if necessary. See retry_delay_() at:
> 
> http://git.sv.gnu.org/gitweb/?p=coreutils.git;a=blob;f=init.cfg;h=725ee121;hb=HEAD#l608

 Andreas? (hint: send a new patch :-))

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

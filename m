Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:4344 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752682AbaELLG1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 12 May 2014 07:06:27 -0400
Date: Mon, 12 May 2014 13:06:08 +0200
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: Sami Kerola <kerolasa@iki.fi>, util-linux@vger.kernel.org,
        Ruediger Meier <sweet_f_a@gmx.de>
Subject: Re: [PATCH 01/12] tests: check /proc availability, and go-around if
 it is incomplete
Message-ID: <20140512110608.GD8951@x2.net.home>
References: <1399836409-7769-1-git-send-email-kerolasa@iki.fi>
 <537072BE.3090301@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <537072BE.3090301@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, May 12, 2014 at 09:05:34AM +0200, Bernhard Voelker wrote:
> On 05/11/2014 09:26 PM, Sami Kerola wrote:
> > diff --git a/tests/ts/kill/kill_functions.sh b/tests/ts/kill/kill_functions.sh
> > index 73fff05..a2a2483 100644
> > --- a/tests/ts/kill/kill_functions.sh
> > +++ b/tests/ts/kill/kill_functions.sh
> > @@ -1,3 +1,5 @@
> > +# kill tests, or command, will not when /proc is missing.
> > +test /proc || ts_skip "/proc not available"
> 
> Ahem, this only ensures that '/proc' is a string, nothing else ...

 Fixed.

> >  # unfortunately we are using gawk features
> >  type gawk >/dev/null 2>&1 || ts_skip "cannot find gawk"
> > @@ -8,6 +10,17 @@ function check_test_sigreceive {
> >  	local pid=$1
> >  
> >  	for i in 0.01 0.1 1 1 1 1; do
> > +		if [ ! -f /proc/$pid/status ]; then
> > +			# The /proc exists, but not status file. Because
> > +			# the process already started it is unlikely the
> > +			# file would appear after any amount of waiting.
> > +			# Try to sleep for moment and hopefully
> > +			# test_sigreceive is ready to be killed.
> > +			echo "kill_functions.sh: /proc/$pid/status: No such file or directory"
> > +			sleep 2
> > +			rc=1
> > +			break
> > +		fi
> >  		gawk 'BEGIN { retval=1 }
> >  		/^SigCgt/ {
> >  			lbyte = strtonum("0x" substr($2, 16, 16))
> > 
> 
> Seeing all this /proc stuff going into the tests - it now even
> requires gawk - I still personally think that a simple witness
> file would have done it.
> So Karel, if you really prefer this, then I'm okay with it, of course.

The dependence on gawk is not nice thing, I have modified the function
to use simple awk print stuff and shell to convert & check sigmask.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

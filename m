Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:52524 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753441AbdC2U4j (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 29 Mar 2017 16:56:39 -0400
Subject: Re: col issue
To: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
References: <20170328121630.prr5s6aikqvt2awt@ws.net.home>
Cc: Sami Kerola <kerolasa@iki.fi>
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <1282cc35-be6f-0208-a79b-2751484553d7@gmx.com>
Date: Wed, 29 Mar 2017 16:56:21 -0400
MIME-Version: 1.0
In-Reply-To: <20170328121630.prr5s6aikqvt2awt@ws.net.home>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 03/28/2017 08:16 AM, Karel Zak wrote:
> 
>  Hi,
> 
>  see https://bugzilla.redhat.com/show_bug.cgi?id=1436432
> 

A more pertinent question for this bug report might be: why are they
running display terminal output (a log file) through 'col -b'? The 'b'
switch is to strip overstriking, which there is none of in this log
file. Besides clobbering the terminal CSIs it does almost nothing to the
output.

>  any idea what is the right col(1) behavior for escape sequences?

This is a very old roff postprocessor for Model 37 Teletypes, which long
ago was the default output for nroff. The reason col(1) doesn't
recognize modern display terminal CSIs is because they didn't exist back
then.  You will notice that the escape sequences that col(1) does
recognize are not for a display terminal, they are for a print terminal.

Modern roff packages no longer output text this postprocessor was written
for. That is why col(1) is not included with *roff packages anymore.

The only way I see it being used currently is 'col -b' to strip
overstrikes. That is mostly unneeded, because modern pagers can handle
overstrikes. If someone really wants to strip them, a simple sed pipe
will do the job.

So col(1) is not supposed to be a general text processor, it was a roff
postprocessor. It seems to me if it were changed into a general text
processor a new name would be in order to distinguish it from the
traditional command?

> 
>  The current code reads two first bytes from the sequence and the rest
>  is interpreted as standard chars (because complex sequences like
>  ^[..m are completely unknown for the code), for example input:
> 
>     ^[[1mtomcat-el^[(B^[[m
> 
>  produces:
> 
>     1mtomcat-elBm
> 
>  It seems incorrect. I think for "col -p" all the sequence should be
>  filtered out, it means:
>    
>     tomcat-el
>  
>  and the default behavior (without -p) should be output all escape
>  sequences but do not increment internal width counters.
>  
>  Objections?
> 
>     Karel
> 

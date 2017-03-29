Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40064 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754833AbdC2JfN (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 29 Mar 2017 05:35:13 -0400
Date: Wed, 29 Mar 2017 11:35:08 +0200
From: Karel Zak <kzak@redhat.com>
To: =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>
Cc: util-linux@vger.kernel.org, Sami Kerola <kerolasa@iki.fi>
Subject: Re: col issue
Message-ID: <20170329093508.mougxjykuyrtcutv@ws.net.home>
References: <20170328121630.prr5s6aikqvt2awt@ws.net.home>
 <1a5ce781-a9c9-11ef-d3d2-45f95d9cd7a8@draigBrady.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1a5ce781-a9c9-11ef-d3d2-45f95d9cd7a8@draigBrady.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Mar 28, 2017 at 07:57:35PM -0700, Pádraig Brady wrote:
> On 28/03/17 05:16, Karel Zak wrote:
> > 
> >  Hi,
> > 
> >  see https://bugzilla.redhat.com/show_bug.cgi?id=1436432
> > 
> >  any idea what is the right col(1) behavior for escape sequences?
> > 
> >  The current code reads two first bytes from the sequence and the rest
> >  is interpreted as standard chars (because complex sequences like
> >  ^[..m are completely unknown for the code), for example input:
> > 
> >     ^[[1mtomcat-el^[(B^[[m
> > 
> >  produces:
> > 
> >     1mtomcat-elBm
> > 
> >  It seems incorrect. I think for "col -p" all the sequence should be
> >  filtered out, it means:
> >    
> >     tomcat-el
> >  
> >  and the default behavior (without -p) should be output all escape
> >  sequences but do not increment internal width counters.
> >  
> >  Objections?
> > 
> >     Karel
> > 
> 
> I agree, but presuming you meant the opposite, and
> for `col -p` to pass through all these escape sequences unaltered

 Yes, -p is opposite, it means "Force unknown control sequences to be
 passed through unchanged."

    Karel
 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

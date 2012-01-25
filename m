Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:51788 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752791Ab2AYJhL (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 25 Jan 2012 04:37:11 -0500
Date: Wed, 25 Jan 2012 10:37:04 +0100
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: Vic Abell <abe@purdue.edu>, util-linux <util-linux@vger.kernel.org>
Subject: Re: adopting lslk
Message-ID: <20120125093704.GC28644@x2.net.home>
References: <1327445685.3650.4.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1327445685.3650.4.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jan 24, 2012 at 11:54:45PM +0100, Davidlohr Bueso wrote:
> I just noticed this big fat message from the lslk(8) manpage:
> 
>  Revision 1.29 represents the end of life for lslk.  I don't have time
>  to support it.  Please don't report bugs to me.  I will politely  
>  decline to work on them.                                         

 Yes, I know, I'm maintainer of the package in Red Hat :-)

> I was thinking util-linux might be a good place to continue maintaining

 I agree.

> this program, it seems worthwhile. I couldn't find the _official_ source
> tarball but I got it through apt. I could integrate it and send a patch.
> Any thoughts?

 Yes, but please clean up the code, add xalloc, err.h, long options,
 etc... you know ;-) May be it would be also nice to use lib/tt.c for
 output to make it compatible with our new utils.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

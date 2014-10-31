Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:57213 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932317AbaJaJcQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 31 Oct 2014 05:32:16 -0400
Date: Fri, 31 Oct 2014 10:32:11 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 3/4] textual: slice up the usage text of swapon for ease
 of translation
Message-ID: <20141031093211.GR10134@x2.net.home>
References: <1414444693-16407-1-git-send-email-bensberg@justemail.net>
 <1414444693-16407-3-git-send-email-bensberg@justemail.net>
 <1414445075.1871991.183947489.0B2FD4D2@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1414445075.1871991.183947489.0B2FD4D2@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Oct 27, 2014 at 10:24:35PM +0100, Benno Schulenberg wrote:
> 
> On Mon, Oct 27, 2014, at 22:18, Benno Schulenberg wrote:
> > +	fputs(_(" -v, --verbose            verbose mode\n"), out);
> >  
> >  	fputs(USAGE_SEPARATOR, out);
> >  	fputs(USAGE_HELP, out);
> 
> A bit further down in the usage text it says this:
> 
>         fputs(_("\nAvailable discard policy types (for --discard):\n"
>                 " once    : only single-time area discards are issued. (swapon)\n"
>                 " pages   : discard freed pages before they are reused.\n"
>                 " * if no policy is selected both discard types are enabled. (default)\n"), out);
> 
> Why is this "(swapon)" there?  What does it mean?

Nothing, good catch, I'll remove it..

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

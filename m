Return-Path: util-linux-owner@vger.kernel.org
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:35229 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754024Ab3JDLml (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 4 Oct 2013 07:42:41 -0400
Message-Id: <1380886960.30366.29949569.056246FC@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Karel Zak <kzak@redhat.com>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <20131004102946.GC14360@x2.net.home>
References: <1380799327.6719.29499593.49A8C84F@webmail.messagingengine.com>
 <20131004102946.GC14360@x2.net.home>
Subject: Re: some spelling and grammar fixes for messages and man pages
Date: Fri, 04 Oct 2013 13:42:40 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Fri, Oct 4, 2013, at 12:29, Karel Zak wrote:
>  Please, ALWAYS when you want to change any very common message then
>  see po/util-linux.pot. 
>  
>  We have on "cannot open %s" on more than 100 places!
> 
>  The ideal solution is to use already translated message than
>  introduce new one. Or if you don't like the message then change the
>  string on *all places*. 

Yes, you are right.  I wasn't thinking.

>  It would be nice to cleanup all the messages and use for example
> 
>     cannot open %s
>     cannot close %s
>     cannot read %s
>     cannot write %s
>     seek on %s failed
> 
>  on all places. Now (rc1) is the ideal time for this change.

I will be working on that.

>  (Not sure why someone updated util-linux on translationproject.org
>   when there is no -rc2 yet.)

I did.  To give translators extra time to catch up, because there have
been massive string changes.  And to give them a chance to report
errors or doubts, and get them fixed before rc2.

Benno


-- 
http://www.fastmail.fm - mmm... Fastmail...


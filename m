Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:36892 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755432Ab3HAOEO (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 1 Aug 2013 10:04:14 -0400
Date: Thu, 1 Aug 2013 16:04:07 +0200
From: Karel Zak <kzak@redhat.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: util-linux@vger.kernel.org, rleigh@debian.org
Subject: Re: [PATCH] get_line fixes for wide characters and overflows
Message-ID: <20130801140407.GC2484@x2.net.home>
References: <20130716232033.GD9944@gallifrey>
 <20130719223501.GA13613@gallifrey>
 <20130801110159.GA2484@x2.net.home>
 <20130801125703.GA7815@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130801125703.GA7815@gallifrey>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Aug 01, 2013 at 01:57:03PM +0100, Dr. David Alan Gilbert wrote:
> e to
> >  reproduce the problem with the file from Suse bugzilla).
> 
> Hi Karel,
>   Thanks for the reply.  I'll give it a go over the weekend,
> but I don't think it can handle the wchar problems I described and fixed
> in my follow up patch. If a 4byte wchar hapens to land at the end of the buffer
> how do you guarantee the space?

 Ah, I probably see what you mean. So I have added p < &Line[LineLen - 1]
 check to the for() where the code copies the multibyte buffer to line buffer.
 See git tree for more details.

    Karel



-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

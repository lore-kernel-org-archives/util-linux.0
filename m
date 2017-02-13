Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:51602 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751023AbdBMMqz (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 13 Feb 2017 07:46:55 -0500
Date: Mon, 13 Feb 2017 13:46:47 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/3] pull: blkreset and blkreport polishing
Message-ID: <20170213124647.fnw27bvaaritq6lk@ws.net.home>
References: <20170211141052.26154-1-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170211141052.26154-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Feb 11, 2017 at 02:10:49PM +0000, Sami Kerola wrote:
> I should have said this a bit earlier. 

Yes :-)

> It is a pity there are now two new
> blkre* tools instead of single 'zblkadm (reset|report)'.  A single command
> would have less boilerplating going on, and would form logical path how to
> add new features in future.

I like the idea, but no the name. IMHO something like 

    blkzone (reset|report)
    
would be better. I'll try to merge it to the one command during this week.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

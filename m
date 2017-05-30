Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:33094 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750951AbdE3N2s (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 30 May 2017 09:28:48 -0400
Date: Tue, 30 May 2017 15:28:43 +0200
From: Karel Zak <kzak@redhat.com>
To: Assaf Gordon <assafgordon@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.30-rc2
Message-ID: <20170530132843.v4mykfwkrwdkxolt@ws.net.home>
References: <20170523105038.hm3ryvwvghgife4j@ws.net.home>
 <E6F9AA27-1BC9-4595-9FB2-30F1BA3663CA@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E6F9AA27-1BC9-4595-9FB2-30F1BA3663CA@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, May 30, 2017 at 01:03:53AM -0400, Assaf Gordon wrote:
> Hello
> 
> > On May 23, 2017, at 06:50, Karel Zak <kzak@redhat.com> wrote:
> > 
> > The util-linux release v2.30-rc2 is available at
> > 
> >  http://www.kernel.org/pub/linux/utils/util-linux/v2.30/
> 
> Few results from various system:
> 
> 1.
> On several systems which do not have ncurses development files
> installed, the "configure" script does not detect it,
> and completion later fails.
> Example with Debian 8.1:

I see where is the problem. We assume that successful ncurses-config
call means that devel stuff is installed. Unfortunately, on Debian 8
this script is installed by ncurses-bin where is nothing like header
files etc. 

IMHO it's packaging bug, but I'll improve our build system to be more
paranoid...

   Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

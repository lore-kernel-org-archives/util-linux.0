Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:53796 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754262AbbCCMFa (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 3 Mar 2015 07:05:30 -0500
Date: Tue, 3 Mar 2015 13:05:18 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 00/12] pull: script(1) changes
Message-ID: <20150303120518.GR8046@ws.net.home>
References: <1424616169-693-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1424616169-693-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Feb 22, 2015 at 02:42:37PM +0000, Sami Kerola wrote:
> Hello,
> 
> The following changes are clean ups and improvements to script(1)
> command.  These changes are also available from my github remote
> repository.

 Seems no tested with HAVE_LIBUTEMPTER...

 term-utils/script.c: In function ‘main’:
 term-utils/script.c:564:22: error: ‘master’ undeclared (first use in  this function)
 term-utils/script.c:564:22: note: each undeclared identifier is  reported only once for each function it appears in
 Makefile:9216: recipe for target 'term-utils/script-script.o' failed
 make: *** [term-utils/script-script.o] Error 1


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

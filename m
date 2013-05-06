Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:2109 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753336Ab3EFRQc (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 6 May 2013 13:16:32 -0400
Date: Mon, 6 May 2013 19:16:22 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 08/16] lib: copy argmatch from gnulib
Message-ID: <20130506171622.GC9740@x2.net.home>
References: <1367520701-14962-1-git-send-email-kerolasa@iki.fi>
 <1367520701-14962-9-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1367520701-14962-9-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, May 02, 2013 at 07:51:33PM +0100, Sami Kerola wrote:
> Both argmatch.h and argmatch.c are copied from gnulib. 

 Ah no... this is overkill, all we need is to parse three words.

 I have updated lib/colors.c and dmesg.c to support color modes 'auto',
 'never' and 'always'. Please, use it also in cal.c.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

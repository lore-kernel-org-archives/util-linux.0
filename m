Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:30579 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752980AbbBXJkS (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 24 Feb 2015 04:40:18 -0500
Date: Tue, 24 Feb 2015 10:40:07 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 01/16] whereis: tell when mandatory option is missing
Message-ID: <20150224094007.GE19430@ws.net.home>
References: <1424616106-580-1-git-send-email-kerolasa@iki.fi>
 <1424616106-580-2-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1424616106-580-2-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Feb 22, 2015 at 02:41:31PM +0000, Sami Kerola wrote:
>  misc-utils/whereis.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

 Benno is right, see construct_dirlist_from_argv(), the dir list is
 terminated by arbitrary option, it checks for '-'.

 The expected use-case is "<dirlist> <search-restriction> <pattern>",
 for example:

    whereis -M /usr/share/man/man1 -m ls

  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

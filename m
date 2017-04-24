Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60254 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1168716AbdDXKmY (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 24 Apr 2017 06:42:24 -0400
Date: Mon, 24 Apr 2017 12:42:18 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 00/10] pull: various change, some options related
Message-ID: <20170424104218.uouuogsxb5m356yi@ws.net.home>
References: <20170423205821.7444-1-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170423205821.7444-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Apr 23, 2017 at 09:58:11PM +0100, Sami Kerola wrote:
> The chfn and chsh is about usability provided by readline().  I did not add
> #ifdev HAVE_LIBREADLINE and make none libreadline compilation to work
> because it looks like sfdisk is doing the same.  Let me know if fallback
> should be made to work.

Are you sure?

$ grep HAVE_LIBREADLINE disk-utils/sfdisk.c
#ifdef HAVE_LIBREADLINE
#ifdef HAVE_LIBREADLINE
#ifdef HAVE_LIBREADLINE
#ifdef HAVE_LIBREADLINE
#ifndef HAVE_LIBREADLINE

 ... we want to be independent on libreadline of course and it's also
 important to keep the utils usable when stdin is not terminal. We use
 for example:


#ifdef HAVE_LIBREADLINE
	if (isatty(STDIN_FILENO)) {
		p = readline(prompt);
		if (!p)
			return 1;
		memcpy(buf, p, bufsz);
		free(p);
	} else
#endif
	{
		fputs(prompt, stdout);
		fflush(stdout);

		if (!fgets(buf, bufsz, stdin))
			return 1;
	}

for sfdisk.

    Karel
-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

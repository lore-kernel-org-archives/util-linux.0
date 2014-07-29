Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:51575 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751038AbaG2HoS (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 29 Jul 2014 03:44:18 -0400
Date: Tue, 29 Jul 2014 09:44:08 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] wall: wrap message header when it exceeds 79 characters
Message-ID: <20140729074408.GO8533@x2.net.home>
References: <1406487666-19466-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1406487666-19466-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jul 27, 2014 at 08:01:06PM +0100, Sami Kerola wrote:
> Header truncation started to happen more often after commit
> d81c30553f4fb49173d38f69edff4b0b67a18b65 that made the header to be
> longer.

 Well, I did the change to be compatible with wall from sysvinit. The
 original (BSD) wall header format was

  Broadcast Message from %s@%s
           (%s) at %d:%02d ...

 it means two lines.

> +		len = strlen(lbuf);
> +		for (i = 0; 0 < len; i++)
> +			len -= fprintf(fp, "%-*.*s\007\007\r\n", TERM_WIDTH, TERM_WIDTH,
> +				       lbuf + (i * TERM_WIDTH)) + 4;

 Now you want to reintroduce the old behavior (more lines for the header),
 but with a completely random split... I don't think it's a good idea.

 If we don't want the sysvinit header then it would be better to
 compose nice proper header than depend on for (i = 0; 0 < len;
 i++)...

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

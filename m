Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43051 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753600Ab3HWKHg (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 23 Aug 2013 06:07:36 -0400
Date: Fri, 23 Aug 2013 12:07:27 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 00/16] pull: additions recent to last(1) work, plus few
 small changes
Message-ID: <20130823100727.GB32136@x2.net.home>
References: <1376763321-22782-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1376763321-22782-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Aug 17, 2013 at 07:15:05PM +0100, Sami Kerola wrote:
>       build-sys: remove unnecessary environment variable
>       docs: update TODO
>       build-sys: complete elvtune removal
>       docs: be clear which last(1) is deprecated
>       docs: add long options to last.1 manual page
>       include: carefulput: print determined char when unprintable char is found
>       last: use carefulput() for printable character output
>       last: check expected numeric user input is number
>       last: make switch cases complete, and inform if impossible occurs
>       last: prefer enum rather than #definition list
>       last: remove broken code
>       last: use as narrow variable scoping as possible

 Applied.

>       last: use ISO 8601 time format for --fulltimes

 This is not backwardly compatible. Not applied.
 
 We need --fulltimes[=ctime|iso] or add --output=<list> and use lib/tt.c to 
 generate output with arbitrary columns and formats.

>       last: global variables are initialize automatically to zero
>       last: allow --file to be defined multiple times
>       last: add --present option

 Good ideas, applied. Thanks.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

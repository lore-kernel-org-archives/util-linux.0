Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:12271 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755154AbaELMdd (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 12 May 2014 08:33:33 -0400
Date: Mon, 12 May 2014 14:01:05 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org, Ruediger Meier <sweet_f_a@gmx.de>
Subject: Re: [PATCH 01/12] tests: check /proc availability, and go-around if
 it is incomplete
Message-ID: <20140512120105.GE8951@x2.net.home>
References: <1399836409-7769-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1399836409-7769-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, May 11, 2014 at 08:26:38PM +0100, Sami Kerola wrote:
>  tests/ts/kill/kill_functions.sh | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

 Fixed & merged, but I have removed the gawk-only code.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

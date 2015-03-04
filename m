Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:34645 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932486AbbCDPtt (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 4 Mar 2015 10:49:49 -0500
Date: Wed, 4 Mar 2015 16:49:37 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 00/12] pull: script(1) changes
Message-ID: <20150304154937.GT8046@ws.net.home>
References: <1424616169-693-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1424616169-693-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Feb 22, 2015 at 02:42:37PM +0000, Sami Kerola wrote:
>  term-utils/script.c      | 872 ++++++++++++++++++++---------------------------
>  tests/ts/script/race     |   4 -

Note that I'd like to see more and more tests to avoid regressions
(like we have now with logger in v2.26).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

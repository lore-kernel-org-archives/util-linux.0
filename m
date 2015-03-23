Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:54889 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751935AbbCWKoQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 23 Mar 2015 06:44:16 -0400
Date: Mon, 23 Mar 2015 11:44:04 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/5] pull: one dmesg compiler warning fix and bunch of
 tests
Message-ID: <20150323104404.GD1749@ws.net.home>
References: <1427065530-10695-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1427065530-10695-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Mar 22, 2015 at 11:05:25PM +0000, Sami Kerola wrote:
> Sami Kerola (5):
>   dmesg: fix shadow declaration
>   tests: add dmesg multiline message check
>   tests: add test_dmesg that has fixed boot time
>   tests: check timestamp formats
>   tests: check dmesg message coloring

 Applied, thanks. I have changed the test program to use
 DMESG_TEST_BOOTIME env. variable rather than hardcode anything to the
 code. It's also necessary to use TZ=GMT to make the tests portable.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

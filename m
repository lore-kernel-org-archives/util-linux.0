Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:14226 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751181AbaHDL4N (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 4 Aug 2014 07:56:13 -0400
Date: Mon, 4 Aug 2014 13:55:56 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 8/8] zramctl: allow use of --algorithm and --streams alone
Message-ID: <20140804115556.GA6923@x2.net.home>
References: <1407107290-5806-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1407107290-5806-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Aug 04, 2014 at 12:08:10AM +0100, Sami Kerola wrote:
> Earlier the --algorithm and --streams had to be combined with --size.  To
> user requirement to combine with --size was indirectly told using
> following message.

And is it really supported by kernel? I see in
Documentation/blockdev/zram.txt:

 In order to enable compression backend's multi stream support
 max_comp_streams must be initially set to desired concurrency 
 level before ZRAM device initialisation.

I guess that when you set disksize the zram device is "locked" for
setting changes. It means that modify already initialized (created)
zram devices is impossible. You have to reset the device to "unlock"
the device setting.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

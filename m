Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35811 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758738AbaGOLaC (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 15 Jul 2014 07:30:02 -0400
Date: Tue, 15 Jul 2014 13:29:51 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] tests: add kill --queue check
Message-ID: <20140715112951.GX30288@x2.net.home>
References: <1405359437-6288-1-git-send-email-kerolasa@iki.fi>
 <1405360325-6855-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1405360325-6855-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jul 14, 2014 at 06:52:05PM +0100, Sami Kerola wrote:
>  tests/expected/kill/queue       |  1 +
>  tests/helpers/test_sigreceive.c | 17 +++++++++----
>  tests/ts/kill/options           |  2 --
>  tests/ts/kill/queue             | 53 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 66 insertions(+), 7 deletions(-)
>  create mode 100644 tests/expected/kill/queue
>  create mode 100755 tests/ts/kill/queue

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

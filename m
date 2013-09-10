Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58236 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751313Ab3IJLON (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 10 Sep 2013 07:14:13 -0400
Date: Tue, 10 Sep 2013 13:14:04 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org, Ondrej Oprala <ooprala@redhat.com>
Subject: Re: [PATCH 4/4] hexdump: revert global exitval variable change
Message-ID: <20130910111404.GD8061@x2.net.home>
References: <1378656549-3729-1-git-send-email-kerolasa@iki.fi>
 <1378656549-3729-4-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1378656549-3729-4-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Sep 08, 2013 at 05:09:09PM +0100, Sami Kerola wrote:
>  text-utils/display.c | 6 +++---
>  text-utils/hexdump.c | 4 ++--
>  text-utils/hexdump.h | 1 +
>  3 files changed, 6 insertions(+), 5 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

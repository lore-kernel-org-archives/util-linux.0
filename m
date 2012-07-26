Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59204 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750849Ab2GZKIf (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 26 Jul 2012 06:08:35 -0400
Date: Thu, 26 Jul 2012 12:08:26 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/3] tests: look: add words file
Message-ID: <20120726100826.GD12592@x2.net.home>
References: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
 <1343243745-1172-3-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343243745-1172-3-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jul 25, 2012 at 09:15:20PM +0200, Sami Kerola wrote:
> Archlinux words 2.0-4 package does not have 'apple-pie' in words file.

 ... because there is no 'words' upstream :-(

>  tests/ts/look/separator | 4 +---
>  tests/ts/look/words     | 3 +++
>  2 files changed, 4 insertions(+), 3 deletions(-)
>  create mode 100644 tests/ts/look/words

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

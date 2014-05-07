Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:2225 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932274AbaEGJbU (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 7 May 2014 05:31:20 -0400
Date: Wed, 7 May 2014 11:31:10 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] column: inform user when multibyte conversion error
 occurs
Message-ID: <20140507093110.GU5962@x2.net.home>
References: <1399217978-20252-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1399217978-20252-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, May 04, 2014 at 04:39:38PM +0100, Sami Kerola wrote:
>  tests/expected/column/invalid-multibyte |  1 +
>  tests/ts/column/invalid-multibyte       | 30 ++++++++++++++++++++++++++++++
>  text-utils/column.c                     |  8 +++++++-
>  3 files changed, 38 insertions(+), 1 deletion(-)
>  create mode 100644 tests/expected/column/invalid-multibyte
>  create mode 100755 tests/ts/column/invalid-multibyte

 Applied, thanks!

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

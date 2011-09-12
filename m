Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:44480 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755082Ab1ILMEv (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 12 Sep 2011 08:04:51 -0400
Date: Mon, 12 Sep 2011 14:04:48 +0200
From: Karel Zak <kzak@redhat.com>
To: Francesco Cosoleto <cosoleto@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: fdformat: fix uninitialized variable
Message-ID: <20110912120448.GC16902@nb.net.home>
References: <1315674369-31253-1-git-send-email-cosoleto@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1315674369-31253-1-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Sep 10, 2011 at 07:06:09PM +0200, Francesco Cosoleto wrote:
>  disk-utils/fdformat.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

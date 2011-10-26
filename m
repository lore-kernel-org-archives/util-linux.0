Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:2771 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752613Ab1JZVbB (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 26 Oct 2011 17:31:01 -0400
Date: Wed, 26 Oct 2011 23:30:51 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] prlimit: ensure necessary definitions are present
Message-ID: <20111026213051.GB24870@nb.redhat.com>
References: <1319482245-5515-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1319482245-5515-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Oct 24, 2011 at 08:50:44PM +0200, Sami Kerola wrote:
> With Ubuntu linux-libc-dev 2.6.38-11.50 I got error mentioned
> bellow. This patch fixes the issue.
> 
> prlimit.c:77:88: error: 'RLIMIT_RTTIME' undeclared here

 Good point, but I'm not sure if we want to include kernel header
 files (<asm-*/>) to our utils.

 I'll fix this issue later (I'm just working on large changes in
 configure.in).  Thanks.

  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

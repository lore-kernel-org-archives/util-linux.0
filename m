Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:57994 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752408AbcCIKqZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 9 Mar 2016 05:46:25 -0500
Date: Wed, 9 Mar 2016 11:46:22 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] misc: remove path name definitions that are unused
Message-ID: <20160309104622.kvqzyjgne7hnswzu@ws.net.home>
References: <1457475218-26733-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1457475218-26733-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Mar 08, 2016 at 10:13:38PM +0000, Sami Kerola wrote:
>  include/pathnames.h            | 18 ------------------
>  tests/expected/paths/built-in  | 13 -------------
>  tests/helpers/test_pathnames.c | 13 -------------
>  3 files changed, 44 deletions(-)

 Good catch. Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

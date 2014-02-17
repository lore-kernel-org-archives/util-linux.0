Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:41028 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750845AbaBQOLe (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 17 Feb 2014 09:11:34 -0500
Date: Mon, 17 Feb 2014 15:11:21 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/9] tests: make tests to run parallel
Message-ID: <20140217141121.GH2254@x2.net.home>
References: <1392594862-15807-1-git-send-email-kerolasa@iki.fi>
 <1392594862-15807-2-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1392594862-15807-2-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Feb 16, 2014 at 11:54:15PM +0000, Sami Kerola wrote:
>  tests/functions.sh | 15 +++++++--------
>  tests/run.sh       | 32 +++++++++++++++++++-------------
>  2 files changed, 26 insertions(+), 21 deletions(-)

Applied, but with changes:

* It is not enabled by default if you manually execute ./run.sh, you have 
  to specify --parallel[=<num>] to enable this feature (the =<num> is optional).
  It's enabled for "make check".
 
  Frankly, I cannot imagine that I will debug anything around mount(8)
  with enabled --parallel :-)

* the option is propagated to function.sh (where is $TS_PARALLEL)

* the output format depends on $TS_PARALLEL, it means that without
  the --parallel option is the output still the same.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

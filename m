Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:14856 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753359Ab3AYJZd (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 25 Jan 2013 04:25:33 -0500
Date: Fri, 25 Jan 2013 10:25:24 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 18/22] tests: add isosize(1) check
Message-ID: <20130125092524.GF27413@x2.net.home>
References: <1358554151-25985-1-git-send-email-kerolasa@iki.fi>
 <1358554151-25985-19-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1358554151-25985-19-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Jan 19, 2013 at 12:09:07AM +0000, Sami Kerola wrote:
> +gzip -cd $TS_SELF/sample.iso.gz > $TS_SELF/sample.iso

 Applied, note that tests/ts ($TS_SELF) directory should be used
 read-only. It's better to write to $TS_OUTDIR.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

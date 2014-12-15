Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:36295 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751629AbaLOJPv (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 15 Dec 2014 04:15:51 -0500
Date: Mon, 15 Dec 2014 10:15:40 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 00/10] pull: AddressSanitizer round II
Message-ID: <20141215091540.GV19904@x2.net.home>
References: <1417355862-16935-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1417355862-16935-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Nov 30, 2014 at 01:57:32PM +0000, Sami Kerola wrote:
> Here comes the second set of changes to enable AddressSanitizer one day
> in future.  These changed does not include update to travis-functions, as
> demonstrated below, due reason explained later.  The environment changes
> in the diff are useful for other who want to try ASAN compilations.

Hi Sami, do you plan to update these patches? I'd like to release -rc1
this month :-)

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

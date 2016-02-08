Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59863 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752211AbcBHMIu (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 8 Feb 2016 07:08:50 -0500
Date: Mon, 8 Feb 2016 13:08:48 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: some quesion about test_uuidd
Message-ID: <20160208120848.xno2uesyuyc4y4wh@ws.net.home>
References: <201602081146.04421.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201602081146.04421.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Feb 08, 2016 at 11:46:04AM +0100, Ruediger Meier wrote:
> Hi,
> 
> since 963f128c we are building test_uuidd in tests/helpers.
> 
> Where do we use test_uuidd at the moment?

I don't think we use it, it's mostly for manual testing now.

> Because it breakes "configure --disable-libuuid we should guard the 
> test_uuidd build either bei BUILD_LIBUUID or by BUILD_UUIDD. Maybe it 
> should also be moved to misc-utils/ (where uuidd lives) or libuuid/src/ 
> (where test_uuid lives). Opinions?

Yes, misc-utils/test_uuidd.c would be better place for the code.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

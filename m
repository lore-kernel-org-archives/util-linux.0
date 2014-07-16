Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:16786 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757128AbaGPKXH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 16 Jul 2014 06:23:07 -0400
Date: Wed, 16 Jul 2014 12:23:02 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: 2.25-rc2: how to disable prlimit?
Message-ID: <20140716102302.GE4874@x2.net.home>
References: <1404763946.11261.139018425.3433757B@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404763946.11261.139018425.3433757B@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jul 07, 2014 at 10:12:26PM +0200, Benno Schulenberg wrote:
> How does one prevent prlimit from being built?

We currently does not have --disable-* options for all utils, and we
don't have any strict policy about it (I hate when people blindly
follow rules, common sense is better).

We usually have the option for large things (e.g. libs), things that
are not unique to util-linux (e.g. kill, login), too old things
or very new utils (e.g. nsenter).

And many utils we assume everywhere (e.g. ipcs or swapon).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

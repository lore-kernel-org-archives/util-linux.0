Return-Path: util-linux-owner@vger.kernel.org
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:36481 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754839AbaGIPQK (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 9 Jul 2014 11:16:10 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id B6421214B0
	for <util-linux@vger.kernel.org>; Wed,  9 Jul 2014 11:16:00 -0400 (EDT)
Message-Id: <1404918960.4955.139784989.392310B8@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <1404763946.11261.139018425.3433757B@webmail.messagingengine.com>
References: <1404763946.11261.139018425.3433757B@webmail.messagingengine.com>
Subject: Re: 2.25-rc2: how to disable prlimit?
Date: Wed, 09 Jul 2014 17:16:00 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Mon, Jul 7, 2014, at 22:12, Benno Schulenberg wrote:
> configure: WARNING: prlimit64 syscall not found; do not build prlimit

For me the build used to break when not passing things like
--disable-runuser and --disable-login to ./configure, but now
programs that cannot be built get automatically disabled.
Which is nice.  But the message could be a little clearer:
"do not build" seems to say the user should do something.
A simple "not building" would be better.  Upcoming patch
makes that change.

Benno

-- 
http://www.fastmail.fm - Accessible with your email software
                          or over the web


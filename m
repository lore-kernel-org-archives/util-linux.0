Return-Path: util-linux-owner@vger.kernel.org
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:55132 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750976AbaGGTfp (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 7 Jul 2014 15:35:45 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id F33C3218D8
	for <util-linux@vger.kernel.org>; Mon,  7 Jul 2014 15:35:41 -0400 (EDT)
Message-Id: <1404761740.364.139016669.1A8F4A36@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: 2.25-rc2: No package 'python-2.6' found?
Date: Mon, 07 Jul 2014 21:35:40 +0200
In-Reply-To: <1404760256.26848.139006189.2A44DDD8@webmail.messagingengine.com>
References: <1404760256.26848.139006189.2A44DDD8@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Mon, Jul 7, 2014, at 21:10, Benno Schulenberg wrote:
> configure: error: Package requirements (python-2.6) were not met:
> 
> No package 'python-2.6' found

Okay, on the newer system installing python2.7-dev and
libpython2.7-dev gets around this.  But on the older system
there is no libpython2.6-dev, so that one's still stuck.

Benno

-- 
http://www.fastmail.fm - Send your email first class


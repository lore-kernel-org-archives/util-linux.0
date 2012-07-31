Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.10]:60206 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752887Ab2GaJdn (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 31 Jul 2012 05:33:43 -0400
Message-ID: <5017A673.2050902@bernhard-voelker.de>
Date: Tue, 31 Jul 2012 11:33:39 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: "Mantas M." <grawity@gmail.com>
CC: util-linux@vger.kernel.org
Subject: Re: vipw does not work with some editors
References: <20120730212010.GA56766@rain.home>
In-Reply-To: <20120730212010.GA56766@rain.home>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 07/30/2012 11:20 PM, Mantas M. wrote:
> Some editors, such as Vim with 'writebackup' mode enabled, use "atomic
> save" in which the old file is deleted and a new one with the same name
> created in its place.

Why's that "atomic"?
I see a race in between the unlink and the creat call.
I'd tend to consider such editor mode "unlucky" for use with vipw.

Have a nice day,
Berny


Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([212.227.17.13]:63193 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753739AbbD1GvI (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 28 Apr 2015 02:51:08 -0400
Message-ID: <553F2DD2.1070400@bernhard-voelker.de>
Date: Tue, 28 Apr 2015 08:50:58 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: Alexey Galakhov <agalakhov@gmail.com>,
        J William Piggott <elseifthen@gmx.com>
CC: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH] hwclock: flush stdout in hwclock -c
References: <1429197987-8751-1-git-send-email-agalakhov@gmail.com>	<20150427082729.GK27969@ws.net.home>	<553EA9AB.1000608@gmx.com> <20150427234218.587e5435.agalakhov@gmail.com>
In-Reply-To: <20150427234218.587e5435.agalakhov@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 04/27/2015 11:42 PM, Alexey Galakhov wrote:
> $ hwclock -c | cat

You can change the behavior of the buffer:  ;-)

  $ stdbuf -oL  hwclock -c | cat

OTOH, I don't see a problem with just one another fflush()
every few seconds.

Have a nice day,
Berny

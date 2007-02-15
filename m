Return-Path: <util-linux-ng-owner@vger.kernel.org>
Received: from mail.station1.mxsweep.com ([212.147.136.149]:4770 "EHLO
	SCMF01.mxsweep.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932759AbXBONtE (ORCPT
	<rfc822;util-linux-ng@vger.kernel.org>);
	Thu, 15 Feb 2007 08:49:04 -0500
Received: from SCMF01.mxsweep.com (127.0.0.1) by SCMF01.mxsweep.com (MlfMTA v3.2r1b3) id hqhije0171se for <util-linux-ng@vger.kernel.org>; Thu, 15 Feb 2007 13:34:45 +0000 (envelope-from <P@draigBrady.com>)
Message-ID: <45D460A8.7080409@draigBrady.com>
Date: Thu, 15 Feb 2007 13:31:20 +0000
From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: Christian Schlotter <schlotter@users.sourceforge.net>,
        util-linux-ng@vger.kernel.org
Subject: Re: [PATCH] cal: Output unaligned with "-3" option and libtermcap
References: <45868535.5030402@users.sourceforge.net> <20070215130303.GG3925@petra.dvoda.cz>
In-Reply-To: <20070215130303.GG3925@petra.dvoda.cz>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-ng-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
>  Hi Christian,
> 
>  some ideas from your patch are really good, but the rest is not so
>  perfect after all.

Sorry I missed the original mail/patch.
Can you send again?

For reference I did the "highlight today" functionality
in cal a couple of years back which has alignment issues,
and have been trying to get the fix in since then:
http://www.pixelbeat.org/patches/cal-2.12q-highlight.diff

Incidentally I also fixed the weekday alignment for
multibyte locales in the changes I did a couple of years ago.

Pádraig.

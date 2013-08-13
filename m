Return-Path: util-linux-owner@vger.kernel.org
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:52938 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758131Ab3HMPxh (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 13 Aug 2013 11:53:37 -0400
Message-Id: <1376408542.14036.9332767.314B2850@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <1376406563-24198-1-git-send-email-mail@bernhard-voelker.de>
References: <1376406563-24198-1-git-send-email-mail@bernhard-voelker.de>
Subject: Re: [PATCH] last: mention optional arguments in usage
Date: Tue, 13 Aug 2013 17:42:22 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Tue, Aug 13, 2013, at 17:09, Bernhard Voelker wrote:
> -		" %s [options]\n"), program_invocation_short_name);
> +		" %s [options] [name...]\n"), program_invocation_short_name);

Better use angular-brackets convention right away: "[<name>...]".

Regards,

Benno

-- 
http://www.fastmail.fm - Send your email first class


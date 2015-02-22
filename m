Return-Path: util-linux-owner@vger.kernel.org
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:59231 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752006AbbBVRMV (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 22 Feb 2015 12:12:21 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id CEBE520975
	for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 12:12:20 -0500 (EST)
Message-Id: <1424625141.3143508.230849489.18043596@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Sami Kerola <kerolasa@iki.fi>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH 07/16] lib/strutils: move parse_switch() from setterm(1) to
 library
Date: Sun, 22 Feb 2015 18:12:21 +0100
In-Reply-To: <1424616106-580-8-git-send-email-kerolasa@iki.fi>
References: <1424616106-580-1-git-send-email-kerolasa@iki.fi>
 <1424616106-580-8-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Sun, Feb 22, 2015, at 15:41, Sami Kerola wrote:
> -/* Command line parsing routines.
> - *

When removing this comment, please also remove its companion:

/* End of command line parsing routines. */

(It would have been needed anyway, since the usage() routine has
intruded.)

Benno

-- 
http://www.fastmail.com - Access your email from home and the web


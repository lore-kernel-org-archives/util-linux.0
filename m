Return-Path: util-linux-owner@vger.kernel.org
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:59809 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932721AbaCSMh4 (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 19 Mar 2014 08:37:56 -0400
Message-Id: <1395232676.8853.96331789.08D073EF@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Sami Kerola <kerolasa@iki.fi>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH 05/10] kill: make usage() not to return
Date: Wed, 19 Mar 2014 13:37:56 +0100
In-Reply-To: <1394397023-7050-5-git-send-email-kerolasa@iki.fi>
References: <1394397023-7050-1-git-send-email-kerolasa@iki.fi>
 <1394397023-7050-5-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Sun, Mar 9, 2014, at 21:30, Sami Kerola wrote:
> And change the function argument to be output stream.  Earlier the --help
> made kill to exit with none zero value, that now is corrected.

Textual amendments:

s/be/be an/
s/made/option made/
s/to exit/exit/
s/none zero/non-zero/
s/now is/is now/

Or in summary:

And change the function argument to be an output stream.  Earlier the
--help option made kill exit with a non-zero value; that is now corrected.

Regards,

Benno

-- 
http://www.fastmail.fm - Faster than the air-speed velocity of an
                          unladen european swallow


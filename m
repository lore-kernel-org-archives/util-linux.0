Return-Path: util-linux-owner@vger.kernel.org
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:60300 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751517AbaIQH5Z (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 17 Sep 2014 03:57:25 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by gateway2.nyi.internal (Postfix) with ESMTP id AC1082048B
	for <util-linux@vger.kernel.org>; Wed, 17 Sep 2014 03:57:24 -0400 (EDT)
Message-Id: <1410940644.3960867.168458609.5CBEB9EB@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Sami Kerola <kerolasa@iki.fi>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH 0/6] pull: renice changes
Date: Wed, 17 Sep 2014 09:57:24 +0200
In-Reply-To: <alpine.LNX.2.03.1409162118180.3712@kerolasa-home>
References: <1410002693-16540-1-git-send-email-kerolasa@iki.fi>
 <alpine.LNX.2.03.1409162118180.3712@kerolasa-home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Tue, Sep 16, 2014, at 22:21, Sami Kerola wrote:
> +	fputs(_(" -u, --user <name|id>   interpret argument as username or user ID\n"), out);

The argument here should be <name>|<id>.
(Think of <> as the // markers in email.)

Benno

-- 
http://www.fastmail.fm - The way an email service should be


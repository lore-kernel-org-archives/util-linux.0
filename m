Return-Path: util-linux-owner@vger.kernel.org
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:51892 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753359Ab3JXHd3 (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Thu, 24 Oct 2013 03:33:29 -0400
Message-Id: <1382599391.27802.37870029.0813564C@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: victory <victory.deb@gmail.com>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: typo on login-utils/last.c?
Date: Thu, 24 Oct 2013 09:23:11 +0200
In-Reply-To: <20131024160236.a5103738efc152dad2be0213@gmail.com>
References: <20131024160236.a5103738efc152dad2be0213@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Thu, Oct 24, 2013, at 9:02, victory wrote:
> login-utils/last.c:
>  _(" -f, --file <file>    use a specific file instead of %s\n"), _PATH_WTMP);
> 
> specific looks like a typo of specified

Ehm... no, that English phrase is fine.  However, it might
be more in line with other phrases of the same sort to say:
"use the specified file instead of %s", or maybe:
"use this <file> instead of %s".

Benno

-- 
http://www.fastmail.fm - The way an email service should be


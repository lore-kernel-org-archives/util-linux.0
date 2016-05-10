Return-Path: util-linux-owner@vger.kernel.org
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:38793 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752446AbcEJOYS (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 10 May 2016 10:24:18 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id A1CC620993
	for <util-linux@vger.kernel.org>; Tue, 10 May 2016 10:24:17 -0400 (EDT)
Message-Id: <1462890257.1439070.603552425.7FB076BA@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Sami Kerola <kerolasa@iki.fi>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <1462829248-6935-13-git-send-email-kerolasa@iki.fi>
References: <1462829248-6935-1-git-send-email-kerolasa@iki.fi>
 <1462829248-6935-13-git-send-email-kerolasa@iki.fi>
Subject: Re: [PATCH 12/12] write: tell when effective gid and tty path group
 mismatch
Date: Tue, 10 May 2016 16:24:17 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Mon, May 9, 2016, at 23:27, Sami Kerola wrote:
> +		if (getegid() != s.st_gid) {
> +			warnx(_("effective gid and %s group does not match"), path);

For translation purposes, better make this:

  "effective gid does not match group of %s"

otherwise a translator might think that %s is the name of a group.
(And the grammar of the original is incorrect.)

Benno

-- 
http://www.fastmail.com - Does exactly what it says on the tin


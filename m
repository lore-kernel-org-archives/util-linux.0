Return-Path: util-linux-owner@vger.kernel.org
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:42042 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932120AbcCNKIe (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Mar 2016 06:08:34 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 119CD20759
	for <util-linux@vger.kernel.org>; Mon, 14 Mar 2016 06:08:32 -0400 (EDT)
Message-Id: <1457950112.2289076.548369274.2DB1DE7E@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <1457949959-2866-1-git-send-email-bensberg@justemail.net>
References: <1457946613-2435-1-git-send-email-bensberg@justemail.net>
 <1457949959-2866-1-git-send-email-bensberg@justemail.net>
Subject: Re: [PATCH 5/5] unshare: improve wording and formatting in the man page
Date: Mon, 14 Mar 2016 11:08:32 +0100
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

> +.BR setgroups (2)
>  is only callable with CAP_SETGID and CAP_SETGID in a user
>  namespace (since Linux 3.19) does not give you permission to call setgroups(2)
> -until after GID map has been set.

Before the "does" something seems to be missing, but I don't
know what.

Benno

-- 
http://www.fastmail.com - Does exactly what it says on the tin


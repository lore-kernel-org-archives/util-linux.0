Return-Path: util-linux-owner@vger.kernel.org
Received: from resqmta-po-01v.sys.comcast.net ([96.114.154.160]:34311 "EHLO
	resqmta-po-01v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756873AbaKTVdb (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Thu, 20 Nov 2014 16:33:31 -0500
Date: Thu, 20 Nov 2014 16:33:28 -0500
Message-Id: <201411202133.sAKLXSZP006667@hobgoblin.ariadne.com>
From: worley@alum.mit.edu (Dale R. Worley)
To: Drake Wilson <drake@dasyatidae.net>
CC: util-linux@vger.kernel.org
In-reply-to: <546D1BA7.9060501@dasyatidae.net> (drake@dasyatidae.net)
Subject: Re: LUKS partition types, redux
References: <546D0495.2030803@dasyatidae.net> <201411192224.sAJMOhTi010782@hobgoblin.ariadne.com> <546D1BA7.9060501@dasyatidae.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

> From: Drake Wilson <drake@dasyatidae.net>

> I might support an extension
> proposal to allow (but not require) a type for the underlying volume to
> be added as part of the _LUKS_ header, therefore (probably using a GPT
> type just for convenience).

That sounds like a better proposal to me.  But I have no idea whether
LUKS can support such an extension.

Dale

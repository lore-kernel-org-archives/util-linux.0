Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:50640 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752330AbcCGNyn (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 7 Mar 2016 08:54:43 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id A1D0A7F091
	for <util-linux@vger.kernel.org>; Mon,  7 Mar 2016 13:54:42 +0000 (UTC)
Received: from ws (ovpn-204-89.brq.redhat.com [10.40.204.89])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u27DsfSZ030550
	for <util-linux@vger.kernel.org>; Mon, 7 Mar 2016 08:54:42 -0500
Date: Mon, 7 Mar 2016 14:54:41 +0100
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: Re: [PATCH] setarch: fix personality syscall return code check
Message-ID: <20160307135441.xavlkxjsytq4ytv4@ws.net.home>
References: <20160224125641.kw2t37ofjhmealej@ws.net.home>
 <20160304212252.GB22191@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160304212252.GB22191@altlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Mar 05, 2016 at 12:22:52AM +0300, Dmitry V. Levin wrote:
>  sys-utils/setarch.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)

Nice. Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

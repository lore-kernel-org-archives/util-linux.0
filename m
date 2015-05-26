Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.piware.de ([37.120.164.117]:44802 "EHLO mail.piware.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751625AbbEZJAx (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 26 May 2015 05:00:53 -0400
Date: Tue, 26 May 2015 10:35:13 +0200
From: Martin Pitt <martin.pitt@ubuntu.com>
To: Bruce Dubbs <bruce.dubbs@gmail.com>
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org,
        Werner Fink <werner@suse.de>
Subject: Re: sulogin: Don't ask for password when it is locked/disabled
Message-ID: <20150526083513.GO2947@piware.de>
References: <20150525140117.GA9697@ws.net.home>
 <556348A0.9020206@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <556348A0.9020206@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello Bruce,

Bruce Dubbs [2015-05-25 11:06 -0500]:
> Perhaps it's security by obscurity, but doesn't this tell a malicious user
> immediately that the account is locked and to move on to another user id to
> try?

Remote auth tools like ssh and SASL don't tell you that, they just say
"permission denied" (for pretty much this reason, I figure).

Martin
-- 
Martin Pitt                        | http://www.piware.de
Ubuntu Developer (www.ubuntu.com)  | Debian Developer  (www.debian.org)

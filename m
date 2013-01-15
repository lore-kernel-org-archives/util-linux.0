Return-Path: util-linux-owner@vger.kernel.org
Received: from 50-56-35-84.static.cloud-ips.com ([50.56.35.84]:56860 "EHLO
	mail.hallyn.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435Ab3AOSuS (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 15 Jan 2013 13:50:18 -0500
Date: Tue, 15 Jan 2013 18:51:40 +0000
From: "Serge E. Hallyn" <serge@hallyn.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org,
        Neil Horman <nhorman@tuxdriver.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: Re: [PATCH] nsenter: new command (light wrapper around setns)
Message-ID: <20130115185140.GA8285@mail.hallyn.com>
References: <876234812z.fsf@xmission.com>
 <20130111161320.GA16206@x2.net.home>
 <87fw27jq29.fsf_-_@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87fw27jq29.fsf_-_@xmission.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Quoting Eric W. Biederman (ebiederm@xmission.com):
> 
> Inspired by unshare, nsenter is a simple wrapper around setns that
> allows running a new process in the context of an existing process.
> 
> Full paths may be specified to the namespace arguments so that
> namespace file descriptors may be used wherever they reside in the
> filesystem.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Core code looks good, thanks

Acked-by: Serge Hallyn <serge.hallyn@canonical.com>

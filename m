Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:10984 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755527Ab3AYPEi (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 25 Jan 2013 10:04:38 -0500
Date: Fri, 25 Jan 2013 16:04:35 +0100
From: Karel Zak <kzak@redhat.com>
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Cc: util-linux@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 5/5] unshare: add --all meaning all namespaces
Message-ID: <20130125150435.GO27413@x2.net.home>
References: <1358750287-17732-1-git-send-email-zbyszek@in.waw.pl>
 <1358750287-17732-8-git-send-email-zbyszek@in.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1358750287-17732-8-git-send-email-zbyszek@in.waw.pl>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jan 21, 2013 at 01:38:07AM -0500, Zbigniew Jędrzejewski-Szmek wrote:
> Signed-off-by: Zbigniew Jędrzejewski-Szmek <zbyszek@in.waw.pl>
> ---
>  sys-utils/unshare.1 | 3 +++
>  sys-utils/unshare.c | 9 ++++++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)

 .. same like nsenter. Not applied.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

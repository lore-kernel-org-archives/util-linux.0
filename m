Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:3288 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751536Ab3AYOxA (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 25 Jan 2013 09:53:00 -0500
Date: Fri, 25 Jan 2013 15:52:53 +0100
From: Karel Zak <kzak@redhat.com>
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Cc: util-linux@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 1/5] nsenter: allow arguments to be specified in any order
Message-ID: <20130125145253.GK27413@x2.net.home>
References: <1358750287-17732-1-git-send-email-zbyszek@in.waw.pl>
 <1358750287-17732-2-git-send-email-zbyszek@in.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1358750287-17732-2-git-send-email-zbyszek@in.waw.pl>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jan 21, 2013 at 01:38:01AM -0500, Zbigniew Jędrzejewski-Szmek wrote:
> Allows 'nsenter -mt $PID', which would fail previously.
> 
> Signed-off-by: Zbigniew Jędrzejewski-Szmek <zbyszek@in.waw.pl>
> ---
>  sys-utils/nsenter.c | 55 ++++++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 46 insertions(+), 9 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

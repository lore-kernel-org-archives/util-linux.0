Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:49724 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755410Ab3AYPDE (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 25 Jan 2013 10:03:04 -0500
Date: Fri, 25 Jan 2013 16:02:55 +0100
From: Karel Zak <kzak@redhat.com>
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Cc: util-linux@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 3/5] nsenter: respect --exec no matter where it appears
Message-ID: <20130125150255.GM27413@x2.net.home>
References: <1358750287-17732-1-git-send-email-zbyszek@in.waw.pl>
 <1358750287-17732-4-git-send-email-zbyszek@in.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1358750287-17732-4-git-send-email-zbyszek@in.waw.pl>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jan 21, 2013 at 01:38:03AM -0500, Zbigniew Jędrzejewski-Szmek wrote:
>  sys-utils/nsenter.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

 It seems necessary for --all only, right?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

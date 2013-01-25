Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:37770 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754800Ab3AYPCN (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 25 Jan 2013 10:02:13 -0500
Date: Fri, 25 Jan 2013 16:02:10 +0100
From: Karel Zak <kzak@redhat.com>
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Cc: util-linux@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 2/5] nsenter: add --all meaning all namespaces and cwd
 and root
Message-ID: <20130125150210.GL27413@x2.net.home>
References: <1358750287-17732-1-git-send-email-zbyszek@in.waw.pl>
 <1358750287-17732-3-git-send-email-zbyszek@in.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1358750287-17732-3-git-send-email-zbyszek@in.waw.pl>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jan 21, 2013 at 01:38:02AM -0500, Zbigniew Jędrzejewski-Szmek wrote:
> I guess that most of the time one will want to enter all
> namespaces, and then it is easier not to have to remember
> all the option names.

 Not sure if this is the right argument. From my point of view it's
 better to be explicit for such things, something like --all sounds
 like a magical blackbox where semantic depends on features implemented
 by kernel and nsenter(1). 

 Not applied.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

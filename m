Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:25026 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934079Ab3BNNtF (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 14 Feb 2013 08:49:05 -0500
Date: Thu, 14 Feb 2013 14:48:57 +0100
From: Karel Zak <kzak@redhat.com>
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCHv2 1/2] unshare,nsenter: spawn shell by default
Message-ID: <20130214134857.GD19379@x2.net.home>
References: <20130213135212.GF7799@x2.net.home>
 <1360807549-26476-1-git-send-email-zbyszek@in.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1360807549-26476-1-git-send-email-zbyszek@in.waw.pl>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Feb 13, 2013 at 09:05:48PM -0500, Zbigniew Jędrzejewski-Szmek wrote:
>  include/exec_shell.h    |  1 +
>  lib/Makemodule.am       |  3 ++-
>  lib/exec_shell.c        | 27 +++++++++++++++++++++++++++
>  sys-utils/Makemodule.am |  1 +
>  sys-utils/nsenter.1     |  5 ++++-
>  sys-utils/nsenter.c     | 16 ++++++++--------
>  sys-utils/unshare.c     | 12 ++++++------
>  7 files changed, 49 insertions(+), 16 deletions(-)
>  create mode 100644 include/exec_shell.h
>  create mode 100644 lib/exec_shell.c

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
